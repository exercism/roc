# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/camicia/canonical-data.json
# File last updated on 2026-09-26

import Camicia exposing [simulate_game]

## two cards, one trick
expect {
	result = simulate_game({
		player_a: ["2"],
		player_b: ["3"],
	})
	result == {
		status: Finished,
		cards: 2,
		tricks: 1,
	}
}

## three cards, one trick
expect {
	result = simulate_game({
		player_a: ["2", "4"],
		player_b: ["3"],
	})
	result == {
		status: Finished,
		cards: 3,
		tricks: 1,
	}
}

## four cards, one trick
expect {
	result = simulate_game({
		player_a: ["2", "4"],
		player_b: ["3", "5", "6"],
	})
	result == {
		status: Finished,
		cards: 4,
		tricks: 1,
	}
}

## the ace reigns supreme
expect {
	result = simulate_game({
		player_a: ["2", "A"],
		player_b: ["3", "4", "5", "6", "7"],
	})
	result == {
		status: Finished,
		cards: 7,
		tricks: 1,
	}
}

## the king beats ace
expect {
	result = simulate_game({
		player_a: ["2", "A"],
		player_b: ["3", "4", "5", "6", "K"],
	})
	result == {
		status: Finished,
		cards: 7,
		tricks: 1,
	}
}

## the queen seduces the king
expect {
	result = simulate_game({
		player_a: ["2", "A", "7", "8", "Q"],
		player_b: ["3", "4", "5", "6", "K"],
	})
	result == {
		status: Finished,
		cards: 10,
		tricks: 1,
	}
}

## the jack betrays the queen
expect {
	result = simulate_game({
		player_a: ["2", "A", "7", "8", "Q"],
		player_b: ["3", "4", "5", "6", "K", "9", "J"],
	})
	result == {
		status: Finished,
		cards: 12,
		tricks: 1,
	}
}

## the 10 just wants to put on a show
expect {
	result = simulate_game({
		player_a: ["2", "A", "7", "8", "Q", "10"],
		player_b: ["3", "4", "5", "6", "K", "9", "J"],
	})
	result == {
		status: Finished,
		cards: 13,
		tricks: 1,
	}
}

## simple loop with decks of 3 cards
expect {
	result = simulate_game({
		player_a: ["J", "2", "3"],
		player_b: ["4", "J", "5"],
	})
	result == {
		status: Loop,
		cards: 8,
		tricks: 3,
	}
}

## the story is starting to get a bit complicated
expect {
	result = simulate_game({
		player_a: ["2", "6", "6", "J", "4", "K", "Q", "10", "K", "J", "Q", "2", "3", "K", "5", "6", "Q", "Q", "A", "A", "6", "9", "K", "A", "8", "K", "2", "A", "9", "A", "Q", "4", "K", "K", "K", "3", "5", "K", "8", "Q", "3", "Q", "7", "J", "K", "J", "9", "J", "3", "3", "K", "K", "Q", "A", "K", "7", "10", "A", "Q", "7", "10", "J", "4", "5", "J", "9", "10", "Q", "J", "J", "K", "6", "10", "J", "6", "Q", "J", "5", "J", "Q", "Q", "8", "3", "8", "A", "2", "6", "9", "K", "7", "J", "K", "K", "8", "K", "Q", "6", "10", "J", "10", "J", "Q", "J", "10", "3", "8", "K", "A", "6", "9", "K", "2", "A", "A", "10", "J", "6", "A", "4", "J", "A", "J", "J", "6", "2", "J", "3", "K", "2", "5", "9", "J", "9", "6", "K", "A", "5", "Q", "J", "2", "Q", "K", "A", "3", "K", "J", "K", "2", "5", "6", "Q", "J", "Q", "Q", "J", "2", "J", "9", "Q", "7", "7", "A", "Q", "7", "Q", "J", "K", "J", "A", "7", "7", "8", "Q", "10", "J", "10", "J", "J", "9", "2", "A", "2"],
		player_b: ["7", "2", "10", "K", "8", "2", "J", "9", "A", "5", "6", "J", "Q", "6", "K", "6", "5", "A", "4", "Q", "7", "J", "7", "10", "2", "Q", "8", "2", "2", "K", "J", "A", "5", "5", "A", "4", "Q", "6", "Q", "K", "10", "8", "Q", "2", "10", "J", "A", "Q", "8", "Q", "Q", "J", "J", "A", "A", "9", "10", "J", "K", "4", "Q", "10", "10", "J", "K", "10", "2", "J", "7", "A", "K", "K", "J", "A", "J", "10", "8", "K", "A", "7", "Q", "Q", "J", "3", "Q", "4", "A", "3", "A", "Q", "Q", "Q", "5", "4", "K", "J", "10", "A", "Q", "J", "6", "J", "A", "10", "A", "5", "8", "3", "K", "5", "9", "Q", "8", "7", "7", "J", "7", "Q", "Q", "Q", "A", "7", "8", "9", "A", "Q", "A", "K", "8", "A", "A", "J", "8", "4", "8", "K", "J", "A", "10", "Q", "8", "J", "8", "6", "10", "Q", "J", "J", "A", "A", "J", "5", "Q", "6", "J", "K", "Q", "8", "K", "4", "Q", "Q", "6", "J", "K", "4", "7", "J", "J", "9", "9", "A", "Q", "Q", "K", "A", "6", "5", "K"],
	})
	result == {
		status: Finished,
		cards: 361,
		tricks: 1,
	}
}

