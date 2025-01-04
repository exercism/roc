# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/triangle/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.18.0/0APbwVN1_p1mJ96tXjaoiUCr8NBGamr8G8Ac_DrXR-o.tar.br",
}

main! = \_args ->
    Ok {}

import Triangle exposing [is_equilateral, is_isoceles, is_scalene]

##
## equilateral triangle
##

# all sides are equal
expect
    result = is_equilateral (2, 2, 2)
    result == Bool.true

# any side is unequal
expect
    result = is_equilateral (2, 3, 2)
    result == Bool.false

# no sides are equal
expect
    result = is_equilateral (5, 4, 6)
    result == Bool.false

# all zero sides is not a triangle
expect
    result = is_equilateral (0, 0, 0)
    result == Bool.false

# sides may be floats
expect
    result = is_equilateral (0.5f64, 0.5f64, 0.5f64)
    result == Bool.true

##
## isosceles triangle
##

# last two sides are equal
expect
    result = is_isoceles (3, 4, 4)
    result == Bool.true

# first two sides are equal
expect
    result = is_isoceles (4, 4, 3)
    result == Bool.true

# first and last sides are equal
expect
    result = is_isoceles (4, 3, 4)
    result == Bool.true

# equilateral triangles are also isosceles
expect
    result = is_isoceles (4, 4, 4)
    result == Bool.true

# no sides are equal
expect
    result = is_isoceles (2, 3, 4)
    result == Bool.false

# first triangle inequality violation
expect
    result = is_isoceles (1, 1, 3)
    result == Bool.false

# second triangle inequality violation
expect
    result = is_isoceles (1, 3, 1)
    result == Bool.false

# third triangle inequality violation
expect
    result = is_isoceles (3, 1, 1)
    result == Bool.false

# sides may be floats
expect
    result = is_isoceles (0.5f64, 0.4f64, 0.5f64)
    result == Bool.true

##
## scalene triangle
##

# no sides are equal
expect
    result = is_scalene (5, 4, 6)
    result == Bool.true

# all sides are equal
expect
    result = is_scalene (4, 4, 4)
    result == Bool.false

# first and second sides are equal
expect
    result = is_scalene (4, 4, 3)
    result == Bool.false

# first and third sides are equal
expect
    result = is_scalene (3, 4, 3)
    result == Bool.false

# second and third sides are equal
expect
    result = is_scalene (4, 3, 3)
    result == Bool.false

# may not violate triangle inequality
expect
    result = is_scalene (7, 3, 2)
    result == Bool.false

# sides may be floats
expect
    result = is_scalene (0.5f64, 0.4f64, 0.6f64)
    result == Bool.true

