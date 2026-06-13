# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/leap/canonical-data.json
# File last updated on 2026-06-13

import Leap exposing [is_leap_year]

# year not divisible by 4 in common year
expect {
	result = is_leap_year(2015)
	result == Bool.False
}

# year divisible by 2, not divisible by 4 in common year
expect {
	result = is_leap_year(1970)
	result == Bool.False
}

# year divisible by 4, not divisible by 100 in leap year
expect {
	result = is_leap_year(1996)
	result == Bool.True
}

# year divisible by 4 and 5 is still a leap year
expect {
	result = is_leap_year(1960)
	result == Bool.True
}

# year divisible by 100, not divisible by 400 in common year
expect {
	result = is_leap_year(2100)
	result == Bool.False
}

# year divisible by 100 but not by 3 is still not a leap year
expect {
	result = is_leap_year(1900)
	result == Bool.False
}

# year divisible by 400 is leap year
expect {
	result = is_leap_year(2000)
	result == Bool.True
}

# year divisible by 400 but not by 125 is still a leap year
expect {
	result = is_leap_year(2400)
	result == Bool.True
}

# year divisible by 200, not divisible by 400 in common year
expect {
	result = is_leap_year(1800)
	result == Bool.False
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
