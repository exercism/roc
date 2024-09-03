# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/list-ops/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import ListOps exposing [append, concat, filter, length, map, foldl, foldr, reverse]

##
## append entries to a list and return the new list
##

# empty lists
expect
    result = append [] []
    result == []

# list to empty list
expect
    result = append [] [1, 2, 3, 4]
    result == [1, 2, 3, 4]

# empty list to list
expect
    result = append [1, 2, 3, 4] []
    result == [1, 2, 3, 4]

# non-empty lists
expect
    result = append [1, 2] [2, 3, 4, 5]
    result == [1, 2, 2, 3, 4, 5]

##
## concatenate a list of lists
##

# empty list
expect
    result = concat []
    result == []

# list of lists
expect
    result = concat [[1, 2], [3], [], [4, 5, 6]]
    result == [1, 2, 3, 4, 5, 6]

# list of nested lists
expect
    result = concat [[[1], [2]], [[3]], [[]], [[4, 5, 6]]]
    result == [[1], [2], [3], [], [4, 5, 6]]

##
## filter list returning only values that satisfy the filter function
##

# empty list
expect
    result = filter [] (Num.isOdd)
    result == []

# non-empty list
expect
    result = filter [1, 2, 3, 5] (Num.isOdd)
    result == [1, 3, 5]

##
## returns the length of a list
##

# empty list
expect
    result = length []
    result == 0

# non-empty list
expect
    result = length [1, 2, 3, 4]
    result == 4

##
## return a list of elements whose values equal the list value transformed by the mapping function
##

# empty list
expect
    result = map [] (\x -> x + 1)
    result == []

# non-empty list
expect
    result = map [1, 3, 5, 7] (\x -> x + 1)
    result == [2, 4, 6, 8]

##
## folds (reduces) the given list from the left with a function
##

# empty list
expect
    result = foldl [] 2 (\acc, el -> el * acc)
    result == 2

# direction independent function applied to non-empty list
expect
    result = foldl [1, 2, 3, 4] 5 (\acc, el -> el + acc)
    result == 15

# direction dependent function applied to non-empty list
expect
    result = foldl [1, 2, 3, 4] 24 (\acc, el -> el / acc) |> Num.round
    result == 64

##
## folds (reduces) the given list from the right with a function
##

# empty list
expect
    result = foldr [] 2 (\acc, el -> el * acc)
    result == 2

# direction independent function applied to non-empty list
expect
    result = foldr [1, 2, 3, 4] 5 (\acc, el -> el + acc)
    result == 15

# direction dependent function applied to non-empty list
expect
    result = foldr [1, 2, 3, 4] 24 (\acc, el -> el / acc) |> Num.round
    result == 9

##
## reverse the elements of the list
##

# empty list
expect
    result = reverse []
    result == []

# non-empty list
expect
    result = reverse [1, 3, 5, 7]
    result == [7, 5, 3, 1]

# list of lists is not flattened
expect
    result = reverse [[1, 2], [3], [], [4, 5, 6]]
    result == [[4, 5, 6], [], [3], [1, 2]]

