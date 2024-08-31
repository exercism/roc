# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/rna-transcription/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import RnaTranscription exposing [toRna]

# Empty RNA sequence
expect
    result = toRna ""
    result == ""

# RNA complement of cytosine is guanine
expect
    result = toRna "C"
    result == "G"

# RNA complement of guanine is cytosine
expect
    result = toRna "G"
    result == "C"

# RNA complement of thymine is adenine
expect
    result = toRna "T"
    result == "A"

# RNA complement of adenine is uracil
expect
    result = toRna "A"
    result == "U"

# RNA complement
expect
    result = toRna "ACGTGGTCTTAA"
    result == "UGCACCAGAAUU"

