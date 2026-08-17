RobotSimulator :: {}.{
	Direction : [North, East, South, West]
	Robot : { x : I64, y : I64, direction : Direction }

	create : { x : I64 ?? 0, y : I64 ?? 0, direction : Direction ?? North } -> Robot
	create = |{ x, y, direction }| {
		crash "Please implement the 'create' function"
	}

	move : Robot, Str -> Robot
	move = |robot, instructions| {
		crash "Please implement the 'move' function"
	}
}
