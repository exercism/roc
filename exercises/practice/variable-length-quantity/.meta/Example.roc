module [encode, decode]

encode : List U32 -> List U8
encode = |integers|
    integers |> List.join_map(encode_integer)

encode_integer : U32 -> List U8
encode_integer = |integer|
    help = |bytes, n|
        if n == 0 then
            bytes
        else
            next_n = n // 128 # same as n |> Num.shift_right_zf_by 7
            last_7_bits = n % 128 |> Num.to_u8 # same as n |> Num.bitwise_and 0b1111111 |> Num.to_u8
            byte =
                if bytes == [] then
                    last_7_bits
                else
                    last_7_bits + 128 # same as last7Bits |> Num.bitwise_or 0b10000000
            help((bytes |> List.append(byte)), next_n)

    if integer == 0 then [0] else help([], integer) |> List.reverse

decode : List U8 -> Result (List U32) [IncompleteSequence]
decode = |bytes|
    when bytes is
        [] -> Err(IncompleteSequence)
        [.., last] if last >= 128 -> Err(IncompleteSequence)
        _ ->
            bytes
            |> List.walk(
                { integers: [], integer: 0 },
                |state, byte|
                    last_7_bits = byte % 128
                    integer = state.integer * 128 + Num.to_u32(last_7_bits)
                    if byte >= 128 then
                        { state & integer }
                    else
                        { integers: state.integers |> List.append(integer), integer: 0 },
            )
            |> .integers
            |> Ok
