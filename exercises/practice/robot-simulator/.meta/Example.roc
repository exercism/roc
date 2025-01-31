module [create, move]

Direction : [North, East, South, West]
Robot : { x : I64, y : I64, direction : Direction }

create : { x ?? I64, y ?? I64, direction ?? Direction } -> Robot
create = |{ x ?? 0, y ?? 0, direction ?? North }|
    { x, y, direction }

move : Robot, Str -> Robot
move = |robot, instructions|
    instructions
    |> Str.to_utf8
    |> List.walk(
        robot,
        |{ x, y, direction }, command|
            when command is
                'R' ->
                    when direction is
                        North -> { x, y, direction: East }
                        East -> { x, y, direction: South }
                        South -> { x, y, direction: West }
                        West -> { x, y, direction: North }

                'L' ->
                    when direction is
                        North -> { x, y, direction: West }
                        East -> { x, y, direction: North }
                        South -> { x, y, direction: East }
                        West -> { x, y, direction: South }

                'A' ->
                    when direction is
                        North -> { x, y: y + 1, direction }
                        East -> { x: x + 1, y, direction }
                        South -> { x, y: y - 1, direction }
                        West -> { x: x - 1, y, direction }

                _ -> { x, y, direction },
    ) # invalid instructions are ignored

