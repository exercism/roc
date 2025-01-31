module [search]

Position : { column : U64, row : U64 }
WordLocation : { start : Position, end : Position }

search : Str, List Str -> Dict Str WordLocation
search = |grid, words_to_search_for|
    crash("Please implement the 'search' function")
