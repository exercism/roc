KillerSudokuHelper :: {}.{
    combinations : { sum : U8, size : U8, exclude ?? List U8 } -> List Combination
    combinations = |{ sum, size, exclude ?? [] }|
        crash("Please implement the 'combinations' function")
}


Combination : List U8
