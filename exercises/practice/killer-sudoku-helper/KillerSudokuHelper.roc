module [combinations]

Combination : List U8

combinations : { sum : U8, size : U8, exclude ? List U8 } -> List Combination
combinations = \{ sum, size, exclude ? [] } ->
    crash "Please implement the 'combinations' function"
