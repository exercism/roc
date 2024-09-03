module [append, concat, filter, length, map, foldl, foldr, reverse]

append : List a, List a -> List a
append = \list1, list2 ->
    # Cheating: list1 |> List.concat list2
    when list1 is
        [] -> list2
        [first, .. as rest] -> (append rest list2) |> List.prepend first

concat : List (List a) -> List a
concat = \lists ->
    when lists is
        [] -> []
        [sublist1, .. as rest] -> sublist1 |> append (concat rest)

filter : List a, (a -> Bool) -> List a
filter = \list, function ->
    # Cheating: list |> List.keepIf function
    when list is
        [] -> []
        [first, .. as rest] ->
            if function first then
                filter rest function |> List.prepend first
            else
                filter rest function

length : List a -> U64
length = \list ->
    # Cheating: List.len list
    when list is
        [] -> 0
        [_, .. as rest] -> 1 + length rest

map : List a, (a -> b) -> List b
map = \list, function ->
    # Cheating: list |> List.map function
    when list is
        [] -> []
        [first, .. as rest] -> map rest function |> List.prepend (function first)

foldl : List a, b, (b, a -> b) -> b
foldl = \list, initial, function ->
    # Cheating: list |> List.walk initial function
    when list is
        [] -> initial
        [first, .. as rest] -> foldl rest (function initial first) function

foldr : List a, b, (b, a -> b) -> b
foldr = \list, initial, function ->
    # Cheating: list |> List.walkBackwards initial function
    when list is
        [] -> initial
        [.. as rest, last] -> foldr rest (function initial last) function

reverse : List a -> List a
reverse = \list ->
    # Cheating: List.reverse list
    when list is
        [] -> []
        [.. as rest, last] -> reverse rest |> List.prepend last
