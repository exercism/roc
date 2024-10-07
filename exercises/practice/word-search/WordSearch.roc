module [search]

Position : { column : U64, row : U64 }
WordLocation : { start : Position, end : Position }

search : Str, List Str -> Dict Str WordLocation
search = \grid, wordsToSearchFor ->
    crash "Please implement the 'search' function"
