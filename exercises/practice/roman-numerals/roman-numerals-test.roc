# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/roman-numerals/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import RomanNumerals exposing [roman]

# 1 is I
expect
    result = roman(1)
    result == Ok("I")

# 2 is II
expect
    result = roman(2)
    result == Ok("II")

# 3 is III
expect
    result = roman(3)
    result == Ok("III")

# 4 is IV
expect
    result = roman(4)
    result == Ok("IV")

# 5 is V
expect
    result = roman(5)
    result == Ok("V")

# 6 is VI
expect
    result = roman(6)
    result == Ok("VI")

# 9 is IX
expect
    result = roman(9)
    result == Ok("IX")

# 16 is XVI
expect
    result = roman(16)
    result == Ok("XVI")

# 27 is XXVII
expect
    result = roman(27)
    result == Ok("XXVII")

# 48 is XLVIII
expect
    result = roman(48)
    result == Ok("XLVIII")

# 49 is XLIX
expect
    result = roman(49)
    result == Ok("XLIX")

# 59 is LIX
expect
    result = roman(59)
    result == Ok("LIX")

# 66 is LXVI
expect
    result = roman(66)
    result == Ok("LXVI")

# 93 is XCIII
expect
    result = roman(93)
    result == Ok("XCIII")

# 141 is CXLI
expect
    result = roman(141)
    result == Ok("CXLI")

# 163 is CLXIII
expect
    result = roman(163)
    result == Ok("CLXIII")

# 166 is CLXVI
expect
    result = roman(166)
    result == Ok("CLXVI")

# 402 is CDII
expect
    result = roman(402)
    result == Ok("CDII")

# 575 is DLXXV
expect
    result = roman(575)
    result == Ok("DLXXV")

# 666 is DCLXVI
expect
    result = roman(666)
    result == Ok("DCLXVI")

# 911 is CMXI
expect
    result = roman(911)
    result == Ok("CMXI")

# 1024 is MXXIV
expect
    result = roman(1024)
    result == Ok("MXXIV")

# 1666 is MDCLXVI
expect
    result = roman(1666)
    result == Ok("MDCLXVI")

# 3000 is MMM
expect
    result = roman(3000)
    result == Ok("MMM")

# 3001 is MMMI
expect
    result = roman(3001)
    result == Ok("MMMI")

# 3888 is MMMDCCCLXXXVIII
expect
    result = roman(3888)
    result == Ok("MMMDCCCLXXXVIII")

# 3999 is MMMCMXCIX
expect
    result = roman(3999)
    result == Ok("MMMCMXCIX")

