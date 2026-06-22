Tournament :: {}.{
	tally : Str -> Try(Str, [InvalidRow(Str), InvalidResult(Str)])
	tally = |table| {
		if table == "" {
			Ok(header)
		} else {
			rows = table.split_on("\n")
			parsed_rows = 
				rows->map_try(
					|row| {
						match row.split_on(";") {
							[team1, team2, result_str] => {
								result = parse_result(result_str)?
								Ok((team1, team2, result))
							}
							_ => Err(InvalidRow(row))
						}
					},
				)?
			tally_dict = {
				parsed_rows.fold(
					Dict.empty(),
					|tally_dict_acc, triple| {
						(team1, team2, result) = triple
						tally_dict_acc
							->update_tally_dict(team1, result)
							->update_tally_dict(team2, opposite_result(result))
					},
				)
			}
			Ok(tally_dict_to_table(tally_dict))
		}
	}
}

MatchResult : [Win, Loss, Draw]

TeamTally : { mp : U64, w : U64, d : U64, l : U64, p : U64 }

parse_result : Str -> Try(MatchResult, [InvalidResult(Str), ..])
parse_result = |result_str| {
	match result_str {
		"win" => Ok(Win)
		"loss" => Ok(Loss)
		"draw" => Ok(Draw)
		_ => Err(InvalidResult(result_str))
	}
}

opposite_result : MatchResult -> MatchResult
opposite_result = |result| {
	match result {
		Win => Loss
		Loss => Win
		Draw => Draw
	}
}

update_tally_dict : Dict(Str, TeamTally), Str, MatchResult -> Dict(Str, TeamTally)
update_tally_dict = |tally_dict, team, result| {
	tally_dict
		.update(
			team,
			|maybe_team_tally| {
				match maybe_team_tally {
					Ok(team_tally) => Ok(update_team_tally(team_tally, result))
					Err(Missing) => Ok(update_team_tally({ mp: 0, w: 0, d: 0, l: 0, p: 0 }, result))
				}
			},
		)
}

update_team_tally : TeamTally, MatchResult -> TeamTally
update_team_tally = |team_tally, result| {
	match result {
		Win => { ..team_tally, mp: team_tally.mp + 1, w: team_tally.w + 1, p: team_tally.p + 3 }
		Draw => { ..team_tally, mp: team_tally.mp + 1, d: team_tally.d + 1, p: team_tally.p + 1 }
		Loss => { ..team_tally, mp: team_tally.mp + 1, l: team_tally.l + 1 }
	}
}

tally_dict_to_table : Dict(Str, TeamTally) -> Str
tally_dict_to_table = |tally_dict| {
	table_content = 
		tally_dict
			.to_list()
			.sort_with(
				|pair1, pair2| {
					(team1, team_tally1) = pair1
					(team2, team_tally2) = pair2
					p1 = team_tally1.p
					p2 = team_tally2.p
					if p1 < p2 {
						GT
					} else if p1 > p2 {
						LT
					} else {
						compare_strings(team1, team2)
					}
				},
			)
			.map(
				|pair| {
					(team, team_tally) = pair
					tally_columns = 
						[team_tally.mp, team_tally.w, team_tally.d, team_tally.l, team_tally.p]
							.map(align_right)
							->Str.join_with(" | ")
					"${pad_right(team, 30)} | ${tally_columns}"
				},
			)
			->Str.join_with("\n")
	"${header}\n${table_content}"
}

header : Str
header = "Team                           | MP |  W |  D |  L |  P"

compare_strings : Str, Str -> [LT, EQ, GT]
compare_strings = |string1, string2| {
	b1 = string1.to_utf8()
	b2 = string2.to_utf8()
	cmp_result = 
		List.map2(
			b1,
			b2,
			|c1, c2| if c1 < c2 {
				LT
			} else if c1 > c2 {
				GT
			} else {
				EQ
			},
		)
			.fold_until(
				EQ,
				|_, cmp| {
					match cmp {
						EQ => Continue(EQ)
						res => Break(res)
					}
				},
			)
	match cmp_result {
		EQ => {
			len1 = List.len(b1)
			len2 = List.len(b2)
			if len1 < len2 {
				LT
			} else if len1 > len2 {
				GT
			} else {
				EQ
			}
		}
		res => res
	}
}

pad_right : Str, U64 -> Str
pad_right = |string, width| {
	chars = string.to_utf8()
	length = chars.len()
	spaces = if length < width {
		List.repeat(" ", (width - length))->Str.join_with("")
	} else {
		""
	}
	"${string}${spaces}"
}

align_right : U64 -> Str
align_right = |number| {
	if number < 10 {
		" ${number.to_str()}"
	} else {
		"${number.to_str()}"
	}
}

# The following functions should soon be available in Roc's builtins
map_try = |iter, func| {
	var $state = []
	for item in iter {
		$state = $state.append(func(item)?)
	}
	Ok($state)
}
