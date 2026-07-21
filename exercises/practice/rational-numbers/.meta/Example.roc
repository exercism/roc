Rational :: { num : I64, den : I64 }.{
	new : { num : I64, den : I64 } -> Rational
	new = |{ num, den }| {
		{ num, den }->reduce()
	}

	# # The user can write plus(r1, r2), r1.plus(r2), or simply r1 + r2
	plus : Rational, Rational -> Rational
	plus = |{ num: num1, den: den1 }, { num: num2, den: den2 }| {
		{ num: num1 * den2 + num2 * den1, den: den1 * den2 }->reduce()
	}

	# # The user can write minus(r1, r2), r1.minus(r2), or simply r1 - r2
	minus : Rational, Rational -> Rational
	minus = |{ num: num1, den: den1 }, { num: num2, den: den2 }| {
		{ num: num1 * den2 - num2 * den1, den: den1 * den2 }->reduce()
	}

	# # The user can write times(r1, r2), r1.times(r2), or simply r1 * r2
	times : Rational, Rational -> Rational
	times = |{ num: num1, den: den1 }, { num: num2, den: den2 }| {
		{ num: num1 * num2, den: den1 * den2 }->reduce()
	}

	# # The user can write div_by(r1, r2), r1.div_by(r2), or simply r1 / r2
	div_by : Rational, Rational -> Rational
	div_by = |{ num: num1, den: den1 }, { num: num2, den: den2 }| {
		{ num: num1 * den2, den: num2 * den1 }->reduce()
	}

	abs : Rational -> Rational
	abs = |{ num, den }| {
		{ num: num.abs(), den: den.abs() }->reduce()
	}

	exp : Rational, I64 -> Rational
	exp = |{ num, den }, n| {
		match n {
			0 => { num: 1, den: 1 }
			pos if pos > 0 => { num: pow_int(num, pos), den: pow_int(den, pos) }->reduce()
			neg => {
				m = neg.abs()
				{ num: pow_int(den, m), den: pow_int(num, m) }->reduce()
			}
		}
	}

	exp_real : F64, Rational -> F64
	exp_real = |x, { num, den }| {
		f : F64
		f = num.to_f64() / den.to_f64()
		x.pow(f)
	}

	# # Reduce a rational number to its lowest terms, e.g., 6 / 8 --> 3 / 4
	reduce : Rational -> Rational
	reduce = |{ num, den }| {
		gcd = |m, n| if n == 0 {
			m
		} else {
			gcd(n, (m % n))
		}
		sign = |n| if n < 0 {
			-1
		} else {
			1
		}
		abs_num = num.abs()
		abs_den = den.abs()
		d = gcd(abs_num, abs_den)
		{ num: sign(num) * sign(den) * abs_num // d, den: abs_den // d }
	}

	# The following line enables the default `is_eq` implementation
	is_eq : _
}

pow_int : I64, I64 -> I64
pow_int = |number, pow| {
	(1..=pow).fold(
		1,
		|acc, _| {
			acc * number
		},
	)
}

# The following functions should soon be available in Roc's builtins

# Calculates the natural logarithm of x, ln(x).
log : F64 -> F64
log = |x| {
	if x <= 0.0 {
		# Natural log is undefined for zero and negative numbers
		crash "log is undefined for zero or negative numbers"
	} else {
		var $norm_x = x
		var $log_offset = 0.0

		# Range reduction: keep x between [1/e, e]
		while $norm_x > F64.e {
			$norm_x = $norm_x / F64.e
			$log_offset = $log_offset + 1.0
		}
		while $norm_x < 1 / F64.e {
			$norm_x = $norm_x * F64.e
			$log_offset = $log_offset - 1.0
		}

		# Area hyperbolic tangent series
		z = ($norm_x - 1.0) / ($norm_x + 1.0)
		z2 = z * z
		var $z_term = z
		var $log_sum = 0.0
		var $log_n = 1.0

		for _ in 0..<30.U8 {
			$log_sum = $log_sum + ($z_term / $log_n)
			$z_term = $z_term * z2
			$log_n = $log_n + 2.0
		}

		(2.0 * $log_sum) + $log_offset
	}
}
