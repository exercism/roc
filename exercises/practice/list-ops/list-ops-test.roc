# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/list-ops/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br",
}

import pf.Task exposing [Task]

main =
    Task.ok {}

import ListOps exposing [append, concat, filter, length, map, foldl, foldr, reverse]

##
## append entries to a list and return the new list
##

# empty lists
expect append [] [] == []

# list to empty list
expect append [] [1, 2, 3, 4] == [1, 2, 3, 4]

# empty list to list
expect append [1, 2, 3, 4] [] == [1, 2, 3, 4]

# non-empty lists
expect append [1, 2] [2, 3, 4, 5] == [1, 2, 2, 3, 4, 5]

##
## concatenate a list of lists
##

# empty list
expect concat [] == []

# list of lists
expect concat [[1, 2], [3], [], [4, 5, 6]] == [1, 2, 3, 4, 5, 6]

# list of nested lists
expect concat [[[1], [2]], [[3]], [[]], [[4, 5, 6]]] == [[1], [2], [3], [], [4, 5, 6]]

##
## filter list returning only values that satisfy the filter function
##

# empty list
expect filter [] (Num.isOdd) == []

# non-empty list
expect filter [1, 2, 3, 5] (Num.isOdd) == [1, 3, 5]

##
## returns the length of a list
##

# empty list
expect length [] == 0

# non-empty list
expect length [1, 2, 3, 4] == 4

##
## return a list of elements whose values equal the list value transformed by the mapping function
##

# empty list
expect map [] (\x -> x + 1) == []

# non-empty list
expect map [1, 3, 5, 7] (\x -> x + 1) == [2, 4, 6, 8]

##
## folds (reduces) the given list from the left with a function
##

# empty list
expect foldl [] 2 (\acc, el -> el * acc) == 2

# direction independent function applied to non-empty list
expect foldl [1, 2, 3, 4] 5 (\acc, el -> el + acc) == 15

# direction dependent function applied to non-empty list
expect foldl [1, 2, 3, 4] 24 (\acc, el -> el / acc) |> Num.round == 64

##
## folds (reduces) the given list from the right with a function
##

# empty list
expect foldr [] 2 (\acc, el -> el * acc) == 2

# direction independent function applied to non-empty list
expect foldr [1, 2, 3, 4] 5 (\acc, el -> el + acc) == 15

# direction dependent function applied to non-empty list
expect foldr [1, 2, 3, 4] 24 (\acc, el -> el / acc) |> Num.round == 9

##
## reverse the elements of the list
##

# empty list
expect reverse [] == []

# non-empty list
expect reverse [1, 3, 5, 7] == [7, 5, 3, 1]

# list of lists is not flattened
expect reverse [[1, 2], [3], [], [4, 5, 6]] == [[4, 5, 6], [], [3], [1, 2]]

