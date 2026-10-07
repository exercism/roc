# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/space-age/canonical-data.json
# File last updated on 2026-10-07

import SpaceAge exposing [age]

# age on Earth
expect {
	result = age(Earth, 1000000000)
	result.is_approx_eq(31.69, { abs: 0.01, rel: 0 })
}

# age on Mercury
expect {
	result = age(Mercury, 2134835688)
	result.is_approx_eq(280.88, { abs: 0.01, rel: 0 })
}

# age on Venus
expect {
	result = age(Venus, 189839836)
	result.is_approx_eq(9.78, { abs: 0.01, rel: 0 })
}

# age on Mars
expect {
	result = age(Mars, 2129871239)
	result.is_approx_eq(35.88, { abs: 0.01, rel: 0 })
}

# age on Jupiter
expect {
	result = age(Jupiter, 901876382)
	result.is_approx_eq(2.41, { abs: 0.01, rel: 0 })
}

# age on Saturn
expect {
	result = age(Saturn, 2000000000)
	result.is_approx_eq(2.15, { abs: 0.01, rel: 0 })
}

# age on Uranus
expect {
	result = age(Uranus, 1210123456)
	result.is_approx_eq(0.46, { abs: 0.01, rel: 0 })
}

# age on Neptune
expect {
	result = age(Neptune, 1821023456)
	result.is_approx_eq(0.35, { abs: 0.01, rel: 0 })
}