## two tricks
expect {
	result = simulate_game({
		player_a: ["J"],
		player_b: ["3", "J"],
	})
	result == {
		status: Finished,
		cards: 5,
		tricks: 2,
	}
}

## more tricks
expect {
	result = simulate_game({
		player_a: ["J", "2", "4"],
		player_b: ["3", "J", "A"],
	})
	result == {
		status: Finished,
		cards: 12,
		tricks: 4,
	}
}

## simple loop with decks of 4 cards
expect {
	result = simulate_game({
		player_a: ["2", "3", "J", "6"],
		player_b: ["K", "5", "J", "7"],
	})
	result == {
		status: Loop,
		cards: 16,
		tricks: 4,
	}
}

## easy card combination
expect {
	result = simulate_game({
		player_a: ["4", "8", "7", "5", "4", "10", "3", "9", "7", "3", "10", "10", "6", "8", "2", "8", "5", "4", "5", "9", "6", "5", "2", "8", "10", "9"],
		player_b: ["6", "9", "4", "7", "2", "2", "3", "6", "7", "3", "A", "A", "A", "A", "K", "K", "K", "K", "Q", "Q", "Q", "Q", "J", "J", "J", "J"],
	})
	result == {
		status: Finished,
		cards: 40,
		tricks: 4,
	}
}

## easy card combination, inverted decks
expect {
	result = simulate_game({
		player_a: ["3", "3", "5", "7", "3", "2", "10", "7", "6", "7", "A", "A", "A", "A", "K", "K", "K", "K", "Q", "Q", "Q", "Q", "J", "J", "J", "J"],
		player_b: ["5", "10", "8", "2", "6", "7", "2", "4", "9", "2", "6", "10", "10", "5", "4", "8", "4", "8", "6", "9", "8", "5", "9", "3", "4", "9"],
	})
	result == {
		status: Finished,
		cards: 40,
		tricks: 4,
	}
}

## mirrored decks
expect {
	result = simulate_game({
		player_a: ["2", "A", "3", "A", "3", "K", "4", "K", "2", "Q", "2", "Q", "10", "J", "5", "J", "6", "10", "2", "9", "10", "7", "3", "9", "6", "9"],
		player_b: ["6", "A", "4", "A", "7", "K", "4", "K", "7", "Q", "7", "Q", "5", "J", "8", "J", "4", "5", "8", "9", "10", "6", "8", "3", "8", "5"],
	})
	result == {
		status: Finished,
		cards: 59,
		tricks: 4,
	}
}

## opposite decks
expect {
	result = simulate_game({
		player_a: ["4", "A", "9", "A", "4", "K", "9", "K", "6", "Q", "8", "Q", "8", "J", "10", "J", "9", "8", "4", "6", "3", "6", "5", "2", "4", "3"],
		player_b: ["10", "7", "3", "2", "9", "2", "7", "8", "7", "5", "J", "7", "J", "10", "Q", "10", "Q", "3", "K", "5", "K", "6", "A", "2", "A", "5"],
	})
	result == {
		status: Finished,
		cards: 151,
		tricks: 21,
	}
}

## random decks #1
expect {
	result = simulate_game({
		player_a: ["K", "10", "9", "8", "J", "8", "6", "9", "7", "A", "K", "5", "4", "4", "J", "5", "J", "4", "3", "5", "8", "6", "7", "7", "4", "9"],
		player_b: ["6", "3", "K", "A", "Q", "10", "A", "2", "Q", "8", "2", "10", "10", "2", "Q", "3", "K", "9", "7", "A", "3", "Q", "5", "J", "2", "6"],
	})
	result == {
		status: Finished,
		cards: 542,
		tricks: 76,
	}
}

## random decks #2
expect {
	result = simulate_game({
		player_a: ["8", "A", "4", "8", "5", "Q", "J", "2", "6", "2", "9", "7", "K", "A", "8", "10", "K", "8", "10", "9", "K", "6", "7", "3", "K", "9"],
		player_b: ["10", "5", "2", "6", "Q", "J", "A", "9", "5", "5", "3", "7", "3", "J", "A", "2", "Q", "3", "J", "Q", "4", "10", "4", "7", "4", "6"],
	})
	result == {
		status: Finished,
		cards: 327,
		tricks: 42,
	}
}

## Kleber 1999
expect {
	result = simulate_game({
		player_a: ["4", "8", "9", "J", "Q", "8", "5", "5", "K", "2", "A", "9", "8", "5", "10", "A", "4", "J", "3", "K", "6", "9", "2", "Q", "K", "7"],
		player_b: ["10", "J", "3", "2", "4", "10", "4", "7", "5", "3", "6", "6", "7", "A", "J", "Q", "A", "7", "2", "10", "3", "K", "9", "6", "8", "Q"],
	})
	result == {
		status: Finished,
		cards: 5790,
		tricks: 805,
	}
}

