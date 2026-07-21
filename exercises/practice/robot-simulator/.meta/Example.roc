RobotSimulator :: {}.{
	Direction : [North, East, South, West]
	Robot : { x : I64, y : I64, direction : Direction }

	move : Robot, Str -> Robot
	move = |robot, instructions| {
		instructions
			.to_utf8()
			.fold(
				robot,
				|{ x, y, direction }, command| {
					match command {
						'R' => {
							match direction {
								North => { x, y, direction: East }
								East => { x, y, direction: South }
								South => { x, y, direction: West }
								West => { x, y, direction: North }
							}
						}

						'L' => {
							match direction {
								North => { x, y, direction: West }
								East => { x, y, direction: North }
								South => { x, y, direction: East }
								West => { x, y, direction: South }
							}
						}

						'A' => {
							match direction {
								North => { x, y: y + 1, direction }
								East => { x: x + 1, y, direction }
								South => { x, y: y - 1, direction }
								West => { x: x - 1, y, direction }
							}
						}

						_ => { x, y, direction }
					}
				},
			)
	}
}
