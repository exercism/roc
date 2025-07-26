# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/bowling/canonical-data.json
# File last updated on 2025-07-26
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Bowling exposing [Game, create, roll, score]

replay_game : List U64 -> Result Game _
replay_game = |rolls|
    new_game = create({})?
    rolls
    |> List.walk_until(
        Ok(new_game),
        |state, pins|
            when state is
                Ok(game) ->
                    when game |> roll(pins) is
                        Ok(updated_game) -> Continue(Ok(updated_game))
                        Err(err) -> Break(Err(err))

                Err(_) -> crash "Impossible, we don't start or Continue with an Err",
    )

# should be able to score a game with all zeros
expect
    maybe_game = create { previous_rolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
    result = maybe_game |> Result.try(|game| score(game))
    result == Ok(0)

# should be able to replay this finished game from the start
expect
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    result = replay_game rolls
    result |> Result.is_ok

# should be able to score a game with no strikes or spares
expect
    maybe_game = create { previous_rolls: [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6] }
    result = maybe_game |> Result.try(|game| score(game))
    result == Ok(90)

# should be able to replay this finished game from the start
expect
    rolls = [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6]
    result = replay_game rolls
    result |> Result.is_ok

# a spare followed by zeros is worth ten points
expect
    maybe_game = create { previous_rolls: [6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
    result = maybe_game |> Result.try(|game| score(game))
    result == Ok(10)

# should be able to replay this finished game from the start
expect
    rolls = [6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    result = replay_game rolls
    result |> Result.is_ok

# points scored in the roll after a spare are counted twice
expect
    maybe_game = create { previous_rolls: [6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
    result = maybe_game |> Result.try(|game| score(game))
    result == Ok(16)

# should be able to replay this finished game from the start
expect
    rolls = [6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    result = replay_game rolls
    result |> Result.is_ok

# consecutive spares each get a one roll bonus
expect
    maybe_game = create { previous_rolls: [5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
    result = maybe_game |> Result.try(|game| score(game))
    result == Ok(31)

# should be able to replay this finished game from the start
expect
    rolls = [5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    result = replay_game rolls
    result |> Result.is_ok

# a spare in the last frame gets a one roll bonus that is counted once
expect
    maybe_game = create { previous_rolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7] }
    result = maybe_game |> Result.try(|game| score(game))
    result == Ok(17)

# should be able to replay this finished game from the start
expect
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7]
    result = replay_game rolls
    result |> Result.is_ok

# a strike earns ten points in a frame with a single roll
expect
    maybe_game = create { previous_rolls: [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
    result = maybe_game |> Result.try(|game| score(game))
    result == Ok(10)

# should be able to replay this finished game from the start
expect
    rolls = [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    result = replay_game rolls
    result |> Result.is_ok

# points scored in the two rolls after a strike are counted twice as a bonus
expect
    maybe_game = create { previous_rolls: [10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
    result = maybe_game |> Result.try(|game| score(game))
    result == Ok(26)

# should be able to replay this finished game from the start
expect
    rolls = [10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    result = replay_game rolls
    result |> Result.is_ok

# consecutive strikes each get the two roll bonus
expect
    maybe_game = create { previous_rolls: [10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
    result = maybe_game |> Result.try(|game| score(game))
    result == Ok(81)

# should be able to replay this finished game from the start
expect
    rolls = [10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    result = replay_game rolls
    result |> Result.is_ok

# a strike in the last frame gets a two roll bonus that is counted once
expect
    maybe_game = create { previous_rolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1] }
    result = maybe_game |> Result.try(|game| score(game))
    result == Ok(18)

# should be able to replay this finished game from the start
expect
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1]
    result = replay_game rolls
    result |> Result.is_ok

# rolling a spare with the two roll bonus does not get a bonus roll
expect
    maybe_game = create { previous_rolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3] }
    result = maybe_game |> Result.try(|game| score(game))
    result == Ok(20)

# should be able to replay this finished game from the start
expect
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3]
    result = replay_game rolls
    result |> Result.is_ok

# strikes with the two roll bonus do not get bonus rolls
expect
    maybe_game = create { previous_rolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10] }
    result = maybe_game |> Result.try(|game| score(game))
    result == Ok(30)

# should be able to replay this finished game from the start
expect
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10]
    result = replay_game rolls
    result |> Result.is_ok

# last two strikes followed by only last bonus with non strike points
expect
    maybe_game = create { previous_rolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 1] }
    result = maybe_game |> Result.try(|game| score(game))
    result == Ok(31)

# should be able to replay this finished game from the start
expect
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 1]
    result = replay_game rolls
    result |> Result.is_ok

# a strike with the one roll bonus after a spare in the last frame does not get a bonus
expect
    maybe_game = create { previous_rolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10] }
    result = maybe_game |> Result.try(|game| score(game))
    result == Ok(20)

# should be able to replay this finished game from the start
expect
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10]
    result = replay_game rolls
    result |> Result.is_ok

# all strikes is a perfect game
expect
    maybe_game = create { previous_rolls: [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10] }
    result = maybe_game |> Result.try(|game| score(game))
    result == Ok(300)

# should be able to replay this finished game from the start
expect
    rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
    result = replay_game rolls
    result |> Result.is_ok

# a roll cannot score more than 10 points
expect
    maybe_game = create { previous_rolls: [] }
    result =
        maybe_game
        |> Result.try(
            |game|
                game |> roll(11),
        )
    result |> Result.is_err

# two rolls in a frame cannot score more than 10 points
expect
    maybe_game = create { previous_rolls: [5] }
    result =
        maybe_game
        |> Result.try(
            |game|
                game |> roll(6),
        )
    result |> Result.is_err

# bonus roll after a strike in the last frame cannot score more than 10 points
expect
    maybe_game = create { previous_rolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10] }
    result =
        maybe_game
        |> Result.try(
            |game|
                game |> roll(11),
        )
    result |> Result.is_err

# two bonus rolls after a strike in the last frame cannot score more than 10 points
expect
    maybe_game = create { previous_rolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 5] }
    result =
        maybe_game
        |> Result.try(
            |game|
                game |> roll(6),
        )
    result |> Result.is_err

# two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike
expect
    maybe_game = create { previous_rolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6] }
    result = maybe_game |> Result.try(|game| score(game))
    result == Ok(26)

# should be able to replay this finished game from the start
expect
    rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6]
    result = replay_game rolls
    result |> Result.is_ok

# the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike
expect
    maybe_game = create { previous_rolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 6] }
    result =
        maybe_game
        |> Result.try(
            |game|
                game |> roll(10),
        )
    result |> Result.is_err

# second bonus roll after a strike in the last frame cannot score more than 10 points
expect
    maybe_game = create { previous_rolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10] }
    result =
        maybe_game
        |> Result.try(
            |game|
                game |> roll(11),
        )
    result |> Result.is_err

# an unstarted game cannot be scored
expect
    maybe_game = create { previous_rolls: [] }
    result = maybe_game |> Result.try(|game| score(game))
    result |> Result.is_err

# an incomplete game cannot be scored
expect
    maybe_game = create { previous_rolls: [0, 0] }
    result = maybe_game |> Result.try(|game| score(game))
    result |> Result.is_err

# cannot roll if game already has ten frames
expect
    maybe_game = create { previous_rolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
    result =
        maybe_game
        |> Result.try(
            |game|
                game |> roll(0),
        )
    result |> Result.is_err

# bonus rolls for a strike in the last frame must be rolled before score can be calculated
expect
    maybe_game = create { previous_rolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10] }
    result = maybe_game |> Result.try(|game| score(game))
    result |> Result.is_err

# both bonus rolls for a strike in the last frame must be rolled before score can be calculated
expect
    maybe_game = create { previous_rolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10] }
    result = maybe_game |> Result.try(|game| score(game))
    result |> Result.is_err

# bonus roll for a spare in the last frame must be rolled before score can be calculated
expect
    maybe_game = create { previous_rolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3] }
    result = maybe_game |> Result.try(|game| score(game))
    result |> Result.is_err

# cannot roll after bonus roll for spare
expect
    maybe_game = create { previous_rolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 2] }
    result =
        maybe_game
        |> Result.try(
            |game|
                game |> roll(2),
        )
    result |> Result.is_err

# cannot roll after bonus rolls for strike
expect
    maybe_game = create { previous_rolls: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 3, 2] }
    result =
        maybe_game
        |> Result.try(
            |game|
                game |> roll(2),
        )
    result |> Result.is_err

