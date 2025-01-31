# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/word-count/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import WordCount exposing [count_words]

# count one word
expect
    result = count_words("word")
    expected = Dict.from_list(
        [
            ("word", 1),
        ],
    )
    result == expected

# count one of each word
expect
    result = count_words("one of each")
    expected = Dict.from_list(
        [
            ("one", 1),
            ("of", 1),
            ("each", 1),
        ],
    )
    result == expected

# multiple occurrences of a word
expect
    result = count_words("one fish two fish red fish blue fish")
    expected = Dict.from_list(
        [
            ("one", 1),
            ("fish", 4),
            ("two", 1),
            ("red", 1),
            ("blue", 1),
        ],
    )
    result == expected

# handles cramped lists
expect
    result = count_words("one,two,three")
    expected = Dict.from_list(
        [
            ("one", 1),
            ("two", 1),
            ("three", 1),
        ],
    )
    result == expected

# handles expanded lists
expect
    result = count_words("one,\ntwo,\nthree")
    expected = Dict.from_list(
        [
            ("one", 1),
            ("two", 1),
            ("three", 1),
        ],
    )
    result == expected

# ignore punctuation
expect
    result = count_words("car: carpet as java: javascript!!&@$%^&")
    expected = Dict.from_list(
        [
            ("car", 1),
            ("carpet", 1),
            ("as", 1),
            ("java", 1),
            ("javascript", 1),
        ],
    )
    result == expected

# include numbers
expect
    result = count_words("testing, 1, 2 testing")
    expected = Dict.from_list(
        [
            ("testing", 2),
            ("1", 1),
            ("2", 1),
        ],
    )
    result == expected

# normalize case
expect
    result = count_words("go Go GO Stop stop")
    expected = Dict.from_list(
        [
            ("go", 3),
            ("stop", 2),
        ],
    )
    result == expected

# with apostrophes
expect
    result = count_words("'First: don't laugh. Then: don't cry. You're getting it.'")
    expected = Dict.from_list(
        [
            ("first", 1),
            ("don't", 2),
            ("laugh", 1),
            ("then", 1),
            ("cry", 1),
            ("you're", 1),
            ("getting", 1),
            ("it", 1),
        ],
    )
    result == expected

# with quotations
expect
    result = count_words("Joe can't tell between 'large' and large.")
    expected = Dict.from_list(
        [
            ("joe", 1),
            ("can't", 1),
            ("tell", 1),
            ("between", 1),
            ("large", 2),
            ("and", 1),
        ],
    )
    result == expected

# substrings from the beginning
expect
    result = count_words("Joe can't tell between app, apple and a.")
    expected = Dict.from_list(
        [
            ("joe", 1),
            ("can't", 1),
            ("tell", 1),
            ("between", 1),
            ("app", 1),
            ("apple", 1),
            ("and", 1),
            ("a", 1),
        ],
    )
    result == expected

# multiple spaces not detected as a word
expect
    result = count_words(" multiple   whitespaces")
    expected = Dict.from_list(
        [
            ("multiple", 1),
            ("whitespaces", 1),
        ],
    )
    result == expected

# alternating word separators not detected as a word
expect
    result = count_words(",\n,one,\n ,two \n 'three'")
    expected = Dict.from_list(
        [
            ("one", 1),
            ("two", 1),
            ("three", 1),
        ],
    )
    result == expected

# quotation for word with apostrophe
expect
    result = count_words("can, can't, 'can't'")
    expected = Dict.from_list(
        [
            ("can", 1),
            ("can't", 2),
        ],
    )
    result == expected

