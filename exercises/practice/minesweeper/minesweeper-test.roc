# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/minesweeper/canonical-data.json
# File last updated on 2025-07-26
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Minesweeper exposing [annotate]

# no rows
expect
    minefield = "" |> Str.replace_each("·", " ")
    result = annotate(minefield)
    expected = "" |> Str.replace_each("·", " ")
    result == expected

# no columns
expect
    minefield = "" |> Str.replace_each("·", " ")
    result = annotate(minefield)
    expected = "" |> Str.replace_each("·", " ")
    result == expected

# no mines
expect
    minefield =
        """
        ···
        ···
        ···
        """
        |> Str.replace_each("·", " ")
    result = annotate(minefield)
    expected =
        """
        ···
        ···
        ···
        """
        |> Str.replace_each("·", " ")
    result == expected

# minefield with only mines
expect
    minefield =
        """
        ***
        ***
        ***
        """
        |> Str.replace_each("·", " ")
    result = annotate(minefield)
    expected =
        """
        ***
        ***
        ***
        """
        |> Str.replace_each("·", " ")
    result == expected

# mine surrounded by spaces
expect
    minefield =
        """
        ···
        ·*·
        ···
        """
        |> Str.replace_each("·", " ")
    result = annotate(minefield)
    expected =
        """
        111
        1*1
        111
        """
        |> Str.replace_each("·", " ")
    result == expected

# space surrounded by mines
expect
    minefield =
        """
        ***
        *·*
        ***
        """
        |> Str.replace_each("·", " ")
    result = annotate(minefield)
    expected =
        """
        ***
        *8*
        ***
        """
        |> Str.replace_each("·", " ")
    result == expected

# horizontal line
expect
    minefield = "·*·*·" |> Str.replace_each("·", " ")
    result = annotate(minefield)
    expected = "1*2*1" |> Str.replace_each("·", " ")
    result == expected

# horizontal line, mines at edges
expect
    minefield = "*···*" |> Str.replace_each("·", " ")
    result = annotate(minefield)
    expected = "*1·1*" |> Str.replace_each("·", " ")
    result == expected

# vertical line
expect
    minefield =
        """
        ·
        *
        ·
        *
        ·
        """
        |> Str.replace_each("·", " ")
    result = annotate(minefield)
    expected =
        """
        1
        *
        2
        *
        1
        """
        |> Str.replace_each("·", " ")
    result == expected

# vertical line, mines at edges
expect
    minefield =
        """
        *
        ·
        ·
        ·
        *
        """
        |> Str.replace_each("·", " ")
    result = annotate(minefield)
    expected =
        """
        *
        1
        ·
        1
        *
        """
        |> Str.replace_each("·", " ")
    result == expected

# cross
expect
    minefield =
        """
        ··*··
        ··*··
        *****
        ··*··
        ··*··
        """
        |> Str.replace_each("·", " ")
    result = annotate(minefield)
    expected =
        """
        ·2*2·
        25*52
        *****
        25*52
        ·2*2·
        """
        |> Str.replace_each("·", " ")
    result == expected

# large minefield
expect
    minefield =
        """
        ·*··*·
        ··*···
        ····*·
        ···*·*
        ·*··*·
        ······
        """
        |> Str.replace_each("·", " ")
    result = annotate(minefield)
    expected =
        """
        1*22*1
        12*322
        ·123*2
        112*4*
        1*22*2
        111111
        """
        |> Str.replace_each("·", " ")
    result == expected

