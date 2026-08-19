# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/save-the-cow/canonical-data.json
# File last updated on 2026-08-18

import SaveTheCow exposing [guess]

# Initially 9 failures are allowed and no letters are guessed
expect {
	result = guess("loot", [])
	result == Ok({ outcome: Ongoing, masked_word: "____", remaining_failures: 9 })
}

# After 10 failures the game is over
expect {
	result = guess("loot", ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'])
	result == Ok({ outcome: Lose, masked_word: "____", remaining_failures: 0 })
}

# Losing with several correct guesses
expect {
	result = guess("loot", ['t', 'o', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'])
	result == Ok({ outcome: Lose, masked_word: "_oot", remaining_failures: 0 })
}

# Feeding a correct letter removes underscores
expect {
	result = guess("loot", ['t'])
	result == Ok({ outcome: Ongoing, masked_word: "___t", remaining_failures: 9 })
}

# Feeding a correct letter twice counts as a failure
expect {
	result = guess("loot", ['t', 't'])
	result == Ok({ outcome: Ongoing, masked_word: "___t", remaining_failures: 8 })
}

# Guessing a repeated letter reveals all instances
expect {
	result = guess("loot", ['t', 't', 'o'])
	result == Ok({ outcome: Ongoing, masked_word: "_oot", remaining_failures: 8 })
}

# Getting all the letters right makes for a win
expect {
	result = guess("loot", ['t', 't', 'o', 'l'])
	result == Ok({ outcome: Win, masked_word: "loot", remaining_failures: 8 })
}

# Winning on the last guess is still a win
expect {
	result = guess("loot", ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 't', 'o', 'l'])
	result == Ok({ outcome: Win, masked_word: "loot", remaining_failures: 0 })
}

# Guessing after a lose is error
expect {
	result = guess("loot", ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k'])
	result.is_err()
}

# Guessing after a win is error
expect {
	result = guess("loot", ['t', 'o', 'l', 'l'])
	result.is_err()
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
