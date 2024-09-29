# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/word-count/canonical-data.json
# File last updated on 2024-09-29
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import WordCount exposing [countWords]

# count one word
expect
    result = countWords "word"
    expected = Dict.fromList [
        ("word", 1),
    ]
    result == expected

# count one of each word
expect
    result = countWords "one of each"
    expected = Dict.fromList [
        ("one", 1),
        ("of", 1),
        ("each", 1),
    ]
    result == expected

# multiple occurrences of a word
expect
    result = countWords "one fish two fish red fish blue fish"
    expected = Dict.fromList [
        ("one", 1),
        ("fish", 4),
        ("two", 1),
        ("red", 1),
        ("blue", 1),
    ]
    result == expected

# handles cramped lists
expect
    result = countWords "one,two,three"
    expected = Dict.fromList [
        ("one", 1),
        ("two", 1),
        ("three", 1),
    ]
    result == expected

# handles expanded lists
expect
    result = countWords "one,\ntwo,\nthree"
    expected = Dict.fromList [
        ("one", 1),
        ("two", 1),
        ("three", 1),
    ]
    result == expected

# ignore punctuation
expect
    result = countWords "car: carpet as java: javascript!!&@$%^&"
    expected = Dict.fromList [
        ("car", 1),
        ("carpet", 1),
        ("as", 1),
        ("java", 1),
        ("javascript", 1),
    ]
    result == expected

# include numbers
expect
    result = countWords "testing, 1, 2 testing"
    expected = Dict.fromList [
        ("testing", 2),
        ("1", 1),
        ("2", 1),
    ]
    result == expected

# normalize case
expect
    result = countWords "go Go GO Stop stop"
    expected = Dict.fromList [
        ("go", 3),
        ("stop", 2),
    ]
    result == expected

# with apostrophes
expect
    result = countWords "'First: don't laugh. Then: don't cry. You're getting it.'"
    expected = Dict.fromList [
        ("first", 1),
        ("don't", 2),
        ("laugh", 1),
        ("then", 1),
        ("cry", 1),
        ("you're", 1),
        ("getting", 1),
        ("it", 1),
    ]
    result == expected

# with quotations
expect
    result = countWords "Joe can't tell between 'large' and large."
    expected = Dict.fromList [
        ("joe", 1),
        ("can't", 1),
        ("tell", 1),
        ("between", 1),
        ("large", 2),
        ("and", 1),
    ]
    result == expected

# substrings from the beginning
expect
    result = countWords "Joe can't tell between app, apple and a."
    expected = Dict.fromList [
        ("joe", 1),
        ("can't", 1),
        ("tell", 1),
        ("between", 1),
        ("app", 1),
        ("apple", 1),
        ("and", 1),
        ("a", 1),
    ]
    result == expected

# multiple spaces not detected as a word
expect
    result = countWords " multiple   whitespaces"
    expected = Dict.fromList [
        ("multiple", 1),
        ("whitespaces", 1),
    ]
    result == expected

# alternating word separators not detected as a word
expect
    result = countWords ",\n,one,\n ,two \n 'three'"
    expected = Dict.fromList [
        ("one", 1),
        ("two", 1),
        ("three", 1),
    ]
    result == expected

# quotation for word with apostrophe
expect
    result = countWords "can, can't, 'can't'"
    expected = Dict.fromList [
        ("can", 1),
        ("can't", 2),
    ]
    result == expected

