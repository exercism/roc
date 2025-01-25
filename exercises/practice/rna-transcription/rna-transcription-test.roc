# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/rna-transcription/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/bi5zubJ-_Hva9vxxPq4kNx4WHX6oFs8OP6Ad0tCYlrY.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import RnaTranscription exposing [to_rna]

# Empty RNA sequence
expect
    result = to_rna("")
    result == ""

# RNA complement of cytosine is guanine
expect
    result = to_rna("C")
    result == "G"

# RNA complement of guanine is cytosine
expect
    result = to_rna("G")
    result == "C"

# RNA complement of thymine is adenine
expect
    result = to_rna("T")
    result == "A"

# RNA complement of adenine is uracil
expect
    result = to_rna("A")
    result == "U"

# RNA complement
expect
    result = to_rna("ACGTGGTCTTAA")
    result == "UGCACCAGAAUU"

