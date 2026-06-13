# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/hamming/canonical-data.json
# File last updated on 2026-06-13

import Hamming exposing [distance]

# empty strands
expect {
	result = distance("", "")
	result == Ok(0)
}

# single letter identical strands
expect {
	result = distance("A", "A")
	result == Ok(0)
}

# single letter different strands
expect {
	result = distance("G", "T")
	result == Ok(1)
}

# long identical strands
expect {
	result = distance("GGACTGAAATCTG", "GGACTGAAATCTG")
	result == Ok(0)
}

# long different strands
expect {
	result = distance("GGACGGATTCTG", "AGGACGGATTCT")
	result == Ok(9)
}

# disallow first strand longer
expect {
	result = distance("AATG", "AAA")
	result.is_err()
}

# disallow second strand longer
expect {
	result = distance("ATA", "AGTG")
	result.is_err()
}

# disallow empty first strand
expect {
	result = distance("", "G")
	result.is_err()
}

# disallow empty second strand
expect {
	result = distance("G", "")
	result.is_err()
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
