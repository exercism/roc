# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/bowling/canonical-data.json
# File last updated on 2026-06-13

import Bowling

game_with_previous_rolls : List(U64) -> Try(Bowling, _)
game_with_previous_rolls = |rolls| {
	new_game = Bowling.new
	rolls.fold_until(
		Ok(new_game),
		|state, pins| {
			match state {
				Ok(game) => {
					match game.roll(pins) {
						Ok(updated_game) => Continue(Ok(updated_game))
						Err(err) => Break(Err(err))
					}
				}
				Err(_) => {
					crash "Impossible, we don't start or continue with an Err"
				}
			}
		},
	)
}

# should be able to score a game with all zeros
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result == Ok(0)
}

# should be able to replay this finished game from the start
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	result = game_with_previous_rolls(rolls)
	result.is_ok()
}

# should be able to score a game with no strikes or spares
expect {
	rolls = [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result == Ok(90)
}

# should be able to replay this finished game from the start
expect {
	rolls = [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6]
	result = game_with_previous_rolls(rolls)
	result.is_ok()
}

# a spare followed by zeros is worth ten points
expect {
	rolls = [6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result == Ok(10)
}

# should be able to replay this finished game from the start
expect {
	rolls = [6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	result = game_with_previous_rolls(rolls)
	result.is_ok()
}

# points scored in the roll after a spare are counted twice
expect {
	rolls = [6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result == Ok(16)
}

# should be able to replay this finished game from the start
expect {
	rolls = [6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	result = game_with_previous_rolls(rolls)
	result.is_ok()
}

# consecutive spares each get a one roll bonus
expect {
	rolls = [5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result == Ok(31)
}

# should be able to replay this finished game from the start
expect {
	rolls = [5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	result = game_with_previous_rolls(rolls)
	result.is_ok()
}

# a spare in the last frame gets a one roll bonus that is counted once
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result == Ok(17)
}

# should be able to replay this finished game from the start
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7]
	result = game_with_previous_rolls(rolls)
	result.is_ok()
}

# a strike earns ten points in a frame with a single roll
expect {
	rolls = [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result == Ok(10)
}

# should be able to replay this finished game from the start
expect {
	rolls = [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	result = game_with_previous_rolls(rolls)
	result.is_ok()
}

# points scored in the two rolls after a strike are counted twice as a bonus
expect {
	rolls = [10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result == Ok(26)
}

# should be able to replay this finished game from the start
expect {
	rolls = [10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	result = game_with_previous_rolls(rolls)
	result.is_ok()
}

# consecutive strikes each get the two roll bonus
expect {
	rolls = [10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result == Ok(81)
}

# should be able to replay this finished game from the start
expect {
	rolls = [10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	result = game_with_previous_rolls(rolls)
	result.is_ok()
}

# a strike in the last frame gets a two roll bonus that is counted once
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result == Ok(18)
}

# should be able to replay this finished game from the start
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1]
	result = game_with_previous_rolls(rolls)
	result.is_ok()
}

# rolling a spare with the two roll bonus does not get a bonus roll
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result == Ok(20)
}

# should be able to replay this finished game from the start
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3]
	result = game_with_previous_rolls(rolls)
	result.is_ok()
}

# strikes with the two roll bonus do not get bonus rolls
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result == Ok(30)
}

# should be able to replay this finished game from the start
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10]
	result = game_with_previous_rolls(rolls)
	result.is_ok()
}

# last two strikes followed by only last bonus with non strike points
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 1]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result == Ok(31)
}

# should be able to replay this finished game from the start
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 1]
	result = game_with_previous_rolls(rolls)
	result.is_ok()
}

# a strike with the one roll bonus after a spare in the last frame does not get a bonus
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result == Ok(20)
}

# should be able to replay this finished game from the start
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10]
	result = game_with_previous_rolls(rolls)
	result.is_ok()
}

# all strikes is a perfect game
expect {
	rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result == Ok(300)
}

# should be able to replay this finished game from the start
expect {
	rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
	result = game_with_previous_rolls(rolls)
	result.is_ok()
}

# a roll cannot score more than 10 points
expect {
	rolls = []
	game = game_with_previous_rolls(rolls)?
	result = game.roll(11)
	result.is_err()
}

# two rolls in a frame cannot score more than 10 points
expect {
	rolls = [5]
	game = game_with_previous_rolls(rolls)?
	result = game.roll(6)
	result.is_err()
}

# bonus roll after a strike in the last frame cannot score more than 10 points
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10]
	game = game_with_previous_rolls(rolls)?
	result = game.roll(11)
	result.is_err()
}

# two bonus rolls after a strike in the last frame cannot score more than 10 points
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 5]
	game = game_with_previous_rolls(rolls)?
	result = game.roll(6)
	result.is_err()
}

# two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result == Ok(26)
}

# should be able to replay this finished game from the start
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6]
	result = game_with_previous_rolls(rolls)
	result.is_ok()
}

# the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 6]
	game = game_with_previous_rolls(rolls)?
	result = game.roll(10)
	result.is_err()
}

# second bonus roll after a strike in the last frame cannot score more than 10 points
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10]
	game = game_with_previous_rolls(rolls)?
	result = game.roll(11)
	result.is_err()
}

# an unstarted game cannot be scored
expect {
	rolls = []
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result.is_err()
}

# an incomplete game cannot be scored
expect {
	rolls = [0, 0]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result.is_err()
}

# cannot roll if game already has ten frames
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	game = game_with_previous_rolls(rolls)?
	result = game.roll(0)
	result.is_err()
}

# bonus rolls for a strike in the last frame must be rolled before score can be calculated
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result.is_err()
}

# both bonus rolls for a strike in the last frame must be rolled before score can be calculated
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result.is_err()
}

# bonus roll for a spare in the last frame must be rolled before score can be calculated
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3]
	game = game_with_previous_rolls(rolls)?
	result = game.score()
	result.is_err()
}

# cannot roll after bonus roll for spare
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 2]
	game = game_with_previous_rolls(rolls)?
	result = game.roll(2)
	result.is_err()
}

# cannot roll after bonus rolls for strike
expect {
	rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 3, 2]
	game = game_with_previous_rolls(rolls)?
	result = game.roll(2)
	result.is_err()
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
