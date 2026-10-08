Rational :: { num : I64, den : I64 }.{
	create : { num : I64, den : I64 } -> Rational
	create = |{ num, den }| {
		crash "Please implement the 'create' function"
	}

	plus : Rational, Rational -> Rational
	plus = |r1, r2| {
		crash "Please implement the 'plus' function"
	}

	minus : Rational, Rational -> Rational
	minus = |r1, r2| {
		crash "Please implement the 'minus' function"
	}

	times : Rational, Rational -> Rational
	times = |r1, r2| {
		crash "Please implement the 'times' function"
	}

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

	reduce : Rational -> Rational
	reduce = |r| {
		crash "Please implement the 'reduce' function"
	}

	# The following line enables the default `is_eq` implementation
	is_eq : _
}
