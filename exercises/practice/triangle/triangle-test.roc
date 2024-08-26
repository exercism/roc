# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/triangle/canonical-data.json
# File last updated on 2024-08-26
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br",
}

import pf.Task exposing [Task]

main =
    Task.ok {}

import Triangle exposing [isEquilateral, isIsosceles, isScalene]

##
## equilateral triangle
##

# all sides are equal
expect isEquilateral (2, 2, 2) == Bool.true

# any side is unequal
expect isEquilateral (2, 3, 2) == Bool.false

# no sides are equal
expect isEquilateral (5, 4, 6) == Bool.false

# all zero sides is not a triangle
expect isEquilateral (0, 0, 0) == Bool.false

# sides may be floats
expect isEquilateral (0.5f64, 0.5f64, 0.5f64) == Bool.true

##
## isosceles triangle
##

# last two sides are equal
expect isIsosceles (3, 4, 4) == Bool.true

# first two sides are equal
expect isIsosceles (4, 4, 3) == Bool.true

# first and last sides are equal
expect isIsosceles (4, 3, 4) == Bool.true

# equilateral triangles are also isosceles
expect isIsosceles (4, 4, 4) == Bool.true

# no sides are equal
expect isIsosceles (2, 3, 4) == Bool.false

# first triangle inequality violation
expect isIsosceles (1, 1, 3) == Bool.false

# second triangle inequality violation
expect isIsosceles (1, 3, 1) == Bool.false

# third triangle inequality violation
expect isIsosceles (3, 1, 1) == Bool.false

# sides may be floats
expect isIsosceles (0.5f64, 0.4f64, 0.5f64) == Bool.true

##
## scalene triangle
##

# no sides are equal
expect isScalene (5, 4, 6) == Bool.true

# all sides are equal
expect isScalene (4, 4, 4) == Bool.false

# first and second sides are equal
expect isScalene (4, 4, 3) == Bool.false

# first and third sides are equal
expect isScalene (3, 4, 3) == Bool.false

# second and third sides are equal
expect isScalene (4, 3, 3) == Bool.false

# may not violate triangle inequality
expect isScalene (7, 3, 2) == Bool.false

# sides may be floats
expect isScalene (0.5f64, 0.4f64, 0.6f64) == Bool.true

