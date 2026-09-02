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
		crash "Please implement the 'age' function"
	}
}

# The following function will soon be available in Roc's builtins
round : Dec, { step : Dec } -> Dec
round = |value, { step }| {
	((value / step).round_to_i128().to_dec_try() ?? crash "Unreachable") * step
}
