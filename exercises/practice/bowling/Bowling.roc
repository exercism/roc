module [Game, create, roll, score]

Game := {
    # TODO: change this opaque type however you need
    todo : U64,
    todo2 : U64,
    todo3 : U64,
    # etc.
}

create : { previousRolls ? List U64 } -> Result Game _
create = \{ previousRolls ? [] } ->
    crash "Please implement the 'create' function"

roll : Game, U64 -> Result Game _
roll = \game, pins ->
    crash "Please implement the 'roll' function"

score : Game -> Result U64 _
score = \finishedGame ->
    crash "Please implement the 'score' function"
