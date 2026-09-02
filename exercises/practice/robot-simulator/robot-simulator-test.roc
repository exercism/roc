# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/robot-simulator/canonical-data.json
# File last updated on 2026-09-01

import Robot

##
## Create robot
##

# at origin facing north
expect {
	result = Robot.create(Robot.InitState.{}) # workaround https://github.com/roc-lang/roc/issues/11024
	result == { x: 0, y: 0, direction: North }
}

# at negative position facing south
expect {
	result = Robot.create({ x: -1, y: -1, direction: South })
	result == { x: -1, y: -1, direction: South }
}

##
## Rotating clockwise
##

# changes north to east
expect {
	robot = Robot.create(Robot.InitState.{}) # workaround https://github.com/roc-lang/roc/issues/11024
	result = robot.move("R")
	result == { x: 0, y: 0, direction: East }
}

# changes east to south
expect {
	robot = Robot.create({ direction: East })
	result = robot.move("R")
	result == { x: 0, y: 0, direction: South }
}

# changes south to west
expect {
	robot = Robot.create({ direction: South })
	result = robot.move("R")
	result == { x: 0, y: 0, direction: West }
}

# changes west to north
expect {
	robot = Robot.create({ direction: West })
	result = robot.move("R")
	result == { x: 0, y: 0, direction: North }
}

##
## Rotating counter-clockwise
##

# changes north to west
expect {
	robot = Robot.create(Robot.InitState.{}) # workaround https://github.com/roc-lang/roc/issues/11024
	result = robot.move("L")
	result == { x: 0, y: 0, direction: West }
}

# changes west to south
expect {
	robot = Robot.create({ direction: West })
	result = robot.move("L")
	result == { x: 0, y: 0, direction: South }
}

# changes south to east
expect {
	robot = Robot.create({ direction: South })
	result = robot.move("L")
	result == { x: 0, y: 0, direction: East }
}

# changes east to north
expect {
	robot = Robot.create({ direction: East })
	result = robot.move("L")
	result == { x: 0, y: 0, direction: North }
}

##
## Moving forward one
##

# facing north increments Y
expect {
	robot = Robot.create(Robot.InitState.{}) # workaround https://github.com/roc-lang/roc/issues/11024
	result = robot.move("A")
	result == { x: 0, y: 1, direction: North }
}

# facing south decrements Y
expect {
	robot = Robot.create({ direction: South })
	result = robot.move("A")
	result == { x: 0, y: -1, direction: South }
}

# facing east increments X
expect {
	robot = Robot.create({ direction: East })
	result = robot.move("A")
	result == { x: 1, y: 0, direction: East }
}

# facing west decrements X
expect {
	robot = Robot.create({ direction: West })
	result = robot.move("A")
	result == { x: -1, y: 0, direction: West }
}

##
## Follow series of instructions
##

# moving east and north from README
expect {
	robot = Robot.create({ x: 7, y: 3 })
	result = robot.move("RAALAL")
	result == { x: 9, y: 4, direction: West }
}

# moving west and north
expect {
	robot = Robot.create(Robot.InitState.{}) # workaround https://github.com/roc-lang/roc/issues/11024
	result = robot.move("LAAARALA")
	result == { x: -4, y: 1, direction: West }
}

# moving west and south
expect {
	robot = Robot.create({ x: 2, y: -7, direction: East })
	result = robot.move("RRAAAAALA")
	result == { x: -3, y: -8, direction: South }
}

# moving east and north
expect {
	robot = Robot.create({ x: 8, y: 4, direction: South })
	result = robot.move("LAAARRRALLLL")
	result == { x: 11, y: 5, direction: North }
}
