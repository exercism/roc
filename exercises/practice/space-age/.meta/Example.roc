SpaceAge :: {}.{
	Planet := [
		Mercury,
		Venus,
		Earth,
		Mars,
		Jupiter,
		Saturn,
		Uranus,
		Neptune,
	]

	age : Planet, Dec -> Dec
	age = |planet, seconds| {
		period_in_earth_years = orbital_period_in_earth_years(planet)
		period_in_seconds = period_in_earth_years * 365.25 * 24 * 60 * 60
		planet_years = seconds / period_in_seconds
		round(planet_years)
	}
}

orbital_period_in_earth_years = |planet| {
	match planet {
		Mercury => 0.2408467
		Venus => 0.61519726
		Earth => 1.0
		Mars => 1.8808158
		Jupiter => 11.862615
		Saturn => 29.447498
		Uranus => 84.016846
		Neptune => 164.79132
	}
}

# The following function will soon be available in Roc's builtins
round : Dec -> Dec
round = |value| {
	pow = 100.0
	(
		(value * pow + 0.5).to_u64_try() ?? {
			crash "Unreachable"
		},
	).to_dec() / pow
}
