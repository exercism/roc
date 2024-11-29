module [convert]

BadGridSize : [HeightWasNotAMultipleOf4, WidthWasNotAMultipleOf3, GridShapeWasNotRectangular]

convert : Str -> Result Str BadGridSize
convert = \grid ->
    if grid == "" then
        Ok ""
        else

    gridChars = grid |> Str.toUtf8 |> List.splitOn '\n'
    size = checkSize? gridChars
    gridChars
    |> List.chunksOf 4 # split vertically into groups of 4 rows
    |> List.map \rowGroup ->
        getDigitGrids rowGroup size.width
        |> List.map identifyDigit
        |> Str.joinWith ""
    |> Str.joinWith ","
    |> Ok

checkSize : List (List U8) -> Result { height : U64, width : U64 } BadGridSize
checkSize = \gridChars ->
    height = List.len gridChars
    if height % 4 != 0 then
        Err HeightWasNotAMultipleOf4
        else

    width = gridChars |> List.map List.len |> List.max |> Result.withDefault 0
    if width % 3 != 0 then
        Err WidthWasNotAMultipleOf3
        else

    isRectangular = gridChars |> List.all \row -> List.len row == width
    if isRectangular then
        Ok { height, width }
    else
        Err GridShapeWasNotRectangular

## Given four rows from the full grid, return the 3x4 grid for each digit
getDigitGrids : List (List U8), U64 -> List (List (List U8))
getDigitGrids = \rowGroup, fullGridWidth ->
    chunkedRows =
        rowGroup
        |> List.map \row ->
            row |> List.chunksOf 3
    numHorizontalChunks = fullGridWidth // 3
    List.range { start: At 0, end: Before numHorizontalChunks }
    |> List.map \chunkIndex ->
        chunkedRows
        |> List.map \chunkedRow ->
            when chunkedRow |> List.get chunkIndex is
                Ok chunk -> chunk
                Err OutOfBounds -> crash "Unreachable: we checked the grid size"

identifyDigit : List (List U8) -> Str
identifyDigit = \digitGrid ->
    #  _     _  _     _  _  _  _  _
    # | |  | _| _||_||_ |_   ||_||_|
    # |_|  ||_  _|  | _||_|  ||_| _|
    when digitGrid is
        [[' ', '_', ' '], ['|', ' ', '|'], ['|', '_', '|'], [' ', ' ', ' ']] -> "0"
        [[' ', ' ', ' '], [' ', ' ', '|'], [' ', ' ', '|'], [' ', ' ', ' ']] -> "1"
        [[' ', '_', ' '], [' ', '_', '|'], ['|', '_', ' '], [' ', ' ', ' ']] -> "2"
        [[' ', '_', ' '], [' ', '_', '|'], [' ', '_', '|'], [' ', ' ', ' ']] -> "3"
        [[' ', ' ', ' '], ['|', '_', '|'], [' ', ' ', '|'], [' ', ' ', ' ']] -> "4"
        [[' ', '_', ' '], ['|', '_', ' '], [' ', '_', '|'], [' ', ' ', ' ']] -> "5"
        [[' ', '_', ' '], ['|', '_', ' '], ['|', '_', '|'], [' ', ' ', ' ']] -> "6"
        [[' ', '_', ' '], [' ', ' ', '|'], [' ', ' ', '|'], [' ', ' ', ' ']] -> "7"
        [[' ', '_', ' '], ['|', '_', '|'], ['|', '_', '|'], [' ', ' ', ' ']] -> "8"
        [[' ', '_', ' '], ['|', '_', '|'], [' ', '_', '|'], [' ', ' ', ' ']] -> "9"
        _ -> "?"
