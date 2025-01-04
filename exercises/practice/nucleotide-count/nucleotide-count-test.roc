# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/nucleotide-count/canonical-data.json
# File last updated on 2024-09-22
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.18.0/0APbwVN1_p1mJ96tXjaoiUCr8NBGamr8G8Ac_DrXR-o.tar.br",
}

main! = \_args ->
    Ok {}

import NucleotideCount exposing [nucleotide_counts]

# empty strand
expect
    result = nucleotide_counts ""
    result == Ok { a: 0, c: 0, g: 0, t: 0 }

# can count one nucleotide in single-character input
expect
    result = nucleotide_counts "G"
    result == Ok { a: 0, c: 0, g: 1, t: 0 }

# strand with repeated nucleotide
expect
    result = nucleotide_counts "GGGGGGG"
    result == Ok { a: 0, c: 0, g: 7, t: 0 }

# strand with multiple nucleotides
expect
    result = nucleotide_counts "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
    result == Ok { a: 20, c: 12, g: 17, t: 21 }

# strand with invalid nucleotides
expect
    result = nucleotide_counts "AGXXACT"
    Result.isErr result

