ComplexNumbers :: {}.{
	Complex := { re : F64, im : F64 }

	real : Complex -> F64
	real = |z| z.re

	imaginary : Complex -> F64
	imaginary = |z| z.im

	add : Complex, Complex -> Complex
	add = |{ re: a, im: b }, { re: c, im: d }| {
		{
			re: a + c,
			im: b + d,
		}
	}

	sub : Complex, Complex -> Complex
	sub = |{ re: a, im: b }, { re: c, im: d }| {
		{
			re: a - c,
			im: b - d,
		}
	}

	mul : Complex, Complex -> Complex
	mul = |{ re: a, im: b }, { re: c, im: d }| {
		{
			re: a * c - b * d,
			im: a * d + b * c,
		}
	}

	div : Complex, Complex -> Complex
	div = |{ re: a, im: b }, { re: c, im: d }| {
		denominator = c * c + d * d
		{
			re: (a * c + b * d) / denominator,
			im: (b * c - a * d) / denominator,
		}
	}

	conjugate : Complex -> Complex
	conjugate = |z| {
		{
			re: z.re,
			im: -z.im,
		}
	}

	abs : Complex -> F64
	abs = |{ re: a, im: b }| {
		sqrt(a * a + b * b)
	}

	exp : Complex -> Complex
	exp = |z| {
		e = 2.718281828459045
		factor = e->pow(z.re)
		{
			re: factor * cos(z.im),
			im: factor * sin(z.im),
		}
	}
}

# The following function should soon be available in Roc's builtins

# Calculates the natural logarithm of x, ln(x).
ln = |x| {
	if x <= 0.0 {
		# Natural log is undefined for zero and negative numbers
		crash "ln is undefined for zero or negative numbers"
	} else {
		var $norm_x = x
		var $log_offset = 0.0

		e_val = 2.718281828459045
		inv_e = 0.36787944117144233

		# Range reduction: keep x between [1/e, e]
		while $norm_x > e_val {
			$norm_x = $norm_x / e_val
			$log_offset = $log_offset + 1.0
		}
		while $norm_x < inv_e {
			$norm_x = $norm_x * e_val
			$log_offset = $log_offset - 1.0
		}

		# Area hyperbolic tangent series
		z = ($norm_x - 1.0) / ($norm_x + 1.0)
		z2 = z * z
		var $z_term = z
		var $ln_sum = 0.0
		var $ln_n = 1.0

		var $i = 0
		while $i < 30 {
			$ln_sum = $ln_sum + ($z_term / $ln_n)
			$z_term = $z_term * z2
			$ln_n = $ln_n + 2.0
			$i = $i + 1
		}

		(2.0 * $ln_sum) + $log_offset
	}
}

# Calculates e^x using the Taylor series.
exp = |x| {
	var $norm_x = x
	var $exp_mult = 1.0
	e_val = 2.718281828459045

	# Range reduction: keep x between [-1.0, 1.0]
	while $norm_x > 1.0 {
		$norm_x = $norm_x - 1.0
		$exp_mult = $exp_mult * e_val
	}
	while $norm_x < -1.0 {
		$norm_x = $norm_x + 1.0
		$exp_mult = $exp_mult / e_val
	}

	# Taylor series 
	var $exp_term = 1.0
	var $exp_sum = 1.0
	var $exp_n = 1.0

	var $j = 0
	while $j < 25 {
		$exp_term = $exp_term * $norm_x / $exp_n
		$exp_sum = $exp_sum + $exp_term
		$exp_n = $exp_n + 1.0
		$j = $j + 1
	}

	$exp_sum * $exp_mult
}

# Calculates x^p for F64 values using the newly separated functions.
pow = |x, p| {
	if x == 0.0 {
		if p == 0.0 {
			1.0
		} else {
			0.0
		}
	} else if x < 0.0 {
		# Fractional powers of negative numbers are undefined in pure real F64 math
		0.0
	} else if p == 0.0 {
		1.0
	} else {
		# The core mathematical calculation
		exp(p * ln(x))
	}
}

# cos uses the Taylor series expansion.
# We first normalize `x` to the [-PI, PI] range to ensure rapid, stable convergence.
cos = |x| {
	var $norm_x = x
	while $norm_x > 3.141592653589793 {
		$norm_x = $norm_x - 6.283185307179586
	}
	while $norm_x < -3.141592653589793 {
		$norm_x = $norm_x + 6.283185307179586
	}

	var $term = 1.0
	var $sum = 1.0
	var $n = 0.0

	# 20 iterations is more than enough for F64 precision in this range
	var $i = 0
	while $i < 20 {
		$term = {
			-($term) * $norm_x * $norm_x / (($n + 1.0) * ($n + 2.0))
		}
		$sum = $sum + $term
		$n = $n + 2.0
		$i = $i + 1
	}

	$sum
}

# sin uses the Taylor series expansion.
sin = |x| {
	var $norm_x = x
	while $norm_x > 3.141592653589793 {
		$norm_x = $norm_x - 6.283185307179586
	}
	while $norm_x < -3.141592653589793 {
		$norm_x = $norm_x + 6.283185307179586
	}

	var $term = $norm_x
	var $sum = $norm_x
	var $n = 1.0

	var $i = 0
	while $i < 20 {
		$term = {
			-($term) * $norm_x * $norm_x / (($n + 1.0) * ($n + 2.0))
		}
		$sum = $sum + $term
		$n = $n + 2.0
		$i = $i + 1
	}

	$sum
}

# sqrt uses the Babylonian method (Newton-Raphson approach).
sqrt = |x| {
	if x <= 0.0 {
		0.0
	} else {
		var $guess = x / 2.0
		var $i = 0

		# 25 iterations will aggressively converge for almost all F64 values
		while $i < 25 {
			$guess = ($guess + (x / $guess)) / 2.0
			$i = $i + 1
		}

		$guess
	}
}
