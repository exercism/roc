# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/queen-attack/canonical-data.json
# File last updated on 2026-06-23

import ChessSquare

##
## Test creation of Queens with valid and invalid positions
##

# queen with a valid position
expect {
	square = ChessSquare.create("C3")?
	result = square.rank()
	result == 3
}

expect {
	square = ChessSquare.create("C3")?
	result = square.file()
	result == 'C'
}

# queen must have row on board
expect {
	result = ChessSquare.create("E9")
	result.is_err()
}

# queen must have column on board
expect {
	result = ChessSquare.create("I5")
	result.is_err()
}

##
## Test the ability of one queen to attack another
##

# cannot attack
expect {
	square1 = ChessSquare.create("E3")?
	square2 = ChessSquare.create("G7")?
	result = square1.queen_can_attack(square2)
	result == Bool.False
}

# can attack on same row
expect {
	square1 = ChessSquare.create("E3")?
	square2 = ChessSquare.create("G3")?
	result = square1.queen_can_attack(square2)
	result == Bool.True
}

# can attack on same column
expect {
	square1 = ChessSquare.create("F5")?
	square2 = ChessSquare.create("F3")?
	result = square1.queen_can_attack(square2)
	result == Bool.True
}

# can attack on first diagonal
expect {
	square1 = ChessSquare.create("C3")?
	square2 = ChessSquare.create("E1")?
	result = square1.queen_can_attack(square2)
	result == Bool.True
}

# can attack on second diagonal
expect {
	square1 = ChessSquare.create("C3")?
	square2 = ChessSquare.create("B4")?
	result = square1.queen_can_attack(square2)
	result == Bool.True
}

# can attack on third diagonal
expect {
	square1 = ChessSquare.create("C3")?
	square2 = ChessSquare.create("B2")?
	result = square1.queen_can_attack(square2)
	result == Bool.True
}

# can attack on fourth diagonal
expect {
	square1 = ChessSquare.create("H2")?
	square2 = ChessSquare.create("G1")?
	result = square1.queen_can_attack(square2)
	result == Bool.True
}

# cannot attack if falling diagonals are only the same when reflected across the longest falling diagonal
expect {
	square1 = ChessSquare.create("B5")?
	square2 = ChessSquare.create("F3")?
	result = square1.queen_can_attack(square2)
	result == Bool.False
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
