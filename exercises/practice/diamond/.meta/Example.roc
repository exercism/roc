module [diamond]

makeRow : U8, U8 -> Str
makeRow = \rowIndex, numRows ->
    middleRowIndex = numRows // 2
    letterIndex =
        if rowIndex > middleRowIndex then
            numRows - rowIndex - 1
        else
            rowIndex
    center =
        if letterIndex == 0 then
            ['A']
        else
            letter = letterIndex + 'A'
            innerSpaces = List.repeat ' ' (2 * letterIndex - 1 |> Num.toU64)
            [letter] |> List.concat innerSpaces |> List.append letter

    outerSpaces = List.repeat ' ' (middleRowIndex - letterIndex |> Num.toU64)
    rowChars = outerSpaces |> List.concat center |> List.concat outerSpaces
    when rowChars |> Str.fromUtf8 is
        Ok result -> result
        Err _ -> crash "Unreachable: Str.fromUtf8 should never fail here"

diamond : U8 -> Str
diamond = \letter ->
    numRows = 2 * (letter - 'A') + 1
    List.range { start: At 0, end: Before numRows }
    |> List.map \rowIndex -> makeRow rowIndex numRows
    |> Str.joinWith "\n"
