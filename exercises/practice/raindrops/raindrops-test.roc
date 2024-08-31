# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/raindrops/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import Raindrops exposing [convert]

# the sound for 1 is 1
expect
    result = convert 1
    result == "1"

# the sound for 3 is Pling
expect
    result = convert 3
    result == "Pling"

# the sound for 5 is Plang
expect
    result = convert 5
    result == "Plang"

# the sound for 7 is Plong
expect
    result = convert 7
    result == "Plong"

# the sound for 6 is Pling as it has a factor 3
expect
    result = convert 6
    result == "Pling"

# 2 to the power 3 does not make a raindrop sound as 3 is the exponent not the base
expect
    result = convert 8
    result == "8"

# the sound for 9 is Pling as it has a factor 3
expect
    result = convert 9
    result == "Pling"

# the sound for 10 is Plang as it has a factor 5
expect
    result = convert 10
    result == "Plang"

# the sound for 14 is Plong as it has a factor of 7
expect
    result = convert 14
    result == "Plong"

# the sound for 15 is PlingPlang as it has factors 3 and 5
expect
    result = convert 15
    result == "PlingPlang"

# the sound for 21 is PlingPlong as it has factors 3 and 7
expect
    result = convert 21
    result == "PlingPlong"

# the sound for 25 is Plang as it has a factor 5
expect
    result = convert 25
    result == "Plang"

# the sound for 27 is Pling as it has a factor 3
expect
    result = convert 27
    result == "Pling"

# the sound for 35 is PlangPlong as it has factors 5 and 7
expect
    result = convert 35
    result == "PlangPlong"

# the sound for 49 is Plong as it has a factor 7
expect
    result = convert 49
    result == "Plong"

# the sound for 52 is 52
expect
    result = convert 52
    result == "52"

# the sound for 105 is PlingPlangPlong as it has factors 3, 5 and 7
expect
    result = convert 105
    result == "PlingPlangPlong"

# the sound for 3125 is Plang as it has a factor 5
expect
    result = convert 3125
    result == "Plang"

