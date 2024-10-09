module [keep, discard]

keep : List a, (a -> Bool) -> List a
keep = \list, predicate ->
    crash "Please implement the 'keep' function"

discard : List a, (a -> Bool) -> List a
discard = \list, predicate ->
    crash "Please implement the 'discard' function"
