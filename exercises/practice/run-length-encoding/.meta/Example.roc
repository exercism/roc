module [encode, decode]

encode : Str -> Result Str [BadUtf8 _]
encode = |string|
    append_count_and_letter = |state|
        if state.count == 0 then
            []
        else if state.count == 1 then
            state.chars |> List.append(state.last_char)
        else
            digits = state.count |> Num.to_str |> Str.to_utf8
            state.chars |> List.concat(digits) |> List.append(state.last_char)

    string
    |> Str.to_utf8
    |> List.walk(
        { chars: [], last_char: 0, count: 0 },
        |state, char|
            if state.count == 0 then
                { chars: [], last_char: char, count: 1 }
            else if state.last_char == char then
                { state & count: state.count + 1 }
            else
                chars = append_count_and_letter(state)
                { chars, last_char: char, count: 1 },
    )
    |> append_count_and_letter
    |> Str.from_utf8

decode : Str -> Result Str [BadUtf8 _, InvalidNumStr]
decode = |string|
    string
    |> Str.to_utf8
    |> List.walk_try(
        { chars: [], digits: [] },
        |state, char|
            if char >= '0' and char <= '9' then
                digits = state.digits |> List.append(char)
                Ok({ state & digits })
            else if state.digits == [] then
                chars = state.chars |> List.append(char)
                Ok({ state & chars })
            else
                count_str = Str.from_utf8(state.digits)?
                count = Str.to_u64(count_str)?
                chars = state.chars |> List.concat(List.repeat(char, count))
                Ok({ chars, digits: [] }),
    )?
    |> .chars
    |> Str.from_utf8
