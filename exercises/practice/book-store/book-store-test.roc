# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/book-store/canonical-data.json
# File last updated on 2026-09-25

import BookStore exposing [total]

## Only a single book
expect {
	result = total([1])
	result == 8.00
}

## Two of the same book
expect {
	result = total([2, 2])
	result == 16.00
}

## Empty basket
expect {
	result = total([])
	result == 0.00
}

## Two different books
expect {
	result = total([1, 2])
	result == 15.20
}

## Three different books
expect {
	result = total([1, 2, 3])
	result == 21.60
}

## Four different books
expect {
	result = total([1, 2, 3, 4])
	result == 25.60
}

## Five different books
expect {
	result = total([1, 2, 3, 4, 5])
	result == 30.00
}

## Two groups of four is cheaper than group of five plus group of three
expect {
	result = total([1, 1, 2, 2, 3, 3, 4, 5])
	result == 51.20
}

## Two groups of four is cheaper than groups of five and three
expect {
	result = total([1, 1, 2, 3, 4, 4, 5, 5])
	result == 51.20
}

## Group of four plus group of two is cheaper than two groups of three
expect {
	result = total([1, 1, 2, 2, 3, 4])
	result == 40.80
}

## Two each of first four books and one copy each of rest
expect {
	result = total([1, 1, 2, 2, 3, 3, 4, 4, 5])
	result == 55.60
}

## Two copies of each book
expect {
	result = total([1, 1, 2, 2, 3, 3, 4, 4, 5, 5])
	result == 60.00
}

## Three copies of first book and two each of remaining
expect {
	result = total([1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 1])
	result == 68.00
}

## Three each of first two books and two each of remaining books
expect {
	result = total([1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 1, 2])
	result == 75.20
}

## Four groups of four are cheaper than two groups each of five and three
expect {
	result = total([1, 1, 2, 2, 3, 3, 4, 5, 1, 1, 2, 2, 3, 3, 4, 5])
	result == 102.40
}

## Check that groups of four are created properly even when there are more groups of three than groups of five
expect {
	result = total([1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 4, 4, 5, 5])
	result == 145.60
}

## One group of one and four is cheaper than one group of two and three
expect {
	result = total([1, 1, 2, 3, 4])
	result == 33.60
}

## One group of one and two plus three groups of four is cheaper than one group of each size
expect {
	result = total([1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5])
	result == 100.00
}
