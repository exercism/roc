# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/hamming/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/bi5zubJ-_Hva9vxxPq4kNx4WHX6oFs8OP6Ad0tCYlrY.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Hamming exposing [distance]

# empty strands
expect
    result = distance("", "")
    result == Ok(0)

# single letter identical strands
expect
    result = distance("A", "A")
    result == Ok(0)

# single letter different strands
expect
    result = distance("G", "T")
    result == Ok(1)

# long identical strands
expect
    result = distance("GGACTGAAATCTG", "GGACTGAAATCTG")
    result == Ok(0)

# long different strands
expect
    result = distance("GGACGGATTCTG", "AGGACGGATTCT")
    result == Ok(9)

# disallow first strand longer
expect
    result = distance("AATG", "AAA")
    Result.is_err(result)

# disallow second strand longer
expect
    result = distance("ATA", "AGTG")
    Result.is_err(result)

# disallow empty first strand
expect
    result = distance("", "G")
    Result.is_err(result)

# disallow empty second strand
expect
    result = distance("G", "")
    Result.is_err(result)

