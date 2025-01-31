# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/run-length-encoding/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import RunLengthEncoding exposing [encode, decode]

##
## run-length encode a string
##

# empty string
expect
    string = ""
    result = string |> encode
    expected = ""
    result == Ok(expected)

# single characters only are encoded without count
expect
    string = "XYZ"
    result = string |> encode
    expected = "XYZ"
    result == Ok(expected)

# string with no single characters
expect
    string = "AABBBCCCC"
    result = string |> encode
    expected = "2A3B4C"
    result == Ok(expected)

# single characters mixed with repeated characters
expect
    string = "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
    result = string |> encode
    expected = "12WB12W3B24WB"
    result == Ok(expected)

# multiple whitespace mixed in string
expect
    string = "  hsqq qww  "
    result = string |> encode
    expected = "2 hs2q q2w2 "
    result == Ok(expected)

# lowercase characters
expect
    string = "aabbbcccc"
    result = string |> encode
    expected = "2a3b4c"
    result == Ok(expected)

##
## run-length decode a string
##

# empty string
expect
    string = ""
    result = string |> decode
    expected = ""
    result == Ok(expected)

# single characters only
expect
    string = "XYZ"
    result = string |> decode
    expected = "XYZ"
    result == Ok(expected)

# string with no single characters
expect
    string = "2A3B4C"
    result = string |> decode
    expected = "AABBBCCCC"
    result == Ok(expected)

# single characters with repeated characters
expect
    string = "12WB12W3B24WB"
    result = string |> decode
    expected = "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
    result == Ok(expected)

# multiple whitespace mixed in string
expect
    string = "2 hs2q q2w2 "
    result = string |> decode
    expected = "  hsqq qww  "
    result == Ok(expected)

# lowercase string
expect
    string = "2a3b4c"
    result = string |> decode
    expected = "aabbbcccc"
    result == Ok(expected)

##
## encode and then decode
##

# encode followed by decode gives original string
expect
    string = "zzz ZZ  zZ"
    result = string |> encode |> Result.try(decode)
    result == Ok(string)

