##
## Example solution
##

Triangle :: {}.{
	is_equilateral : (F64, F64, F64) -> Bool
	is_equilateral = |(a, b, c)| {
		is_valid_triangle((a, b, c)) and a.is_approx_eq(b, { abs: 1e-6, rel: 1e-6 }) and b.is_approx_eq(c, { abs: 1e-6, rel: 1e-6 })
	}

	is_isosceles : (F64, F64, F64) -> Bool
	is_isosceles = |(a, b, c)| {
		is_valid_triangle((a, b, c)) and (a.is_approx_eq(b, { abs: 1e-6, rel: 1e-6 }) or b.is_approx_eq(c, { abs: 1e-6, rel: 1e-6 }) or a.is_approx_eq(c, { abs: 1e-6, rel: 1e-6 }))
	}

	is_scalene : (F64, F64, F64) -> Bool
	is_scalene = |(a, b, c)| {
		is_valid_triangle((a, b, c)) and !(is_isosceles((a, b, c)))
	}
}

is_valid_triangle = |(a, b, c)| {
	a > 0 and b > 0 and c > 0 and a + b >= c and a + c >= b and b + c >= a
}
