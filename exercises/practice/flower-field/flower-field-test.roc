# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/flower-field/canonical-data.json
# File last updated on 2025-07-02
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line! ""

import FlowerField exposing [annotate]

# no rows
expect
    garden = "" |> Str.replace_each "·" " "
    result = annotate garden
    expected = "" |> Str.replace_each "·" " "
    result == expected

# no columns
expect
    garden = "" |> Str.replace_each "·" " "
    result = annotate garden
    expected = "" |> Str.replace_each "·" " "
    result == expected

# no flowers
expect
    garden =
        """
        ···
        ···
        ···
        """
        |> Str.replace_each "·" " "
    result = annotate garden
    expected =
        """
        ···
        ···
        ···
        """
        |> Str.replace_each "·" " "
    result == expected

# garden full of flowers
expect
    garden =
        """
        ***
        ***
        ***
        """
        |> Str.replace_each "·" " "
    result = annotate garden
    expected =
        """
        ***
        ***
        ***
        """
        |> Str.replace_each "·" " "
    result == expected

# flower surrounded by spaces
expect
    garden =
        """
        ···
        ·*·
        ···
        """
        |> Str.replace_each "·" " "
    result = annotate garden
    expected =
        """
        111
        1*1
        111
        """
        |> Str.replace_each "·" " "
    result == expected

# space surrounded by flowers
expect
    garden =
        """
        ***
        *·*
        ***
        """
        |> Str.replace_each "·" " "
    result = annotate garden
    expected =
        """
        ***
        *8*
        ***
        """
        |> Str.replace_each "·" " "
    result == expected

# horizontal line
expect
    garden = "·*·*·" |> Str.replace_each "·" " "
    result = annotate garden
    expected = "1*2*1" |> Str.replace_each "·" " "
    result == expected

# horizontal line, flowers at edges
expect
    garden = "*···*" |> Str.replace_each "·" " "
    result = annotate garden
    expected = "*1·1*" |> Str.replace_each "·" " "
    result == expected

# vertical line
expect
    garden =
        """
        ·
        *
        ·
        *
        ·
        """
        |> Str.replace_each "·" " "
    result = annotate garden
    expected =
        """
        1
        *
        2
        *
        1
        """
        |> Str.replace_each "·" " "
    result == expected

# vertical line, flowers at edges
expect
    garden =
        """
        *
        ·
        ·
        ·
        *
        """
        |> Str.replace_each "·" " "
    result = annotate garden
    expected =
        """
        *
        1
        ·
        1
        *
        """
        |> Str.replace_each "·" " "
    result == expected

# cross
expect
    garden =
        """
        ··*··
        ··*··
        *****
        ··*··
        ··*··
        """
        |> Str.replace_each "·" " "
    result = annotate garden
    expected =
        """
        ·2*2·
        25*52
        *****
        25*52
        ·2*2·
        """
        |> Str.replace_each "·" " "
    result == expected

# large garden
expect
    garden =
        """
        ·*··*·
        ··*···
        ····*·
        ···*·*
        ·*··*·
        ······
        """
        |> Str.replace_each "·" " "
    result = annotate garden
    expected =
        """
        1*22*1
        12*322
        ·123*2
        112*4*
        1*22*2
        111111
        """
        |> Str.replace_each "·" " "
    result == expected

