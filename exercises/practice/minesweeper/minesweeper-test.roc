# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/minesweeper/canonical-data.json
# File last updated on 2024-09-02
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import Minesweeper exposing [annotate]

# no rows
expect
    minefield = "" |> Str.replaceEach "·" " "
    result = annotate minefield
    expected = "" |> Str.replaceEach "·" " "
    result == expected

# no columns
expect
    minefield = "" |> Str.replaceEach "·" " "
    result = annotate minefield
    expected = "" |> Str.replaceEach "·" " "
    result == expected

# no mines
expect
    minefield =
        """
        ···
        ···
        ···
        """
        |> Str.replaceEach "·" " "
    result = annotate minefield
    expected =
        """
        ···
        ···
        ···
        """
        |> Str.replaceEach "·" " "
    result == expected

# minefield with only mines
expect
    minefield =
        """
        ***
        ***
        ***
        """
        |> Str.replaceEach "·" " "
    result = annotate minefield
    expected =
        """
        ***
        ***
        ***
        """
        |> Str.replaceEach "·" " "
    result == expected

# mine surrounded by spaces
expect
    minefield =
        """
        ···
        ·*·
        ···
        """
        |> Str.replaceEach "·" " "
    result = annotate minefield
    expected =
        """
        111
        1*1
        111
        """
        |> Str.replaceEach "·" " "
    result == expected

# space surrounded by mines
expect
    minefield =
        """
        ***
        *·*
        ***
        """
        |> Str.replaceEach "·" " "
    result = annotate minefield
    expected =
        """
        ***
        *8*
        ***
        """
        |> Str.replaceEach "·" " "
    result == expected

# horizontal line
expect
    minefield = "·*·*·" |> Str.replaceEach "·" " "
    result = annotate minefield
    expected = "1*2*1" |> Str.replaceEach "·" " "
    result == expected

# horizontal line, mines at edges
expect
    minefield = "*···*" |> Str.replaceEach "·" " "
    result = annotate minefield
    expected = "*1·1*" |> Str.replaceEach "·" " "
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
        |> Str.replaceEach "·" " "
    result = annotate minefield
    expected =
        """
        1
        *
        2
        *
        1
        """
        |> Str.replaceEach "·" " "
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
        |> Str.replaceEach "·" " "
    result = annotate minefield
    expected =
        """
        *
        1
        ·
        1
        *
        """
        |> Str.replaceEach "·" " "
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
        |> Str.replaceEach "·" " "
    result = annotate minefield
    expected =
        """
        ·2*2·
        25*52
        *****
        25*52
        ·2*2·
        """
        |> Str.replaceEach "·" " "
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
        |> Str.replaceEach "·" " "
    result = annotate minefield
    expected =
        """
        1*22*1
        12*322
        ·123*2
        112*4*
        1*22*2
        111111
        """
        |> Str.replaceEach "·" " "
    result == expected

