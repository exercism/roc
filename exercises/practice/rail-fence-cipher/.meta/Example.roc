module [encode, decode]

encodedIndices : U64, U64 -> List U64
encodedIndices = \len, rails ->
    indices = List.range { start: At 0, end: Before len }
    List.range { start: At 0, end: Before rails }
    |> List.map \rail ->
        period = 2 * (rails - 1)
        indices
        |> List.mapWithIndex \index, originalIndex ->
            toRail = originalIndex % period
            if toRail == rail || toRail == period - rail then
                [index]
            else
                []
        |> List.join
    |> List.join

decodedIndices : U64, U64 -> List U64
decodedIndices = \len, rails ->
    encodedIndices len rails
    |> List.mapWithIndex \encoded, decoded -> { encoded, decoded }
    |> List.sortWith \{ encoded: encoded1 }, { encoded: encoded2 } ->
        Num.compare encoded1 encoded2
    |> List.map .decoded

encode : Str, U64 -> Result Str [ZeroRails, BadUtf8 _ _]
encode = \message, rails ->
    message |> reorderWith encodedIndices rails

decode : Str, U64 -> Result Str [ZeroRails, BadUtf8 _ _]
decode = \encrypted, rails ->
    encrypted |> reorderWith decodedIndices rails

reorderWith : Str, (U64, U64 -> List U64), U64 -> Result Str [ZeroRails, BadUtf8 _ _]
reorderWith = \message, getIndices, rails ->
    if rails == 0 then
        Err ZeroRails
    else if rails == 1 then
        Ok message
        else

    chars = message |> Str.toUtf8
    result =
        getIndices (List.len chars) rails
        |> List.mapTry \index -> chars |> List.get index
    when result is
        Ok encryptedChars -> encryptedChars |> Str.fromUtf8
        Err OutOfBounds -> crash "Unreachable: indices cannot be out of bounds here"
