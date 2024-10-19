module [encode, decode]

encode : List U32 -> List U8
encode = \integers ->
    integers |> List.joinMap encodeInteger

encodeInteger : U32 -> List U8
encodeInteger = \integer ->
    help = \bytes, n ->
        if n == 0 then
            bytes
        else
            nextN = n // 128 # same as n |> Num.shiftRightZfBy 7
            last7Bits = n % 128 |> Num.toU8 # same as n |> Num.bitwiseAnd 0b1111111 |> Num.toU8
            byte =
                if bytes == [] then
                    last7Bits
                else
                    last7Bits + 128 # same as last7Bits |> Num.bitwiseOr 0b10000000
            help (bytes |> List.append byte) nextN

    if integer == 0 then [0] else help [] integer |> List.reverse

decode : List U8 -> Result (List U32) [IncompleteSequence]
decode = \bytes ->
    when bytes is
        [] -> Err IncompleteSequence
        [.., last] if last >= 128 -> Err IncompleteSequence
        _ ->
            bytes
            |> List.walk { integers: [], integer: 0 } \state, byte ->
                last7Bits = byte % 128
                integer = state.integer * 128 + Num.toU32 last7Bits
                if byte >= 128 then
                    { state & integer }
                else
                    { integers: state.integers |> List.append integer, integer: 0 }
            |> .integers
            |> Ok

