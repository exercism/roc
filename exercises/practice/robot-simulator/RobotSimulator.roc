RobotSimulator :: {}.{
	Direction : [North, East, South, West]
	Robot : { x : I64, y : I64, direction : Direction }

	move : Robot, Str -> Robot
	move = |robot, instructions| {
		crash "Please implement the 'move' function"
	}
}
