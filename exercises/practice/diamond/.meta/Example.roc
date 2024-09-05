module [diamond]

getChar : I8, I8, I8 -> U8
getChar = \rowIndex, colIndex, letterIndex ->
    if Num.abs rowIndex + Num.abs colIndex == letterIndex then
        letterIndex - Num.abs rowIndex |> Num.toU8 |> Num.add 'A'
    else
        ' '

unwrapFromUtf8 : List U8 -> Str
unwrapFromUtf8 = \chars ->
    when chars |> Str.fromUtf8 is
        Ok result -> result
        Err _ -> crash "Str.fromUtf8 should never fail here"

diamond : U8 -> Str
diamond = \letter ->
    letterIndex = letter - 'A' |> Num.toI8
    List.range { start: At -letterIndex, end: At letterIndex }
    |> List.map \rowIndex ->
        List.range { start: At -letterIndex, end: At letterIndex }
        |> List.map \colIndex -> getChar rowIndex colIndex letterIndex
        |> unwrapFromUtf8
    |> Str.joinWith "\n"
