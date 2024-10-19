module [search]

Position : { column : U64, row : U64 }
WordLocation : { start : Position, end : Position }

## Pad each row with spaces to ensure all rows have the same width
padRight : List (List U8) -> { rows : List (List U8), width : U64 }
padRight = \grid ->
    width = grid |> List.map List.len |> List.max |> Result.withDefault 0
    padSpaces = \chars -> List.repeat ' ' (width - List.len chars)
    {
        rows: grid |> List.map \chars -> chars |> List.concat (padSpaces chars),
        width,
    }

getChar : List (List U8), U64, U64 -> U8
getChar = \grid, columnIndex, rowIndex ->
    grid
    |> List.get rowIndex
    |> Result.withDefault []
    |> List.get columnIndex
    |> Result.withDefault ' '

search : Str, List Str -> Dict Str WordLocation
search = \grid, wordsToSearchFor ->
    { rows, width } = grid |> Str.split "\n" |> List.map Str.toUtf8 |> padRight
    height = List.len rows
    heightI64 = height |> Num.toI64
    widthI64 = width |> Num.toI64
    maxLength = Num.max width height |> Num.toI64
    # for all possible starting positions:
    List.range { start: At 0, end: Before width }
    |> List.joinMap \columnIndex ->
        List.range { start: At 0, end: Before height }
        |> List.joinMap \rowIndex ->
            # for all possible directions:
            [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
            |> List.joinMap \(dirColumn, dirRow) ->
                start = { column: columnIndex + 1, row: rowIndex + 1 }
                # for all possible lengths:
                List.range { start: At 0, end: Before maxLength } # for all possible words starting at the given position and
                # going in the given direction, take note of the start and end
                # positions
                |> List.walkUntil { foundWords: [], chars: [] } \state, index ->
                    endColumnIndex = Num.toI64 columnIndex + dirColumn * index
                    endRowIndex = Num.toI64 rowIndex + dirRow * index
                    if endColumnIndex < 0 || endColumnIndex >= widthI64 || endRowIndex < 0 || endRowIndex >= heightI64 then
                        Break state
                        else

                    endColumnIndexU64 = endColumnIndex |> Num.toU64
                    endrowIndexU64 = endRowIndex |> Num.toU64
                    char = rows |> getChar endColumnIndexU64 endrowIndexU64
                    newChars = state.chars |> List.append char
                    end = { column: endColumnIndexU64 + 1, row: endrowIndexU64 + 1 }
                    maybeWord = wordsToSearchFor |> List.findFirst \word -> word |> Str.toUtf8 == newChars
                    newFoundWords =
                        when maybeWord is
                            Ok word -> state.foundWords |> List.append (word, { start, end })
                            Err NotFound -> state.foundWords
                    Continue { foundWords: newFoundWords, chars: newChars }
                |> .foundWords
    |> Dict.fromList
