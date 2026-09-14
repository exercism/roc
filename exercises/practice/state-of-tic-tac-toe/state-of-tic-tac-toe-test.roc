# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/state-of-tic-tac-toe/canonical-data.json
# File last updated on 2026-08-31

import TicTacToe

# Finished game where X won via left column victory
expect {
	game = TicTacToe.create(((X, O, O), (X, Empty, Empty), (X, Empty, Empty)))?
	game.state() == Win
}

# Finished game where X won via middle column victory
expect {
	game = TicTacToe.create(((O, X, O), (Empty, X, Empty), (Empty, X, Empty)))?
	game.state() == Win
}

# Finished game where X won via right column victory
expect {
	game = TicTacToe.create(((O, O, X), (Empty, Empty, X), (Empty, Empty, X)))?
	game.state() == Win
}

# Finished game where O won via left column victory
expect {
	game = TicTacToe.create(((O, X, X), (O, X, Empty), (O, Empty, Empty)))?
	game.state() == Win
}

# Finished game where O won via middle column victory
expect {
	game = TicTacToe.create(((X, O, X), (Empty, O, X), (Empty, O, Empty)))?
	game.state() == Win
}

# Finished game where O won via right column victory
expect {
	game = TicTacToe.create(((X, X, O), (Empty, X, O), (Empty, Empty, O)))?
	game.state() == Win
}

# Finished game where X won via top row victory
expect {
	game = TicTacToe.create(((X, X, X), (X, O, O), (O, Empty, Empty)))?
	game.state() == Win
}

# Finished game where X won via middle row victory
expect {
	game = TicTacToe.create(((O, Empty, Empty), (X, X, X), (Empty, O, Empty)))?
	game.state() == Win
}

# Finished game where X won via bottom row victory
expect {
	game = TicTacToe.create(((Empty, O, O), (O, Empty, X), (X, X, X)))?
	game.state() == Win
}

# Finished game where O won via top row victory
expect {
	game = TicTacToe.create(((O, O, O), (X, X, O), (X, X, Empty)))?
	game.state() == Win
}

# Finished game where O won via middle row victory
expect {
	game = TicTacToe.create(((X, X, Empty), (O, O, O), (X, Empty, Empty)))?
	game.state() == Win
}

# Finished game where O won via bottom row victory
expect {
	game = TicTacToe.create(((X, O, X), (Empty, X, X), (O, O, O)))?
	game.state() == Win
}

# Finished game where X won via falling diagonal victory
expect {
	game = TicTacToe.create(((X, O, O), (Empty, X, Empty), (Empty, Empty, X)))?
	game.state() == Win
}

# Finished game where X won via rising diagonal victory
expect {
	game = TicTacToe.create(((O, Empty, X), (O, X, Empty), (X, Empty, Empty)))?
	game.state() == Win
}

# Finished game where O won via falling diagonal victory
expect {
	game = TicTacToe.create(((O, X, X), (O, O, X), (X, Empty, O)))?
	game.state() == Win
}

# Finished game where O won via rising diagonal victory
expect {
	game = TicTacToe.create(((Empty, Empty, O), (Empty, O, X), (O, X, X)))?
	game.state() == Win
}

# Finished game where X won via a row and a column victory
expect {
	game = TicTacToe.create(((X, X, X), (X, O, O), (X, O, O)))?
	game.state() == Win
}

# Finished game where X won via two diagonal victories
expect {
	game = TicTacToe.create(((X, O, X), (O, X, O), (X, O, X)))?
	game.state() == Win
}

# Draw
expect {
	game = TicTacToe.create(((X, O, X), (X, X, O), (O, X, O)))?
	game.state() == Draw
}

# Another draw
expect {
	game = TicTacToe.create(((X, X, O), (O, X, X), (X, O, O)))?
	game.state() == Draw
}

# Ongoing game: one move in
expect {
	game = TicTacToe.create(((Empty, Empty, Empty), (X, Empty, Empty), (Empty, Empty, Empty)))?
	game.state() == Ongoing
}

# Ongoing game: two moves in
expect {
	game = TicTacToe.create(((O, Empty, Empty), (Empty, X, Empty), (Empty, Empty, Empty)))?
	game.state() == Ongoing
}

# Ongoing game: five moves in
expect {
	game = TicTacToe.create(((X, Empty, Empty), (Empty, X, O), (O, X, Empty)))?
	game.state() == Ongoing
}

# Invalid board: X went twice
expect {
	game = TicTacToe.create(((X, X, Empty), (Empty, Empty, Empty), (Empty, Empty, Empty)))
	game.is_err()
}

# Invalid board: O started
expect {
	game = TicTacToe.create(((O, O, X), (Empty, Empty, Empty), (Empty, Empty, Empty)))
	game.is_err()
}

# Invalid board: X won and O kept playing
expect {
	game = TicTacToe.create(((X, X, X), (O, O, O), (Empty, Empty, Empty)))
	game.is_err()
}

# Invalid board: players kept playing after a win
expect {
	game = TicTacToe.create(((X, X, X), (O, O, O), (X, O, X)))
	game.is_err()
}

# Invalid board: O kept playing after X wins
expect {
	game = TicTacToe.create(((O, O, Empty), (X, X, X), (Empty, O, Empty)))
	game.is_err()
}

# Invalid board: X kept playing after O wins
expect {
	game = TicTacToe.create(((X, X, Empty), (O, O, O), (Empty, X, X)))
	game.is_err()
}
