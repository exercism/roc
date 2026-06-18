# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/robot-simulator/canonical-data.json
# File last updated on 2026-06-18

import RobotSimulator exposing [move]

##
## Rotating clockwise
##

# changes north to east
expect {
	robot = { x: 0, y: 0, direction: North }
	result = robot->move("R")
	result == { x: 0, y: 0, direction: East }
}

# changes east to south
expect {
	robot = { x: 0, y: 0, direction: East }
	result = robot->move("R")
	result == { x: 0, y: 0, direction: South }
}

# changes south to west
expect {
	robot = { x: 0, y: 0, direction: South }
	result = robot->move("R")
	result == { x: 0, y: 0, direction: West }
}

# changes west to north
expect {
	robot = { x: 0, y: 0, direction: West }
	result = robot->move("R")
	result == { x: 0, y: 0, direction: North }
}

##
## Rotating counter-clockwise
##

# changes north to west
expect {
	robot = { x: 0, y: 0, direction: North }
	result = robot->move("L")
	result == { x: 0, y: 0, direction: West }
}

# changes west to south
expect {
	robot = { x: 0, y: 0, direction: West }
	result = robot->move("L")
	result == { x: 0, y: 0, direction: South }
}

# changes south to east
expect {
	robot = { x: 0, y: 0, direction: South }
	result = robot->move("L")
	result == { x: 0, y: 0, direction: East }
}

# changes east to north
expect {
	robot = { x: 0, y: 0, direction: East }
	result = robot->move("L")
	result == { x: 0, y: 0, direction: North }
}

##
## Moving forward one
##

# facing north increments Y
expect {
	robot = { x: 0, y: 0, direction: North }
	result = robot->move("A")
	result == { x: 0, y: 1, direction: North }
}

# facing south decrements Y
expect {
	robot = { x: 0, y: 0, direction: South }
	result = robot->move("A")
	result == { x: 0, y: -1, direction: South }
}

# facing east increments X
expect {
	robot = { x: 0, y: 0, direction: East }
	result = robot->move("A")
	result == { x: 1, y: 0, direction: East }
}

# facing west decrements X
expect {
	robot = { x: 0, y: 0, direction: West }
	result = robot->move("A")
	result == { x: -1, y: 0, direction: West }
}

##
## Follow series of instructions
##

# moving east and north from README
expect {
	robot = { x: 7, y: 3, direction: North }
	result = robot->move("RAALAL")
	result == { x: 9, y: 4, direction: West }
}

# moving west and north
expect {
	robot = { x: 0, y: 0, direction: North }
	result = robot->move("LAAARALA")
	result == { x: -4, y: 1, direction: West }
}

# moving west and south
expect {
	robot = { x: 2, y: -7, direction: East }
	result = robot->move("RRAAAAALA")
	result == { x: -3, y: -8, direction: South }
}

# moving east and north
expect {
	robot = { x: 8, y: 4, direction: South }
	result = robot->move("LAAARRRALLLL")
	result == { x: 11, y: 5, direction: North }
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
