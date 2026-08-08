Rational :: { num : I64, den : I64 }.{
	new : { num : I64, den : I64 } -> Rational
	new = |{ num, den }| {
		crash "Please implement the 'new' function"
	}

	# # The user can write plus(r1, r2), r1.plus(r2), or simply r1 + r2
	plus : Rational, Rational -> Rational
	plus = |r1, r2| {
		crash "Please implement the 'plus' function"
	}

	# # The user can write minus(r1, r2), r1.minus(r2), or simply r1 - r2
	minus : Rational, Rational -> Rational
	minus = |r1, r2| {
		crash "Please implement the 'minus' function"
	}

	# # The user can write times(r1, r2), r1.times(r2), or simply r1 * r2
	times : Rational, Rational -> Rational
	times = |r1, r2| {
		crash "Please implement the 'times' function"
	}

	# # The user can write div_by(r1, r2), r1.div_by(r2), or simply r1 / r2
	div_by : Rational, Rational -> Rational
	div_by = |r1, r2| {
		crash "Please implement the 'div_by' function"
	}

	abs : Rational -> Rational
	abs = |r| {
		crash "Please implement the 'abs' function"
	}

	exp : Rational, I64 -> Rational
	exp = |r, n| {
		crash "Please implement the 'exp' function"
	}

	exp_real : F64, Rational -> F64
	exp_real = |x, r| {
		crash "Please implement the 'exp_real' function"
	}

	# # Reduce a rational number to its lowest terms, e.g., 6 / 8 --> 3 / 4
	reduce : Rational -> Rational
	reduce = |r| {
		crash "Please implement the 'reduce' function"
	}

	# The following line enables the default `is_eq` implementation
	is_eq : _
}
