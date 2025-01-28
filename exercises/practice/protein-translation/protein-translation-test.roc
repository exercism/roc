# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/protein-translation/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import ProteinTranslation exposing [to_protein]

# Empty RNA sequence results in no proteins
expect
    rna = ""
    result = rna |> to_protein
    result == Ok([])

# Methionine RNA sequence
expect
    rna = "AUG"
    result = rna |> to_protein
    result == Ok([Methionine])

# Phenylalanine RNA sequence 1
expect
    rna = "UUU"
    result = rna |> to_protein
    result == Ok([Phenylalanine])

# Phenylalanine RNA sequence 2
expect
    rna = "UUC"
    result = rna |> to_protein
    result == Ok([Phenylalanine])

# Leucine RNA sequence 1
expect
    rna = "UUA"
    result = rna |> to_protein
    result == Ok([Leucine])

# Leucine RNA sequence 2
expect
    rna = "UUG"
    result = rna |> to_protein
    result == Ok([Leucine])

# Serine RNA sequence 1
expect
    rna = "UCU"
    result = rna |> to_protein
    result == Ok([Serine])

# Serine RNA sequence 2
expect
    rna = "UCC"
    result = rna |> to_protein
    result == Ok([Serine])

# Serine RNA sequence 3
expect
    rna = "UCA"
    result = rna |> to_protein
    result == Ok([Serine])

# Serine RNA sequence 4
expect
    rna = "UCG"
    result = rna |> to_protein
    result == Ok([Serine])

# Tyrosine RNA sequence 1
expect
    rna = "UAU"
    result = rna |> to_protein
    result == Ok([Tyrosine])

# Tyrosine RNA sequence 2
expect
    rna = "UAC"
    result = rna |> to_protein
    result == Ok([Tyrosine])

# Cysteine RNA sequence 1
expect
    rna = "UGU"
    result = rna |> to_protein
    result == Ok([Cysteine])

# Cysteine RNA sequence 2
expect
    rna = "UGC"
    result = rna |> to_protein
    result == Ok([Cysteine])

# Tryptophan RNA sequence
expect
    rna = "UGG"
    result = rna |> to_protein
    result == Ok([Tryptophan])

# STOP codon RNA sequence 1
expect
    rna = "UAA"
    result = rna |> to_protein
    result == Ok([])

# STOP codon RNA sequence 2
expect
    rna = "UAG"
    result = rna |> to_protein
    result == Ok([])

# STOP codon RNA sequence 3
expect
    rna = "UGA"
    result = rna |> to_protein
    result == Ok([])

# Sequence of two protein codons translates into proteins
expect
    rna = "UUUUUU"
    result = rna |> to_protein
    result == Ok([Phenylalanine, Phenylalanine])

# Sequence of two different protein codons translates into proteins
expect
    rna = "UUAUUG"
    result = rna |> to_protein
    result == Ok([Leucine, Leucine])

# Translate RNA strand into correct protein list
expect
    rna = "AUGUUUUGG"
    result = rna |> to_protein
    result == Ok([Methionine, Phenylalanine, Tryptophan])

# Translation stops if STOP codon at beginning of sequence
expect
    rna = "UAGUGG"
    result = rna |> to_protein
    result == Ok([])

# Translation stops if STOP codon at end of two-codon sequence
expect
    rna = "UGGUAG"
    result = rna |> to_protein
    result == Ok([Tryptophan])

# Translation stops if STOP codon at end of three-codon sequence
expect
    rna = "AUGUUUUAA"
    result = rna |> to_protein
    result == Ok([Methionine, Phenylalanine])

# Translation stops if STOP codon in middle of three-codon sequence
expect
    rna = "UGGUAGUGG"
    result = rna |> to_protein
    result == Ok([Tryptophan])

# Translation stops if STOP codon in middle of six-codon sequence
expect
    rna = "UGGUGUUAUUAAUGGUUU"
    result = rna |> to_protein
    result == Ok([Tryptophan, Cysteine, Tyrosine])

# Sequence of two non-STOP codons does not translate to a STOP codon
expect
    rna = "AUGAUG"
    result = rna |> to_protein
    result == Ok([Methionine, Methionine])

# Unknown amino acids, not part of a codon, can't translate
expect
    rna = "XYZ"
    result = rna |> to_protein
    result |> Result.is_err

# Incomplete RNA sequence can't translate
expect
    rna = "AUGU"
    result = rna |> to_protein
    result |> Result.is_err

# Incomplete RNA sequence can translate if valid until a STOP codon
expect
    rna = "UUCUUCUAAUGGU"
    result = rna |> to_protein
    result == Ok([Phenylalanine, Phenylalanine])

