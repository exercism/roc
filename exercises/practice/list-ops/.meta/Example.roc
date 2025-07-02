module [append, concat, filter, length, map, foldl, foldr, reverse]

append : List a, List a -> List a
append = |list1, list2|
    # Cheating: list1 |> List.concat list2
    when list2 is
        [] -> list1
        [first, .. as rest] -> list1 |> List.append(first) |> append(rest)

concat : List (List a) -> List a
concat = |lists|
    # Cheating: list |> List.join
    when lists is
        [] -> []
        [one] -> one
        [.. as rest, one, two] -> rest |> List.append(append(one, two)) |> concat

filter : List a, (a -> Bool) -> List a
filter = |list, function|
    # Cheating: list |> List.keep_if function
    loop = |l, acc|
        when l is
            [] -> acc
            [first, .. as rest] ->
                if function(first) then
                    rest |> loop(List.append(acc, first))
                else
                    rest |> loop(acc)

    loop(list, [])

length : List a -> U64
length = |list|
    # Cheating: list |> List.len
    loop = |l, acc|
        when l is
            [] -> acc
            [_, .. as rest] -> rest |> loop((acc + 1))
    loop(list, 0)

map : List a, (a -> b) -> List b
map = |list, function|
    # Cheating: list |> List.map function
    loop = |l, acc|
        when l is
            [] -> acc
            [first, .. as rest] -> rest |> loop(List.append(acc, function(first)))
    loop(list, [])

foldl : List a, b, (b, a -> b) -> b
foldl = |list, initial, function|
    # Cheating: list |> List.walk initial function
    when list is
        [] -> initial
        [first, .. as rest] -> rest |> foldl(function(initial, first), function)

foldr : List a, b, (b, a -> b) -> b
foldr = |list, initial, function|
    # Cheating: list |> List.walk_backwards initial function
    when list is
        [] -> initial
        [.. as rest, last] -> rest |> foldr(function(initial, last), function)

reverse : List a -> List a
reverse = |list|
    # Cheating: list |> List.reverse
    loop = |l, acc|
        when l is
            [] -> acc
            [.. as rest, last] -> rest |> loop(List.append(acc, last))
    loop(list, [])
