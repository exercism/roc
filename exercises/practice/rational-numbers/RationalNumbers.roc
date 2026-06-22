RationalNumbers :: {}.{
	Rational : { num : I64, den : I64 }

	add : Rational, Rational -> Rational
	add = |r1, r2| {
		crash "Please implement the 'add' function"
	}

	sub : Rational, Rational -> Rational
	sub = |r1, r2| {
		crash "Please implement the 'sub' function"
	}

	mul : Rational, Rational -> Rational
	mul = |r1, r2| {
		crash "Please implement the 'mul' function"
	}

	div : Rational, Rational -> Rational
	div = |r1, r2| {
		crash "Please implement the 'div' function"
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
}
