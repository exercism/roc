# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/rectangles/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.18.0/0APbwVN1_p1mJ96tXjaoiUCr8NBGamr8G8Ac_DrXR-o.tar.br",
}

import pf.Stdout

main! = \_args ->
    Stdout.line! ""

import Rectangles exposing [rectangles]

# no rows
expect
    result = rectangles ""
    result == 0

# no columns
expect
    result = rectangles ""
    result == 0

# no rectangles
expect
    result = rectangles " "
    result == 0

# one rectangle
expect
    result = rectangles
        """
        +-+
        | |
        +-+
        """
    result == 1

# two rectangles without shared parts
expect
    result = rectangles
        """
          +-+
          | |
        +-+-+
        | |  
        +-+  
        """
    result == 2

# five rectangles with shared parts
expect
    result = rectangles
        """
          +-+
          | |
        +-+-+
        | | |
        +-+-+
        """
    result == 5

# rectangle of height 1 is counted
expect
    result = rectangles
        """
        +--+
        +--+
        """
    result == 1

# rectangle of width 1 is counted
expect
    result = rectangles
        """
        ++
        ||
        ++
        """
    result == 1

# 1x1 square is counted
expect
    result = rectangles
        """
        ++
        ++
        """
    result == 1

# only complete rectangles are counted
expect
    result = rectangles
        """
          +-+
            |
        +-+-+
        | | -
        +-+-+
        """
    result == 1

# rectangles can be of different sizes
expect
    result = rectangles
        """
        +------+----+
        |      |    |
        +---+--+    |
        |   |       |
        +---+-------+
        """
    result == 3

# corner is required for a rectangle to be complete
expect
    result = rectangles
        """
        +------+----+
        |      |    |
        +------+    |
        |   |       |
        +---+-------+
        """
    result == 2

# large input with many rectangles
expect
    result = rectangles
        """
        +---+--+----+
        |   +--+----+
        +---+--+    |
        |   +--+----+
        +---+--+--+-+
        +---+--+--+-+
        +------+  | |
                  +-+
        """
    result == 60

# rectangles must have four sides
expect
    result = rectangles
        """
        +-+ +-+
        | | | |
        +-+-+-+
          | |  
        +-+-+-+
        | | | |
        +-+ +-+
        """
    result == 5

