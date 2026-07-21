# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/space-age/canonical-data.json
# File last updated on 2026-06-22

import SpaceAge exposing [age]

# age on Earth
expect {
	result = age(Earth, 1000000000)
	is_approx_eq(result, 31.69, { atol: 0.01 })
}

# age on Mercury
expect {
	result = age(Mercury, 2134835688)
	is_approx_eq(result, 280.88, { atol: 0.01 })
}

# age on Venus
expect {
	result = age(Venus, 189839836)
	is_approx_eq(result, 9.78, { atol: 0.01 })
}

# age on Mars
expect {
	result = age(Mars, 2129871239)
	is_approx_eq(result, 35.88, { atol: 0.01 })
}

# age on Jupiter
expect {
	result = age(Jupiter, 901876382)
	is_approx_eq(result, 2.41, { atol: 0.01 })
}

# age on Saturn
expect {
	result = age(Saturn, 2000000000)
	is_approx_eq(result, 2.15, { atol: 0.01 })
}

# age on Uranus
expect {
	result = age(Uranus, 1210123456)
	is_approx_eq(result, 0.46, { atol: 0.01 })
}

# age on Neptune
expect {
	result = age(Neptune, 1821023456)
	is_approx_eq(result, 0.35, { atol: 0.01 })
}

# The following function should soon be available in Roc's builtins
is_approx_eq : Dec, Dec, { atol : Dec } -> Bool
is_approx_eq = |x, y, { atol }| {
	to_int : Dec -> Try(I64, [OutOfRange])
	to_int = |f| {
		(f / atol + 0.5).to_i64_try()
	}

	match (to_int(x), to_int(y)) {
		(Ok(xi), Ok(yi)) => (xi == yi)
		_ => Bool.False
	}
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
