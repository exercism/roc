# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/space-age/canonical-data.json
# File last updated on 2026-06-13

import SpaceAge exposing [age]

# age on Earth
expect {
	result = age(Earth, 1000000000)
	Num.is_approx_eq(result, 31.69, { atol: 0.01 })
}

# age on Mercury
expect {
	result = age(Mercury, 2134835688)
	Num.is_approx_eq(result, 280.88, { atol: 0.01 })
}

# age on Venus
expect {
	result = age(Venus, 189839836)
	Num.is_approx_eq(result, 9.78, { atol: 0.01 })
}

# age on Mars
expect {
	result = age(Mars, 2129871239)
	Num.is_approx_eq(result, 35.88, { atol: 0.01 })
}

# age on Jupiter
expect {
	result = age(Jupiter, 901876382)
	Num.is_approx_eq(result, 2.41, { atol: 0.01 })
}

# age on Saturn
expect {
	result = age(Saturn, 2000000000)
	Num.is_approx_eq(result, 2.15, { atol: 0.01 })
}

# age on Uranus
expect {
	result = age(Uranus, 1210123456)
	Num.is_approx_eq(result, 0.46, { atol: 0.01 })
}

# age on Neptune
expect {
	result = age(Neptune, 1821023456)
	Num.is_approx_eq(result, 0.35, { atol: 0.01 })
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
