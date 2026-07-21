# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/triangle/canonical-data.json
# File last updated on 2026-06-22

import Triangle exposing [is_equilateral, is_isosceles, is_scalene]

##
## equilateral triangle
##

# all sides are equal
expect {
	result = is_equilateral((2, 2, 2))
	result == Bool.True
}

# any side is unequal
expect {
	result = is_equilateral((2, 3, 2))
	result == Bool.False
}

# no sides are equal
expect {
	result = is_equilateral((5, 4, 6))
	result == Bool.False
}

# sides may be floats
expect {
	result = is_equilateral((0.5.F64, 0.5.F64, 0.5.F64))
	result == Bool.True
}

##
## isosceles triangle
##

# last two sides are equal
expect {
	result = is_isosceles((3, 4, 4))
	result == Bool.True
}

# first two sides are equal
expect {
	result = is_isosceles((4, 4, 3))
	result == Bool.True
}

# first and last sides are equal
expect {
	result = is_isosceles((4, 3, 4))
	result == Bool.True
}

# equilateral triangles are also isosceles
expect {
	result = is_isosceles((4, 4, 4))
	result == Bool.True
}

# no sides are equal
expect {
	result = is_isosceles((2, 3, 4))
	result == Bool.False
}

# sides may be floats
expect {
	result = is_isosceles((0.5.F64, 0.4.F64, 0.5.F64))
	result == Bool.True
}

##
## scalene triangle
##

# no sides are equal
expect {
	result = is_scalene((5, 4, 6))
	result == Bool.True
}

# all sides are equal
expect {
	result = is_scalene((4, 4, 4))
	result == Bool.False
}

# first and second sides are equal
expect {
	result = is_scalene((4, 4, 3))
	result == Bool.False
}

# first and third sides are equal
expect {
	result = is_scalene((3, 4, 3))
	result == Bool.False
}

# second and third sides are equal
expect {
	result = is_scalene((4, 3, 3))
	result == Bool.False
}

# sides may be floats
expect {
	result = is_scalene((0.5.F64, 0.4.F64, 0.6.F64))
	result == Bool.True
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
