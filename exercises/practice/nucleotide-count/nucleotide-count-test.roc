# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/nucleotide-count/canonical-data.json
# File last updated on 2024-09-22
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import NucleotideCount exposing [nucleotideCounts]

# empty strand
expect
    result = nucleotideCounts ""
    result == Ok { a: 0, c: 0, g: 0, t: 0 }

# can count one nucleotide in single-character input
expect
    result = nucleotideCounts "G"
    result == Ok { a: 0, c: 0, g: 1, t: 0 }

# strand with repeated nucleotide
expect
    result = nucleotideCounts "GGGGGGG"
    result == Ok { a: 0, c: 0, g: 7, t: 0 }

# strand with multiple nucleotides
expect
    result = nucleotideCounts "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
    result == Ok { a: 20, c: 12, g: 17, t: 21 }

# strand with invalid nucleotides
expect
    result = nucleotideCounts "AGXXACT"
    Result.isErr result

