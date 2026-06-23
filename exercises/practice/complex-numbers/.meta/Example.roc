Complex := { real : F64, imaginary : F64 }.{
	complex : F64, F64 -> Complex
	complex = |real, imaginary| { { real, imaginary } }

	plus : Complex, Complex -> Complex
	plus = |{ real: a, imaginary: b }, { real: c, imaginary: d }| {
		{
			real: a + c,
			imaginary: b + d,
		}
	}

	minus : Complex, Complex -> Complex
	minus = |{ real: a, imaginary: b }, { real: c, imaginary: d }| {
		{
			real: a - c,
			imaginary: b - d,
		}
	}

	times : Complex, Complex -> Complex
	times = |{ real: a, imaginary: b }, { real: c, imaginary: d }| {
		{
			real: a * c - b * d,
			imaginary: a * d + b * c,
		}
	}

	div_by : Complex, Complex -> Complex
	div_by = |{ real: a, imaginary: b }, { real: c, imaginary: d }| {
		denominator = c * c + d * d
		{
			real: (a * c + b * d) / denominator,
			imaginary: (b * c - a * d) / denominator,
		}
	}

	conjugate : Complex -> Complex
	conjugate = |z| {
		{
			real: z.real,
			imaginary: -z.imaginary,
		}
	}

	abs : Complex -> F64
	abs = |{ real: a, imaginary: b }| {
		sqrt(a * a + b * b)
	}

	exp : Complex -> Complex
	exp = |z| {
		factor = e->pow(z.real)
		{
			real: factor * cos(z.imaginary),
			imaginary: factor * sin(z.imaginary),
		}
	}
}

# The following function should soon be available in Roc's builtins

e = 2.718281828459045.F64
pi = 3.141592653589793.F64

# Calculates the natural logarithm of x, ln(x).
ln : F64 -> F64
ln = |x| {
	if x <= 0.0 {
		# Natural log is undefined for zero and negative numbers
		crash "ln is undefined for zero or negative numbers"
	} else {
		var $norm_x = x
		var $log_offset = 0.0

		# Range reduction: keep x between [1/e, e]
		while $norm_x > e {
			$norm_x = $norm_x / e
			$log_offset = $log_offset + 1.0
		}
		while $norm_x < 1 / e {
			$norm_x = $norm_x * e
			$log_offset = $log_offset - 1.0
		}

		# Area hyperbolic tangent series
		z = ($norm_x - 1.0) / ($norm_x + 1.0)
		z2 = z * z
		var $z_term = z
		var $ln_sum = 0.0
		var $ln_n = 1.0

		for _ in 0..<30.U8 {
			$ln_sum = $ln_sum + ($z_term / $ln_n)
			$z_term = $z_term * z2
			$ln_n = $ln_n + 2.0
		}

		(2.0 * $ln_sum) + $log_offset
	}
}

# Calculates e^x using the Taylor series.
exp : F64 -> F64
exp = |x| {
	var $norm_x = x
	var $exp_mult = 1.0

	# Range reduction: keep x between [-1.0, 1.0]
	while $norm_x > 1.0 {
		$norm_x = $norm_x - 1.0
		$exp_mult = $exp_mult * e
	}
	while $norm_x < -1.0 {
		$norm_x = $norm_x + 1.0
		$exp_mult = $exp_mult / e
	}

	# Taylor series 
	var $exp_term = 1.0
	var $exp_sum = 1.0
	var $exp_n = 1.0

	for _ in 0..<25.U8 {
		$exp_term = $exp_term * $norm_x / $exp_n
		$exp_sum = $exp_sum + $exp_term
		$exp_n = $exp_n + 1.0
	}

	$exp_sum * $exp_mult
}

# Calculates x^p for 64-bit values using the newly separated functions.
pow : F64, F64 -> F64
pow = |x, p| {
	if x == 0.0 {
		if p == 0.0 {
			1.0
		} else {
			0.0
		}
	} else if x < 0.0 {
		# Fractional powers of negative numbers are undefined in pure real 64-bit math
		crash "Raising a negative number to a fractional power is undefined"
	} else if p == 0.0 {
		1.0
	} else {
		# The core mathematical calculation
		exp(p * ln(x))
	}
}

# cos uses the Taylor series expansion.
# We first normalize `x` to the [-PI, PI] range to ensure rapid, stable convergence.
cos : F64 -> F64
cos = |x| {
	var $norm_x = x
	while $norm_x > pi {
		$norm_x = $norm_x - 2 * pi
	}
	while $norm_x < -pi {
		$norm_x = $norm_x + 2 * pi
	}

	var $term = 1.0
	var $sum = 1.0
	var $n = 0.0

	# 20 iterations is more than enough for F64 precision in this range
	for _ in 0..<20.U8 {
		$term = {
			-($term) * $norm_x * $norm_x / (($n + 1.0) * ($n + 2.0))
		}
		$sum = $sum + $term
		$n = $n + 2.0
	}

	$sum
}

# sin uses the Taylor series expansion.
sin : F64 -> F64
sin = |x| {
	var $norm_x = x
	while $norm_x > pi {
		$norm_x = $norm_x - 2 * pi
	}
	while $norm_x < -pi {
		$norm_x = $norm_x + 2 * pi
	}

	var $term = $norm_x
	var $sum = $norm_x
	var $n = 1.0

	for _ in 0..<20.U8 {
		$term = {
			-($term) * $norm_x * $norm_x / (($n + 1.0) * ($n + 2.0))
		}
		$sum = $sum + $term
		$n = $n + 2.0
	}

	$sum
}

# sqrt uses the Babylonian method (Newton-Raphson approach).
sqrt : F64 -> F64
sqrt = |x| {
	if x <= 0.0 {
		0.0
	} else {
		var $guess = x / 2.0

		# 25 iterations will aggressively converge for almost all F64 values
		for _ in 0..<25.U8 {
			$guess = ($guess + (x / $guess)) / 2.0
		}

		$guess
	}
}
