# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/matching-brackets/canonical-data.json
# File last updated on 2024-09-16
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import MatchingBrackets exposing [isPaired]

# paired square brackets
expect
    result = "[]" |> isPaired
    result == Bool.true

# empty string
expect
    result = "" |> isPaired
    result == Bool.true

# unpaired brackets
expect
    result = "[[" |> isPaired
    result == Bool.false

# wrong ordered brackets
expect
    result = "}{" |> isPaired
    result == Bool.false

# wrong closing bracket
expect
    result = "{]" |> isPaired
    result == Bool.false

# paired with whitespace
expect
    result = "{ }" |> isPaired
    result == Bool.true

# partially paired brackets
expect
    result = "{[])" |> isPaired
    result == Bool.false

# simple nested brackets
expect
    result = "{[]}" |> isPaired
    result == Bool.true

# several paired brackets
expect
    result = "{}[]" |> isPaired
    result == Bool.true

# paired and nested brackets
expect
    result = "([{}({}[])])" |> isPaired
    result == Bool.true

# unopened closing brackets
expect
    result = "{[)][]}" |> isPaired
    result == Bool.false

# unpaired and nested brackets
expect
    result = "([{])" |> isPaired
    result == Bool.false

# paired and wrong nested brackets
expect
    result = "[({]})" |> isPaired
    result == Bool.false

# paired and wrong nested brackets but innermost are correct
expect
    result = "[({}])" |> isPaired
    result == Bool.false

# paired and incomplete brackets
expect
    result = "{}[" |> isPaired
    result == Bool.false

# too many closing brackets
expect
    result = "[]]" |> isPaired
    result == Bool.false

# early unexpected brackets
expect
    result = ")()" |> isPaired
    result == Bool.false

# early mismatched brackets
expect
    result = "{)()" |> isPaired
    result == Bool.false

# math expression
expect
    result = "(((185 + 223.85) * 15) - 543)/2" |> isPaired
    result == Bool.true

# complex latex expression
expect
    result = "\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)" |> isPaired
    result == Bool.true

