# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/connect/canonical-data.json
# File last updated on 2026-06-14

import Connect exposing [winner]

# an empty board has no winner
expect {
	board = 
		\\. . . . .
		\\ . . . . .
		\\  . . . . .
		\\   . . . . .
		\\    . . . . .

	result = board->winner()
	result == Err(NotFinished)
}

# X can win on a 1x1 board
expect {
	board = "X"
	result = board->winner()
	result == Ok(PlayerX)
}

# O can win on a 1x1 board
expect {
	board = "O"
	result = board->winner()
	result == Ok(PlayerO)
}

# only edges does not make a winner
expect {
	board = 
		\\O O O X
		\\ X . . X
		\\  X . . X
		\\   X O O O

	result = board->winner()
	result == Err(NotFinished)
}

# illegal diagonal does not make a winner
expect {
	board = 
		\\X O . .
		\\ O X X X
		\\  O X O .
		\\   . O X .
		\\    X X O O

	result = board->winner()
	result == Err(NotFinished)
}

# nobody wins crossing adjacent angles
expect {
	board = 
		\\X . . .
		\\ . X O .
		\\  O . X O
		\\   . O . X
		\\    . . O .

	result = board->winner()
	result == Err(NotFinished)
}

# X wins crossing from left to right
expect {
	board = 
		\\. O . .
		\\ O X X X
		\\  O X O .
		\\   X X O X
		\\    . O X .

	result = board->winner()
	result == Ok(PlayerX)
}

# O wins crossing from top to bottom
expect {
	board = 
		\\. O . .
		\\ O X X X
		\\  O O O .
		\\   X X O X
		\\    . O X .

	result = board->winner()
	result == Ok(PlayerO)
}

# X wins using a convoluted path
expect {
	board = 
		\\. X X . .
		\\ X . X . X
		\\  . X . X .
		\\   . X X . .
		\\    O O O O O

	result = board->winner()
	result == Ok(PlayerX)
}

# X wins using a spiral path
expect {
	board = 
		\\O X X X X X X X X
		\\ O X O O O O O O O
		\\  O X O X X X X X O
		\\   O X O X O O O X O
		\\    O X O X X X O X O
		\\     O X O O O X O X O
		\\      O X X X X X O X O
		\\       O O O O O O O X O
		\\        X X X X X X X X O

	result = board->winner()
	result == Ok(PlayerX)
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
