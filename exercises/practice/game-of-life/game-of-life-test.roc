# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/game-of-life/canonical-data.json
# File last updated on 2026-09-02

import GameOfLife exposing [tick]

# empty matrix
expect {
	result = tick([])
	expected = []
	result == expected
}

# live cells with zero live neighbors die
expect {
	result = tick([[Dead, Dead, Dead], [Dead, Alive, Dead], [Dead, Dead, Dead]])
	expected = [[Dead, Dead, Dead], [Dead, Dead, Dead], [Dead, Dead, Dead]]
	result == expected
}

# live cells with only one live neighbor die
expect {
	result = tick([[Dead, Dead, Dead], [Dead, Alive, Dead], [Dead, Alive, Dead]])
	expected = [[Dead, Dead, Dead], [Dead, Dead, Dead], [Dead, Dead, Dead]]
	result == expected
}

# live cells with two live neighbors stay alive
expect {
	result = tick([[Alive, Dead, Alive], [Alive, Dead, Alive], [Alive, Dead, Alive]])
	expected = [[Dead, Dead, Dead], [Alive, Dead, Alive], [Dead, Dead, Dead]]
	result == expected
}

# live cells with three live neighbors stay alive
expect {
	result = tick([[Dead, Alive, Dead], [Alive, Dead, Dead], [Alive, Alive, Dead]])
	expected = [[Dead, Dead, Dead], [Alive, Dead, Dead], [Alive, Alive, Dead]]
	result == expected
}

# dead cells with three live neighbors become alive
expect {
	result = tick([[Alive, Alive, Dead], [Dead, Dead, Dead], [Alive, Dead, Dead]])
	expected = [[Dead, Dead, Dead], [Alive, Alive, Dead], [Dead, Dead, Dead]]
	result == expected
}

# live cells with four or more neighbors die
expect {
	result = tick([[Alive, Alive, Alive], [Alive, Alive, Alive], [Alive, Alive, Alive]])
	expected = [[Alive, Dead, Alive], [Dead, Dead, Dead], [Alive, Dead, Alive]]
	result == expected
}

# bigger matrix
expect {
	result = tick([[Alive, Alive, Dead, Alive, Alive, Dead, Dead, Dead], [Alive, Dead, Alive, Alive, Dead, Dead, Dead, Dead], [Alive, Alive, Alive, Dead, Dead, Alive, Alive, Alive], [Dead, Dead, Dead, Dead, Dead, Alive, Alive, Dead], [Alive, Dead, Dead, Dead, Alive, Alive, Dead, Dead], [Alive, Alive, Dead, Dead, Dead, Alive, Alive, Alive], [Dead, Dead, Alive, Dead, Alive, Dead, Dead, Alive], [Alive, Dead, Dead, Dead, Dead, Dead, Alive, Alive]])
	expected = [[Alive, Alive, Dead, Alive, Alive, Dead, Dead, Dead], [Dead, Dead, Dead, Dead, Dead, Alive, Alive, Dead], [Alive, Dead, Alive, Alive, Alive, Alive, Dead, Alive], [Alive, Dead, Dead, Dead, Dead, Dead, Dead, Alive], [Alive, Alive, Dead, Dead, Alive, Dead, Dead, Alive], [Alive, Alive, Dead, Alive, Dead, Dead, Dead, Alive], [Alive, Dead, Dead, Dead, Dead, Dead, Dead, Dead], [Dead, Dead, Dead, Dead, Dead, Dead, Alive, Alive]]
	result == expected
}
