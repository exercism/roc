# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/robot-simulator/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import RobotSimulator exposing [create, move]

##
## Create robot
##

# at origin facing north
expect
    result = create({})
    result == { x: 0, y: 0, direction: North }

# at negative position facing south
expect
    result = create({ x: -1, y: -1, direction: South })
    result == { x: -1, y: -1, direction: South }

##
## Rotating clockwise
##

# changes north to east
expect
    robot = create({})
    result = robot |> move("R")
    result == { x: 0, y: 0, direction: East }

# changes east to south
expect
    robot = create({ direction: East })
    result = robot |> move("R")
    result == { x: 0, y: 0, direction: South }

# changes south to west
expect
    robot = create({ direction: South })
    result = robot |> move("R")
    result == { x: 0, y: 0, direction: West }

# changes west to north
expect
    robot = create({ direction: West })
    result = robot |> move("R")
    result == { x: 0, y: 0, direction: North }

##
## Rotating counter-clockwise
##

# changes north to west
expect
    robot = create({})
    result = robot |> move("L")
    result == { x: 0, y: 0, direction: West }

# changes west to south
expect
    robot = create({ direction: West })
    result = robot |> move("L")
    result == { x: 0, y: 0, direction: South }

# changes south to east
expect
    robot = create({ direction: South })
    result = robot |> move("L")
    result == { x: 0, y: 0, direction: East }

# changes east to north
expect
    robot = create({ direction: East })
    result = robot |> move("L")
    result == { x: 0, y: 0, direction: North }

##
## Moving forward one
##

# facing north increments Y
expect
    robot = create({})
    result = robot |> move("A")
    result == { x: 0, y: 1, direction: North }

# facing south decrements Y
expect
    robot = create({ direction: South })
    result = robot |> move("A")
    result == { x: 0, y: -1, direction: South }

# facing east increments X
expect
    robot = create({ direction: East })
    result = robot |> move("A")
    result == { x: 1, y: 0, direction: East }

# facing west decrements X
expect
    robot = create({ direction: West })
    result = robot |> move("A")
    result == { x: -1, y: 0, direction: West }

##
## Follow series of instructions
##

# moving east and north from README
expect
    robot = create({ x: 7, y: 3 })
    result = robot |> move("RAALAL")
    result == { x: 9, y: 4, direction: West }

# moving west and north
expect
    robot = create({})
    result = robot |> move("LAAARALA")
    result == { x: -4, y: 1, direction: West }

# moving west and south
expect
    robot = create({ x: 2, y: -7, direction: East })
    result = robot |> move("RRAAAAALA")
    result == { x: -3, y: -8, direction: South }

# moving east and north
expect
    robot = create({ x: 8, y: 4, direction: South })
    result = robot |> move("LAAARRRALLLL")
    result == { x: 11, y: 5, direction: North }

