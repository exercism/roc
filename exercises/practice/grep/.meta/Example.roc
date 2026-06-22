import "iliad.txt" as iliad : Str
import "midsummer-night.txt" as midsummer_night : Str
import "paradise-lost.txt" as paradise_lost : Str

Grep :: {}.{
	grep : Str, List(Str), List(Str) -> Try(Str, _)
	grep = |pattern, flags, file_names| {
		config = parse_flags(flags)?
		files = collect_files(file_names)?
		display_file_names = files.len() > 1
		files
			->join_map(
				|file| {
					match find_matches(config, pattern, file.text) {
						[] => []
						_ if config.display_file_names => [file.name]
						matches => {
							matches.map(
								|match_info| {
									{ line, index } = match_info
									line_number = 
										if config.display_line_numbers {
											"${(index + 1).to_str()}:"
										} else {
											""
										}
									file_name = 
										if display_file_names {
											"${file.name}:"
										} else {
											""
										}
									"${file_name}${line_number}${line}"
								},
							)
						}
					}
				},
			)
			->Str.join_with("\n")
			->Ok()
	}
}

find_matches : Config, Str, Str -> List({ line : Str, index : U64 })
find_matches = |config, pattern, text| {
	text.split_on("\n")
		.map_with_index(|line, index| { line, index })
		.keep_if(
			|match_info| {
				{ line, index: _ } = match_info
				(line_to_match, pattern_to_match) = 
					if config.ignore_case {
						(to_lower(line), to_lower(pattern))
					} else {
						(line, pattern)
					}

				matches = 
					if config.match_full_lines {
						line_to_match == pattern_to_match
					} else {
						line_to_match.contains(pattern_to_match)
					}

				# Using != is equivalent to xor which inverts `matches`
				config.invert_results != matches
			},
		)
}

to_lower : Str -> Str
to_lower = |str| {
	str.to_utf8()
		.map(
			|byte| {
				if 'A' <= byte and byte <= 'Z' {
					byte - 'A' + 'a'
				} else {
					byte
				}
			},
		)
		->Str.from_utf8()
		?? ""
}

Config : {
	display_line_numbers : Bool,
	display_file_names : Bool,
	ignore_case : Bool,
	match_full_lines : Bool,
	invert_results : Bool,
}

parse_flags : List(Str) -> Try(Config, _)
parse_flags = |flags| {
	default_config = {
		display_line_numbers: Bool.False,
		display_file_names: Bool.False,
		ignore_case: Bool.False,
		match_full_lines: Bool.False,
		invert_results: Bool.False,
	}
	List.fold_until(
		flags,
		Ok(default_config),
		|config_res, flag| {
			match config_res {
				Ok(config) => {
					match flag {
						"-l" => Continue(Ok({ ..config, display_file_names: Bool.True }))
						"-n" => Continue(Ok({ ..config, display_line_numbers: Bool.True }))
						"-i" => Continue(Ok({ ..config, ignore_case: Bool.True }))
						"-x" => Continue(Ok({ ..config, match_full_lines: Bool.True }))
						"-v" => Continue(Ok({ ..config, invert_results: Bool.True }))
						_ => Break(Err(UnknownFlag(flag)))
					}
				}
				Err(err) => Break(Err(err))
			}
		},
	)
}

collect_files : List(Str) -> Try(List({ name : Str, text : Str }), _)
collect_files = |names| {
	names->map_try(
		|name| {
			match name {
				"midsummer-night.txt" => Ok({ name: "midsummer-night.txt", text: midsummer_night })
				"iliad.txt" => Ok({ name: "iliad.txt", text: iliad })
				"paradise-lost.txt" => Ok({ name: "paradise-lost.txt", text: paradise_lost })
				_ => Err(FileNotFound(name))
			}
		},
	)
}

# The following functions should soon be available in Roc's builtins
join_map = |iter, func| {
	var $state = []
	for item in iter {
		for subitem in func(item) {
			$state = $state.append(subitem)
		}
	}
	$state
}

map_try = |iter, func| {
	var $state = []
	for item in iter {
		$state = $state.append(func(item)?)
	}
	Ok($state)
}
