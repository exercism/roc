# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/triangle/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import Triangle exposing [isEquilateral, isIsosceles, isScalene]

##
## equilateral triangle
##

# all sides are equal
expect
    result = isEquilateral (2, 2, 2)
    result == Bool.true

# any side is unequal
expect
    result = isEquilateral (2, 3, 2)
    result == Bool.false

# no sides are equal
expect
    result = isEquilateral (5, 4, 6)
    result == Bool.false

# all zero sides is not a triangle
expect
    result = isEquilateral (0, 0, 0)
    result == Bool.false

# sides may be floats
expect
    result = isEquilateral (0.5f64, 0.5f64, 0.5f64)
    result == Bool.true

##
## isosceles triangle
##

# last two sides are equal
expect
    result = isIsosceles (3, 4, 4)
    result == Bool.true

# first two sides are equal
expect
    result = isIsosceles (4, 4, 3)
    result == Bool.true

# first and last sides are equal
expect
    result = isIsosceles (4, 3, 4)
    result == Bool.true

# equilateral triangles are also isosceles
expect
    result = isIsosceles (4, 4, 4)
    result == Bool.true

# no sides are equal
expect
    result = isIsosceles (2, 3, 4)
    result == Bool.false

# first triangle inequality violation
expect
    result = isIsosceles (1, 1, 3)
    result == Bool.false

# second triangle inequality violation
expect
    result = isIsosceles (1, 3, 1)
    result == Bool.false

# third triangle inequality violation
expect
    result = isIsosceles (3, 1, 1)
    result == Bool.false

# sides may be floats
expect
    result = isIsosceles (0.5f64, 0.4f64, 0.5f64)
    result == Bool.true

##
## scalene triangle
##

# no sides are equal
expect
    result = isScalene (5, 4, 6)
    result == Bool.true

# all sides are equal
expect
    result = isScalene (4, 4, 4)
    result == Bool.false

# first and second sides are equal
expect
    result = isScalene (4, 4, 3)
    result == Bool.false

# first and third sides are equal
expect
    result = isScalene (3, 4, 3)
    result == Bool.false

# second and third sides are equal
expect
    result = isScalene (4, 3, 3)
    result == Bool.false

# may not violate triangle inequality
expect
    result = isScalene (7, 3, 2)
    result == Bool.false

# sides may be floats
expect
    result = isScalene (0.5f64, 0.4f64, 0.6f64)
    result == Bool.true

