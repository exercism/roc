Complex := { real : F64, imag : F64 }.{
	# # The user can write plus(z1, z2), z1.plus(z2), or simply z1 + z2
	plus : Complex, Complex -> Complex
	plus = |z1, z2| {
		crash "Please implement the 'plus' function"
	}

	# # The user can write minus(z1, z2), z1.minus(z2), or simply z1 - z2
	minus : Complex, Complex -> Complex
	minus = |z1, z2| {
		crash "Please implement the 'minus' function"
	}

	# # The user can write times(z1, z2), z1.times(z2), or simply z1 * z2
	times : Complex, Complex -> Complex
	times = |z1, z2| {
		crash "Please implement the 'times' function"
	}

	# # The user can write div_by(z1, z2), z1.div_by(z2), or simply z1 / z2
	div_by : Complex, Complex -> Complex
	div_by = |z1, z2| {
		crash "Please implement the 'div_by' function"
	}

	conjugate : Complex -> Complex
	conjugate = |z| {
		crash "Please implement the 'conjugate' function"
	}

	abs : Complex -> F64
	abs = |z| {
		crash "Please implement the 'abs' function"
	}

	exp : Complex -> Complex
	exp = |z| {
		crash "Please implement the 'exp' function"
	}
}
