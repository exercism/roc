# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/raindrops/canonical-data.json
# File last updated on 2024-08-25
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br",
}

import pf.Task exposing [Task]

main =
    Task.ok {}

import Raindrops exposing [convert]

# the sound for 1 is 1
expect convert 1 == "1"

# the sound for 3 is Pling
expect convert 3 == "Pling"

# the sound for 5 is Plang
expect convert 5 == "Plang"

# the sound for 7 is Plong
expect convert 7 == "Plong"

# the sound for 6 is Pling as it has a factor 3
expect convert 6 == "Pling"

# 2 to the power 3 does not make a raindrop sound as 3 is the exponent not the base
expect convert 8 == "8"

# the sound for 9 is Pling as it has a factor 3
expect convert 9 == "Pling"

# the sound for 10 is Plang as it has a factor 5
expect convert 10 == "Plang"

# the sound for 14 is Plong as it has a factor of 7
expect convert 14 == "Plong"

# the sound for 15 is PlingPlang as it has factors 3 and 5
expect convert 15 == "PlingPlang"

# the sound for 21 is PlingPlong as it has factors 3 and 7
expect convert 21 == "PlingPlong"

# the sound for 25 is Plang as it has a factor 5
expect convert 25 == "Plang"

# the sound for 27 is Pling as it has a factor 3
expect convert 27 == "Pling"

# the sound for 35 is PlangPlong as it has factors 5 and 7
expect convert 35 == "PlangPlong"

# the sound for 49 is Plong as it has a factor 7
expect convert 49 == "Plong"

# the sound for 52 is 52
expect convert 52 == "52"

# the sound for 105 is PlingPlangPlong as it has factors 3, 5 and 7
expect convert 105 == "PlingPlangPlong"

# the sound for 3125 is Plang as it has a factor 5
expect convert 3125 == "Plang"

