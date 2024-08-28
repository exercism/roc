# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/hamming/canonical-data.json
# File last updated on 2024-08-28
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br",
}

import pf.Task exposing [Task]

main =
    Task.ok {}

import Hamming exposing [distance]

# empty strands
expect
    result = distance "" ""
    result == Ok 0

# single letter identical strands
expect
    result = distance "A" "A"
    result == Ok 0

# single letter different strands
expect
    result = distance "G" "T"
    result == Ok 1

# long identical strands
expect
    result = distance "GGACTGAAATCTG" "GGACTGAAATCTG"
    result == Ok 0

# long different strands
expect
    result = distance "GGACGGATTCTG" "AGGACGGATTCT"
    result == Ok 9

# disallow first strand longer
expect
    result = distance "AATG" "AAA"
    result == Err StrandsMustBeOfEqualLength

# disallow second strand longer
expect
    result = distance "ATA" "AGTG"
    result == Err StrandsMustBeOfEqualLength

# disallow empty first strand
expect
    result = distance "" "G"
    result == Err StrandsMustBeOfEqualLength

# disallow empty second strand
expect
    result = distance "G" ""
    result == Err StrandsMustBeOfEqualLength

