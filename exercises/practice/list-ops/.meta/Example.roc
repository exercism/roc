module [append, concat, filter, length, map, foldl, foldr, reverse]

append : List a, List a -> List a
append = \list1, list2 ->
    # Cheating: list1 |> List.concat list2
    when list2 is
        [] -> list1
        [first, .. as rest] -> List.append list1 first |> append rest

concat : List (List a) -> List a
concat = \lists ->
    # Cheating: list |> List.join
    when lists is
        [] -> []
        [one] -> one
        [.. as rest, one, two] -> rest |> List.append (append one two) |> concat

filter : List a, (a -> Bool) -> List a
filter = \list, function ->
    # Cheating: list |> List.keepIf function
    when list is
        [] -> []
        [.. as rest, last] ->
            if function last then
                filter rest function |> List.append last
            else
                filter rest function

length : List a -> U64
length = \list ->
    # Cheating: list |> List.len
    when list is
        [] -> 0
        [_, .. as rest] -> 1 + length rest

map : List a, (a -> b) -> List b
map = \list, function ->
    # Cheating: list |> List.map function
    when list is
        [] -> []
        [.. as rest, last] -> map rest function |> List.append (function last)

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
    # Cheating: list |> List.reverse
    when list is
        [] -> []
        [first, .. as rest] -> reverse rest |> List.append first
