# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/say/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Say exposing [say]

# zero
expect
    result = say(0)
    result == Ok("zero")

# one
expect
    result = say(1)
    result == Ok("one")

# fourteen
expect
    result = say(14)
    result == Ok("fourteen")

# twenty
expect
    result = say(20)
    result == Ok("twenty")

# twenty-two
expect
    result = say(22)
    result == Ok("twenty-two")

# thirty
expect
    result = say(30)
    result == Ok("thirty")

# ninety-nine
expect
    result = say(99)
    result == Ok("ninety-nine")

# one hundred
expect
    result = say(100)
    result == Ok("one hundred")

# one hundred twenty-three
expect
    result = say(123)
    result == Ok("one hundred twenty-three")

# two hundred
expect
    result = say(200)
    result == Ok("two hundred")

# nine hundred ninety-nine
expect
    result = say(999)
    result == Ok("nine hundred ninety-nine")

# one thousand
expect
    result = say(1000)
    result == Ok("one thousand")

# one thousand two hundred thirty-four
expect
    result = say(1234)
    result == Ok("one thousand two hundred thirty-four")

# one million
expect
    result = say(1000000)
    result == Ok("one million")

# one million two thousand three hundred forty-five
expect
    result = say(1002345)
    result == Ok("one million two thousand three hundred forty-five")

# one billion
expect
    result = say(1000000000)
    result == Ok("one billion")

# a big number
expect
    result = say(987654321123)
    result == Ok("nine hundred eighty-seven billion six hundred fifty-four million three hundred twenty-one thousand one hundred twenty-three")

# numbers above 999,999,999,999 are out of range
expect
    result = say(1000000000000)
    result |> Result.is_err

