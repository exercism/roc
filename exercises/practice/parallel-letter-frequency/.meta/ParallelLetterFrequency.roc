##
## Example solution
##

import pf.Parallel
import unicode.Case
import unicode.GeneralCategory
import unicode.Scalar

ParallelLetterFrequency :: {}.{
	calculate_frequencies! : { texts : List(Str), workers : U64 } => Try(Dict(Str, U64), [ParallelError([InvalidWorkerCount]), UnicodeError(Case.Error)])
	calculate_frequencies! = |{ texts, workers }| {
		results = texts |> Parallel.map!({ workers, task: count_letters }) ? ParallelError
		frequencies = results.fold_try(
			Dict.empty(),
			|total, result| {
				counts = result?
				Ok(
					counts.to_list().fold(
						total,
						|merged, (letter, count)| {
							merged.insert(letter, (merged.get(letter) ?? 0) + count)
						},
					),
				)
			},
		) ? UnicodeError
		Ok(frequencies)
	}
}

count_letters : Str -> Try(Dict(Str, U64), Case.Error)
count_letters = |text| {
	lowercase = Case.to_lower(text, Case.unicode_default, Case.unlimited_limits)?
	Scalar.iter(lowercase.text).fold(
		Ok(Dict.empty()),
		|result, item| {
			counts = result?
			match GeneralCategory.of_scalar(item.scalar) {
				Lu | Ll | Lt | Lm | Lo => {
					letter = Scalar.to_str(item.scalar) ? |_| InternalEncodingFault
					Ok(counts.insert(letter, (counts.get(letter) ?? 0) + 1))
				}
				_ => Ok(counts)
			}
		},
	)
}
