# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/protein-translation/canonical-data.json
# File last updated on 2024-09-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import ProteinTranslation exposing [toProtein]

# Empty RNA sequence results in no proteins
expect
    rna = ""
    result = rna |> toProtein
    result == Ok []

# Methionine RNA sequence
expect
    rna = "AUG"
    result = rna |> toProtein
    result == Ok [Methionine]

# Phenylalanine RNA sequence 1
expect
    rna = "UUU"
    result = rna |> toProtein
    result == Ok [Phenylalanine]

# Phenylalanine RNA sequence 2
expect
    rna = "UUC"
    result = rna |> toProtein
    result == Ok [Phenylalanine]

# Leucine RNA sequence 1
expect
    rna = "UUA"
    result = rna |> toProtein
    result == Ok [Leucine]

# Leucine RNA sequence 2
expect
    rna = "UUG"
    result = rna |> toProtein
    result == Ok [Leucine]

# Serine RNA sequence 1
expect
    rna = "UCU"
    result = rna |> toProtein
    result == Ok [Serine]

# Serine RNA sequence 2
expect
    rna = "UCC"
    result = rna |> toProtein
    result == Ok [Serine]

# Serine RNA sequence 3
expect
    rna = "UCA"
    result = rna |> toProtein
    result == Ok [Serine]

# Serine RNA sequence 4
expect
    rna = "UCG"
    result = rna |> toProtein
    result == Ok [Serine]

# Tyrosine RNA sequence 1
expect
    rna = "UAU"
    result = rna |> toProtein
    result == Ok [Tyrosine]

# Tyrosine RNA sequence 2
expect
    rna = "UAC"
    result = rna |> toProtein
    result == Ok [Tyrosine]

# Cysteine RNA sequence 1
expect
    rna = "UGU"
    result = rna |> toProtein
    result == Ok [Cysteine]

# Cysteine RNA sequence 2
expect
    rna = "UGC"
    result = rna |> toProtein
    result == Ok [Cysteine]

# Tryptophan RNA sequence
expect
    rna = "UGG"
    result = rna |> toProtein
    result == Ok [Tryptophan]

# STOP codon RNA sequence 1
expect
    rna = "UAA"
    result = rna |> toProtein
    result == Ok []

# STOP codon RNA sequence 2
expect
    rna = "UAG"
    result = rna |> toProtein
    result == Ok []

# STOP codon RNA sequence 3
expect
    rna = "UGA"
    result = rna |> toProtein
    result == Ok []

# Sequence of two protein codons translates into proteins
expect
    rna = "UUUUUU"
    result = rna |> toProtein
    result == Ok [Phenylalanine, Phenylalanine]

# Sequence of two different protein codons translates into proteins
expect
    rna = "UUAUUG"
    result = rna |> toProtein
    result == Ok [Leucine, Leucine]

# Translate RNA strand into correct protein list
expect
    rna = "AUGUUUUGG"
    result = rna |> toProtein
    result == Ok [Methionine, Phenylalanine, Tryptophan]

# Translation stops if STOP codon at beginning of sequence
expect
    rna = "UAGUGG"
    result = rna |> toProtein
    result == Ok []

# Translation stops if STOP codon at end of two-codon sequence
expect
    rna = "UGGUAG"
    result = rna |> toProtein
    result == Ok [Tryptophan]

# Translation stops if STOP codon at end of three-codon sequence
expect
    rna = "AUGUUUUAA"
    result = rna |> toProtein
    result == Ok [Methionine, Phenylalanine]

# Translation stops if STOP codon in middle of three-codon sequence
expect
    rna = "UGGUAGUGG"
    result = rna |> toProtein
    result == Ok [Tryptophan]

# Translation stops if STOP codon in middle of six-codon sequence
expect
    rna = "UGGUGUUAUUAAUGGUUU"
    result = rna |> toProtein
    result == Ok [Tryptophan, Cysteine, Tyrosine]

# Sequence of two non-STOP codons does not translate to a STOP codon
expect
    rna = "AUGAUG"
    result = rna |> toProtein
    result == Ok [Methionine, Methionine]

# Unknown amino acids, not part of a codon, can't translate
expect
    rna = "XYZ"
    result = rna |> toProtein
    result |> Result.isErr

# Incomplete RNA sequence can't translate
expect
    rna = "AUGU"
    result = rna |> toProtein
    result |> Result.isErr

# Incomplete RNA sequence can translate if valid until a STOP codon
expect
    rna = "UUCUUCUAAUGGU"
    result = rna |> toProtein
    result == Ok [Phenylalanine, Phenylalanine]

