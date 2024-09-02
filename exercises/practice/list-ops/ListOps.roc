module [append, concat, filter, length, map, foldl, foldr, reverse]

append : List a, List a -> List a
append = \list1, list2 ->
    crash "Please implement the 'append' function"

concat : List (List a) -> List a
concat = \lists ->
    crash "Please implement the 'concat' function"

filter : List a, (a -> Bool) -> List a
filter = \list, function ->
    crash "Please implement the 'filter' function"

length : List a -> U64
length = \list ->
    crash "Please implement the 'length' function"

map : List a, (a -> b) -> List b
map = \list, function ->
    crash "Please implement the 'map' function"

foldl : List a, b, (b, a -> b) -> b
foldl = \list, initial, function ->
    crash "Please implement the 'foldl' function"

foldr : List a, b, (b, a -> b) -> b
foldr = \list, initial, function ->
    crash "Please implement the 'foldr' function"

reverse : List a -> List a
reverse = \list ->
    crash "Please implement the 'reverse' function"
