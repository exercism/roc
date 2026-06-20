Say :: {}.{
	say : U64 -> Try(Str, [OutOfBounds])
	say = |number| {
		if number < 20 {
			Ok(zero_to_nineteen.get(number)?)
		} else if number < 100 {
			tens_word = tens_after_ten.get(number // 10 - 2)?
			digit = number % 10
			if digit > 0 {
				digit_word = say(digit)?
				Ok("${tens_word}-${digit_word}")
			} else {
				Ok(tens_word)
			}
		} else if number < 1_000_000_000_000 {
			words = 
				[
					(1_000_000_000_000, 1_000_000_000, "billion"),
					(1_000_000_000, 1_000_000, "million"),
					(1_000_000, 1000, "thousand"),
					(1000, 100, "hundred"),
					(100, 1, ""),
				]
					->keep_oks(
						|triple| {
							(modulo, divisor, name) = triple
							how_many = (number % modulo) // divisor
							if how_many == 0 {
								Err(NothingToSay)
							} else {
								say_how_many = say(how_many).map_err(|_| NothingToSay)?
								Ok("${say_how_many} ${name}")
							}
						},
					)
					->Str.join_with(" ")
					.trim_end()
			Ok(words)
		} else {
			Err(OutOfBounds)
		}
	}
}

zero_to_nineteen = [
	"zero",
	"one",
	"two",
	"three",
	"four",
	"five",
	"six",
	"seven",
	"eight",
	"nine",
	"ten",
	"eleven",
	"twelve",
	"thirteen",
	"fourteen",
	"fifteen",
	"sixteen",
	"seventeen",
	"eighteen",
	"nineteen",
]

tens_after_ten = [
	"twenty",
	"thirty",
	"forty",
	"fifty",
	"sixty",
	"seventy",
	"eighty",
	"ninety",
]

# The following functions should soon be available in Roc's builtins
keep_oks = |iter, func| {
	iter
		->join_map(
			|item| {
				match func(item) {
					Ok(result) => [result]
					Err(_) => []
				}
			},
		)
}

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
