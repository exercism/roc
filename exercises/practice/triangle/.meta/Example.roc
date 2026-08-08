Triangle :: {}.{
	is_equilateral : (F64, F64, F64) -> Bool
	is_equilateral = |(a, b, c)| {
		is_valid_triangle((a, b, c)) and is_approx_eq(a, b) and is_approx_eq(b, c)
	}

	is_isosceles : (F64, F64, F64) -> Bool
	is_isosceles = |(a, b, c)| {
		is_valid_triangle((a, b, c)) and (is_approx_eq(a, b) or is_approx_eq(b, c) or is_approx_eq(a, c))
	}

	is_scalene : (F64, F64, F64) -> Bool
	is_scalene = |(a, b, c)| {
		is_valid_triangle((a, b, c)) and !(is_isosceles((a, b, c)))
	}
}

is_valid_triangle = |(a, b, c)| {
	a > 0 and b > 0 and c > 0 and a + b >= c and a + c >= b and b + c >= a
}

# The following function should soon be available in Roc's builtins
is_approx_eq : F64, F64 -> Bool
is_approx_eq = |x, y| {
	to_int : F64 -> Try(I64, [OutOfRange])
	to_int = |f| {
		(f * 1e6).to_i64_try()
	}

	match (to_int(x), to_int(y)) {
		(Ok(xi), Ok(yi)) => (xi == yi)
		_ => Bool.False
	}
}
