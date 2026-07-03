Complex := { real : F64, imag : F64 }.{
	# # The user can write plus(z1, z2), z1.plus(z2), or simply z1 + z2
	plus : Complex, Complex -> Complex
	plus = |{ real: a, imag: b }, { real: c, imag: d }| {
		{
			real: a + c,
			imag: b + d,
		}
	}

	# # The user can write minus(z1, z2), z1.minus(z2), or simply z1 - z2
	minus : Complex, Complex -> Complex
	minus = |{ real: a, imag: b }, { real: c, imag: d }| {
		{
			real: a - c,
			imag: b - d,
		}
	}

	# # The user can write times(z1, z2), z1.times(z2), or simply z1 * z2
	times : Complex, Complex -> Complex
	times = |{ real: a, imag: b }, { real: c, imag: d }| {
		{
			real: a * c - b * d,
			imag: a * d + b * c,
		}
	}

	# # The user can write div_by(z1, z2), z1.div_by(z2), or simply z1 / z2
	div_by : Complex, Complex -> Complex
	div_by = |{ real: a, imag: b }, { real: c, imag: d }| {
		denominator = c * c + d * d
		{
			real: (a * c + b * d) / denominator,
			imag: (b * c - a * d) / denominator,
		}
	}

	conjugate : Complex -> Complex
	conjugate = |z| {
		{
			real: z.real,
			imag: -z.imag,
		}
	}

	abs : Complex -> F64
	abs = |{ real: a, imag: b }| {
		(a * a + b * b).sqrt()
	}

	exp : Complex -> Complex
	exp = |z| {
		factor = F64.e.pow(z.real)
		{
			real: factor * z.imag.cos(),
			imag: factor * z.imag.sin(),
		}
	}
}