## Collins 2006
expect {
	result = simulate_game({
		player_a: ["A", "8", "Q", "K", "9", "10", "3", "7", "4", "2", "Q", "3", "2", "10", "9", "K", "A", "8", "7", "7", "4", "5", "J", "9", "2", "10"],
		player_b: ["4", "J", "A", "K", "8", "5", "6", "6", "A", "6", "5", "Q", "4", "6", "10", "8", "J", "2", "5", "7", "Q", "J", "3", "3", "K", "9"],
	})
	result == {
		status: Finished,
		cards: 6913,
		tricks: 960,
	}
}

## Mann and Wu 2007
expect {
	result = simulate_game({
		player_a: ["K", "2", "K", "K", "3", "3", "6", "10", "K", "6", "A", "2", "5", "5", "7", "9", "J", "A", "A", "3", "4", "Q", "4", "8", "J", "6"],
		player_b: ["4", "5", "2", "Q", "7", "9", "9", "Q", "7", "J", "9", "8", "10", "3", "10", "J", "4", "10", "8", "6", "8", "7", "A", "Q", "5", "2"],
	})
	result == {
		status: Finished,
		cards: 7157,
		tricks: 1007,
	}
}

## Nessler 2012
expect {
	result = simulate_game({
		player_a: ["10", "3", "6", "7", "Q", "2", "9", "8", "2", "8", "4", "A", "10", "6", "K", "2", "10", "A", "5", "A", "2", "4", "Q", "J", "K", "4"],
		player_b: ["10", "Q", "4", "6", "J", "9", "3", "J", "9", "3", "3", "Q", "K", "5", "9", "5", "K", "6", "5", "7", "8", "J", "A", "7", "8", "7"],
	})
	result == {
		status: Finished,
		cards: 7207,
		tricks: 1015,
	}
}

## Anderson 2013
expect {
	result = simulate_game({
		player_a: ["6", "7", "A", "3", "Q", "3", "5", "J", "3", "2", "J", "7", "4", "5", "Q", "10", "5", "A", "J", "2", "K", "8", "9", "9", "K", "3"],
		player_b: ["4", "J", "6", "9", "8", "5", "10", "7", "9", "Q", "2", "7", "10", "8", "4", "10", "A", "6", "4", "A", "6", "8", "Q", "K", "K", "2"],
	})
	result == {
		status: Finished,
		cards: 7225,
		tricks: 1016,
	}
}

## Rucklidge 2014
expect {
	result = simulate_game({
		player_a: ["8", "J", "2", "9", "4", "4", "5", "8", "Q", "3", "9", "3", "6", "2", "8", "A", "A", "A", "9", "4", "7", "2", "5", "Q", "Q", "3"],
		player_b: ["K", "7", "10", "6", "3", "J", "A", "7", "6", "5", "5", "8", "10", "9", "10", "4", "2", "7", "K", "Q", "10", "K", "6", "J", "J", "K"],
	})
	result == {
		status: Finished,
		cards: 7959,
		tricks: 1122,
	}
}

## Nessler 2021
expect {
	result = simulate_game({
		player_a: ["7", "2", "3", "4", "K", "9", "6", "10", "A", "8", "9", "Q", "7", "A", "4", "8", "J", "J", "A", "4", "3", "2", "5", "6", "6", "J"],
		player_b: ["3", "10", "8", "9", "8", "K", "K", "2", "5", "5", "7", "6", "4", "3", "5", "7", "A", "9", "J", "K", "2", "Q", "10", "Q", "10", "Q"],
	})
	result == {
		status: Finished,
		cards: 7972,
		tricks: 1106,
	}
}

## Nessler 2022
expect {
	result = simulate_game({
		player_a: ["2", "10", "10", "A", "J", "3", "8", "Q", "2", "5", "5", "5", "9", "2", "4", "3", "10", "Q", "A", "K", "Q", "J", "J", "9", "Q", "K"],
		player_b: ["10", "7", "6", "3", "6", "A", "8", "9", "4", "3", "K", "J", "6", "K", "4", "9", "7", "8", "5", "7", "8", "2", "A", "7", "4", "6"],
	})
	result == {
		status: Finished,
		cards: 8344,
		tricks: 1164,
	}
}

## Casella 2024, first infinite game found
expect {
	result = simulate_game({
		player_a: ["2", "8", "4", "K", "5", "2", "3", "Q", "6", "K", "Q", "A", "J", "3", "5", "9", "8", "3", "A", "A", "J", "4", "4", "J", "7", "5"],
		player_b: ["7", "7", "8", "6", "10", "10", "6", "10", "7", "2", "Q", "6", "3", "2", "4", "K", "Q", "10", "J", "5", "9", "8", "9", "9", "K", "A"],
	})
	result == {
		status: Loop,
		cards: 474,
		tricks: 66,
	}
}
