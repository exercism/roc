##
## Example solution
##

Resistor := {
    resistance : [Ohms(Dec), Kiloohms(Dec), Megaohms(Dec), Gigaohms(Dec)]
    tolerance ?: Dec,
}.{
	Color : [
        Silver,
        Gold,
		Black,
		Brown,
		Red,
		Orange,
		Yellow,
		Green,
		Blue,
		Violet,
		Grey,
		White,
	]

    label_decoder : List(Color) -> Try(Resistor, _)
    label_decoder = |colors| {
        match colors {
            [] => Err(ResistorWithoutColors)
            [Black] => Ok({ resistance: Ohms(0) })
            [_] => Err(ResistorWithOneNonBlackColor)
            [_, _] => Err(InvalidNumberOfColors(2))
            [_, _, _] => Err(InvalidNumberOfColors(3))
            [c1, c2, mul, tol] => build_resistor(Black, c1, c2, mul, tol)
            [c1, c2, c3, mul, tol] => build_resistor(c1, c2, c3, mul, tol)
            _ => Err(InvalidNumberOfColors(colors.len()))
        }
    }

	# The following line enables the default `is_eq` implementation
	is_eq : _
}

color_multiplier = |color| {
    match color {
        Silver => -2
        Gold => -1
		Black => 0
		Brown => 1
		Red => 2
		Orange => 3
		Yellow => 4
		Green => 5
		Blue => 6
		Violet => 7
		Grey => 8
		White => 9
    }
}

color_value = |color| {
    value = color_multiplier(color)
    if value < 0 { Err(InvalidColorForValue) } else { Ok(value) }
}

color_tolerance = |color| {
    match color {
        Grey => Ok(0.05)
        Violet => Ok(0.1)
        Blue => Ok(0.25)
        Green => Ok(0.5)
        Brown => Ok(1)
        Red => Ok(2)
        Gold => Ok(5)
        Silver => Ok(10)
        Black | Orange | Yellow | White => Err(InvalidToleranceColor)
    }
}

build_resistor = |c1, c2, c3, mul, tol| {
    value = color_value(c1)? * 100 + color_value(c2)? * 10 + color_value(c3)?
    multiplier = Dec.pow(10, color_multiplier(mul))
    raw_resistance = value * multiplier
    resistance = if raw_resistance < 1e3 {
        Ohms(raw_resistance)
    } else if raw_resistance < 1e6 {
        Kiloohms(raw_resistance / 1e3)
    } else if raw_resistance < 1e9 {
        Megaohms(raw_resistance / 1e6)
    } else {
        Gigaohms(raw_resistance / 1e9)
    }
    tolerance = color_tolerance(tol)?
    Ok({ resistance, tolerance })
}
