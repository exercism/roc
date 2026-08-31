Robot :: { x : I64, y : I64, direction : Direction }.{
	Direction : [North, East, South, West]

	InitState := { x : I64 ?? 0, y : I64 ?? 0, direction : Direction ?? North }

	create : InitState -> Robot
	create = |{ x, y, direction }| {
		crash "Please implement the 'create' function"
	}

	move : Robot, Str -> Robot
	move = |robot, instructions| {
		crash "Please implement the 'move' function"
	}

	# The following line enables the default `is_eq` implementation
	is_eq : _
}
