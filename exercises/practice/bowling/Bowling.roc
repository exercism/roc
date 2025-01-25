module [Game, create, roll, score]

Game := {
    # TODO: change this opaque type however you need
    todo : U64,
    todo2 : U64,
    todo3 : U64,
    # etc.
}

create : { previous_rolls ?? List U64 } -> Result Game _
create = |{ previous_rolls ?? [] }|
    crash("Please implement the 'create' function")

roll : Game, U64 -> Result Game _
roll = |game, pins|
    crash("Please implement the 'roll' function")

score : Game -> Result U64 _
score = |finished_game|
    crash("Please implement the 'score' function")
