# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/hamming/canonical-data.json
# File last updated on 2024-09-03
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

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
    Result.isErr result

# disallow second strand longer
expect
    result = distance "ATA" "AGTG"
    Result.isErr result

# disallow empty first strand
expect
    result = distance "" "G"
    Result.isErr result

# disallow empty second strand
expect
    result = distance "G" ""
    Result.isErr result

