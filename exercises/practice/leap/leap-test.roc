# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/leap/canonical-data.json
# File last updated on 2024-08-23

app [main] { pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.12.0/Lb8EgiejTUzbggO2HVVuPJFkwvvsfW6LojkLR20kTVE.tar.br" }

import pf.Task exposing [Task]

main =
    Task.ok {}

import Leap exposing [isLeapYear]

# year not divisible by 4 in common year
expect (isLeapYear 2015) == Bool.false

# year divisible by 2, not divisible by 4 in common year
expect (isLeapYear 1970) == Bool.false

# year divisible by 4, not divisible by 100 in leap year
expect (isLeapYear 1996) == Bool.true

# year divisible by 4 and 5 is still a leap year
expect (isLeapYear 1960) == Bool.true

# year divisible by 100, not divisible by 400 in common year
expect (isLeapYear 2100) == Bool.false

# year divisible by 100 but not by 3 is still not a leap year
expect (isLeapYear 1900) == Bool.false

# year divisible by 400 is leap year
expect (isLeapYear 2000) == Bool.true

# year divisible by 400 but not by 125 is still a leap year
expect (isLeapYear 2400) == Bool.true

# year divisible by 200, not divisible by 400 in common year
expect (isLeapYear 1800) == Bool.false


