# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/matching-brackets/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import MatchingBrackets exposing [is_paired]

# paired square brackets
expect
    result = "[]" |> is_paired
    result == Bool.true

# empty string
expect
    result = "" |> is_paired
    result == Bool.true

# unpaired brackets
expect
    result = "[[" |> is_paired
    result == Bool.false

# wrong ordered brackets
expect
    result = "}{" |> is_paired
    result == Bool.false

# wrong closing bracket
expect
    result = "{]" |> is_paired
    result == Bool.false

# paired with whitespace
expect
    result = "{ }" |> is_paired
    result == Bool.true

# partially paired brackets
expect
    result = "{[])" |> is_paired
    result == Bool.false

# simple nested brackets
expect
    result = "{[]}" |> is_paired
    result == Bool.true

# several paired brackets
expect
    result = "{}[]" |> is_paired
    result == Bool.true

# paired and nested brackets
expect
    result = "([{}({}[])])" |> is_paired
    result == Bool.true

# unopened closing brackets
expect
    result = "{[)][]}" |> is_paired
    result == Bool.false

# unpaired and nested brackets
expect
    result = "([{])" |> is_paired
    result == Bool.false

# paired and wrong nested brackets
expect
    result = "[({]})" |> is_paired
    result == Bool.false

# paired and wrong nested brackets but innermost are correct
expect
    result = "[({}])" |> is_paired
    result == Bool.false

# paired and incomplete brackets
expect
    result = "{}[" |> is_paired
    result == Bool.false

# too many closing brackets
expect
    result = "[]]" |> is_paired
    result == Bool.false

# early unexpected brackets
expect
    result = ")()" |> is_paired
    result == Bool.false

# early mismatched brackets
expect
    result = "{)()" |> is_paired
    result == Bool.false

# math expression
expect
    result = "(((185 + 223.85) * 15) - 543)/2" |> is_paired
    result == Bool.true

# complex latex expression
expect
    result = "\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)" |> is_paired
    result == Bool.true

