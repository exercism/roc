module [create, move]

Direction : [North, East, South, West]
Robot : { x : I64, y : I64, direction : Direction }

create : { x ? I64, y ? I64, direction ? Direction } -> Robot
create = \{ x ? 0, y ? 0, direction ? North } ->
    crash "Please implement the 'create' function"

move : Robot, Str -> Robot
move = \robot, instructions ->
    crash "Please implement the 'move' function"
