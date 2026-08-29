# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/zebra-puzzle/canonical-data.json
# File last updated on 2026-08-29

import ZebraPuzzle exposing [owns_zebra, drinks_water]

# resident who drinks water
expect {
	result = drinks_water
	result == Ok(Norwegian)
}

# resident who owns zebra
expect {
	result = owns_zebra
	result == Ok(Japanese)
}
