# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/anagram/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
    unicode: "https://github.com/roc-lang/unicode/releases/download/0.3.0/9KKFsA4CdOz0JIOL7iBSI_2jGIXQ6TsFBXgd086idpY.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Anagram exposing [find_anagrams]

# no matches
expect
    result = find_anagrams("diaper", ["hello", "world", "zombies", "pants"])
    result == []

# detects two anagrams
expect
    result = find_anagrams("solemn", ["lemons", "cherry", "melons"])
    result == ["lemons", "melons"]

# does not detect anagram subsets
expect
    result = find_anagrams("good", ["dog", "goody"])
    result == []

# detects anagram
expect
    result = find_anagrams("listen", ["enlists", "google", "inlets", "banana"])
    result == ["inlets"]

# detects three anagrams
expect
    result = find_anagrams("allergy", ["gallery", "ballerina", "regally", "clergy", "largely", "leading"])
    result == ["gallery", "regally", "largely"]

# detects multiple anagrams with different case
expect
    result = find_anagrams("nose", ["Eons", "ONES"])
    result == ["Eons", "ONES"]

# does not detect non-anagrams with identical checksum
expect
    result = find_anagrams("mass", ["last"])
    result == []

# detects anagrams case-insensitively
expect
    result = find_anagrams("Orchestra", ["cashregister", "Carthorse", "radishes"])
    result == ["Carthorse"]

# detects anagrams using case-insensitive subject
expect
    result = find_anagrams("Orchestra", ["cashregister", "carthorse", "radishes"])
    result == ["carthorse"]

# detects anagrams using case-insensitive possible matches
expect
    result = find_anagrams("orchestra", ["cashregister", "Carthorse", "radishes"])
    result == ["Carthorse"]

# does not detect an anagram if the original word is repeated
expect
    result = find_anagrams("go", ["goGoGO"])
    result == []

# anagrams must use all letters exactly once
expect
    result = find_anagrams("tapper", ["patter"])
    result == []

# words are not anagrams of themselves
expect
    result = find_anagrams("BANANA", ["BANANA"])
    result == []

# words are not anagrams of themselves even if letter case is partially different
expect
    result = find_anagrams("BANANA", ["Banana"])
    result == []

# words are not anagrams of themselves even if letter case is completely different
expect
    result = find_anagrams("BANANA", ["banana"])
    result == []

# words other than themselves can be anagrams
expect
    result = find_anagrams("LISTEN", ["LISTEN", "Silent"])
    result == ["Silent"]

# different characters may have the same bytes
expect
    result = find_anagrams("a⬂", ["€a"])
    result == []

