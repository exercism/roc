# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/bowling/canonical-data.json
# File last updated on 2024-09-23
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import Bowling exposing [Game, create, roll, score]

replayGame : List U64 -> Result Game _
replayGame = \rolls ->
    newGame = create? {}
    rolls
    |> List.walkUntil (Ok newGame) \state, pins ->
        when state is
            Ok game ->
                when game |> roll pins is
                    Ok updatedGame -> Continue (Ok updatedGame)
                    Err err -> Break (Err err)

            Err _ -> crash "Impossible, we don't start or Continue with an Err"

# should be able to score a game with all zeros
expect
    maybeGame = create { previousRolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
    result = maybeGame |> Result.try \game -> score game
    result == Ok 0

# should be able to replay this finished game from the start
expect
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    result = replayGame rolls
    result |> Result.isOk

# should be able to score a game with no strikes or spares
expect
    maybeGame = create { previousRolls: [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6] }
    result = maybeGame |> Result.try \game -> score game
    result == Ok 90

# should be able to replay this finished game from the start
expect
    rolls = [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6]
    result = replayGame rolls
    result |> Result.isOk

# a spare followed by zeros is worth ten points
expect
    maybeGame = create { previousRolls: [6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
    result = maybeGame |> Result.try \game -> score game
    result == Ok 10

# should be able to replay this finished game from the start
expect
    rolls = [6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    result = replayGame rolls
    result |> Result.isOk

# points scored in the roll after a spare are counted twice
expect
    maybeGame = create { previousRolls: [6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
    result = maybeGame |> Result.try \game -> score game
    result == Ok 16

# should be able to replay this finished game from the start
expect
    rolls = [6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    result = replayGame rolls
    result |> Result.isOk

# consecutive spares each get a one roll bonus
expect
    maybeGame = create { previousRolls: [5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
    result = maybeGame |> Result.try \game -> score game
    result == Ok 31

# should be able to replay this finished game from the start
expect
    rolls = [5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    result = replayGame rolls
    result |> Result.isOk

# a spare in the last frame gets a one roll bonus that is counted once
expect
    maybeGame = create { previousRolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7] }
    result = maybeGame |> Result.try \game -> score game
    result == Ok 17

# should be able to replay this finished game from the start
expect
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7]
    result = replayGame rolls
    result |> Result.isOk

# a strike earns ten points in a frame with a single roll
expect
    maybeGame = create { previousRolls: [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
    result = maybeGame |> Result.try \game -> score game
    result == Ok 10

# should be able to replay this finished game from the start
expect
    rolls = [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    result = replayGame rolls
    result |> Result.isOk

# points scored in the two rolls after a strike are counted twice as a bonus
expect
    maybeGame = create { previousRolls: [10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
    result = maybeGame |> Result.try \game -> score game
    result == Ok 26

# should be able to replay this finished game from the start
expect
    rolls = [10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    result = replayGame rolls
    result |> Result.isOk

# consecutive strikes each get the two roll bonus
expect
    maybeGame = create { previousRolls: [10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
    result = maybeGame |> Result.try \game -> score game
    result == Ok 81

# should be able to replay this finished game from the start
expect
    rolls = [10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    result = replayGame rolls
    result |> Result.isOk

# a strike in the last frame gets a two roll bonus that is counted once
expect
    maybeGame = create { previousRolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1] }
    result = maybeGame |> Result.try \game -> score game
    result == Ok 18

# should be able to replay this finished game from the start
expect
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1]
    result = replayGame rolls
    result |> Result.isOk

# rolling a spare with the two roll bonus does not get a bonus roll
expect
    maybeGame = create { previousRolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3] }
    result = maybeGame |> Result.try \game -> score game
    result == Ok 20

# should be able to replay this finished game from the start
expect
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3]
    result = replayGame rolls
    result |> Result.isOk

# strikes with the two roll bonus do not get bonus rolls
expect
    maybeGame = create { previousRolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10] }
    result = maybeGame |> Result.try \game -> score game
    result == Ok 30

# should be able to replay this finished game from the start
expect
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10]
    result = replayGame rolls
    result |> Result.isOk

# last two strikes followed by only last bonus with non strike points
expect
    maybeGame = create { previousRolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 1] }
    result = maybeGame |> Result.try \game -> score game
    result == Ok 31

# should be able to replay this finished game from the start
expect
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 1]
    result = replayGame rolls
    result |> Result.isOk

# a strike with the one roll bonus after a spare in the last frame does not get a bonus
expect
    maybeGame = create { previousRolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10] }
    result = maybeGame |> Result.try \game -> score game
    result == Ok 20

# should be able to replay this finished game from the start
expect
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10]
    result = replayGame rolls
    result |> Result.isOk

# all strikes is a perfect game
expect
    maybeGame = create { previousRolls: [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10] }
    result = maybeGame |> Result.try \game -> score game
    result == Ok 300

# should be able to replay this finished game from the start
expect
    rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
    result = replayGame rolls
    result |> Result.isOk

# a roll cannot score more than 10 points
expect
    maybeGame = create { previousRolls: [] }
    result =
        maybeGame
        |> Result.try \game ->
            game |> roll 11
    result |> Result.isErr

# two rolls in a frame cannot score more than 10 points
expect
    maybeGame = create { previousRolls: [5] }
    result =
        maybeGame
        |> Result.try \game ->
            game |> roll 6
    result |> Result.isErr

# bonus roll after a strike in the last frame cannot score more than 10 points
expect
    maybeGame = create { previousRolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10] }
    result =
        maybeGame
        |> Result.try \game ->
            game |> roll 11
    result |> Result.isErr

# two bonus rolls after a strike in the last frame cannot score more than 10 points
expect
    maybeGame = create { previousRolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 5] }
    result =
        maybeGame
        |> Result.try \game ->
            game |> roll 6
    result |> Result.isErr

# two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike
expect
    maybeGame = create { previousRolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6] }
    result = maybeGame |> Result.try \game -> score game
    result == Ok 26

# should be able to replay this finished game from the start
expect
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6]
    result = replayGame rolls
    result |> Result.isOk

# the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike
expect
    maybeGame = create { previousRolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 6] }
    result =
        maybeGame
        |> Result.try \game ->
            game |> roll 10
    result |> Result.isErr

# second bonus roll after a strike in the last frame cannot score more than 10 points
expect
    maybeGame = create { previousRolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10] }
    result =
        maybeGame
        |> Result.try \game ->
            game |> roll 11
    result |> Result.isErr

# an unstarted game cannot be scored
expect
    maybeGame = create { previousRolls: [] }
    result = maybeGame |> Result.try \game -> score game
    result |> Result.isErr

# an incomplete game cannot be scored
expect
    maybeGame = create { previousRolls: [0, 0] }
    result = maybeGame |> Result.try \game -> score game
    result |> Result.isErr

# cannot roll if game already has ten frames
expect
    maybeGame = create { previousRolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
    result =
        maybeGame
        |> Result.try \game ->
            game |> roll 0
    result |> Result.isErr

# bonus rolls for a strike in the last frame must be rolled before score can be calculated
expect
    maybeGame = create { previousRolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10] }
    result = maybeGame |> Result.try \game -> score game
    result |> Result.isErr

# both bonus rolls for a strike in the last frame must be rolled before score can be calculated
expect
    maybeGame = create { previousRolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10] }
    result = maybeGame |> Result.try \game -> score game
    result |> Result.isErr

# bonus roll for a spare in the last frame must be rolled before score can be calculated
expect
    maybeGame = create { previousRolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3] }
    result = maybeGame |> Result.try \game -> score game
    result |> Result.isErr

# cannot roll after bonus roll for spare
expect
    maybeGame = create { previousRolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 2] }
    result =
        maybeGame
        |> Result.try \game ->
            game |> roll 2
    result |> Result.isErr

# cannot roll after bonus rolls for strike
expect
    maybeGame = create { previousRolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 3, 2] }
    result =
        maybeGame
        |> Result.try \game ->
            game |> roll 2
    result |> Result.isErr

