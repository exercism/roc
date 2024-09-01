# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/anagram/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
    unicode: "https://github.com/roc-lang/unicode/releases/download/0.1.2/vH5iqn04ShmqP-pNemgF773f86COePSqMWHzVGrAKNo.tar.br",
}

main =
    Task.ok {}

import Anagram exposing [findAnagrams]

# no matches
expect
    result = findAnagrams "diaper" ["hello", "world", "zombies", "pants"]
    result == []

# detects two anagrams
expect
    result = findAnagrams "solemn" ["lemons", "cherry", "melons"]
    result == ["lemons", "melons"]

# does not detect anagram subsets
expect
    result = findAnagrams "good" ["dog", "goody"]
    result == []

# detects anagram
expect
    result = findAnagrams "listen" ["enlists", "google", "inlets", "banana"]
    result == ["inlets"]

# detects three anagrams
expect
    result = findAnagrams "allergy" ["gallery", "ballerina", "regally", "clergy", "largely", "leading"]
    result == ["gallery", "regally", "largely"]

# detects multiple anagrams with different case
expect
    result = findAnagrams "nose" ["Eons", "ONES"]
    result == ["Eons", "ONES"]

# does not detect non-anagrams with identical checksum
expect
    result = findAnagrams "mass" ["last"]
    result == []

# detects anagrams case-insensitively
expect
    result = findAnagrams "Orchestra" ["cashregister", "Carthorse", "radishes"]
    result == ["Carthorse"]

# detects anagrams using case-insensitive subject
expect
    result = findAnagrams "Orchestra" ["cashregister", "carthorse", "radishes"]
    result == ["carthorse"]

# detects anagrams using case-insensitive possible matches
expect
    result = findAnagrams "orchestra" ["cashregister", "Carthorse", "radishes"]
    result == ["Carthorse"]

# does not detect an anagram if the original word is repeated
expect
    result = findAnagrams "go" ["goGoGO"]
    result == []

# anagrams must use all letters exactly once
expect
    result = findAnagrams "tapper" ["patter"]
    result == []

# words are not anagrams of themselves
expect
    result = findAnagrams "BANANA" ["BANANA"]
    result == []

# words are not anagrams of themselves even if letter case is partially different
expect
    result = findAnagrams "BANANA" ["Banana"]
    result == []

# words are not anagrams of themselves even if letter case is completely different
expect
    result = findAnagrams "BANANA" ["banana"]
    result == []

# words other than themselves can be anagrams
expect
    result = findAnagrams "LISTEN" ["LISTEN", "Silent"]
    result == ["Silent"]

# different characters may have the same bytes
expect
    result = findAnagrams "a⬂" ["€a"]
    result == []

