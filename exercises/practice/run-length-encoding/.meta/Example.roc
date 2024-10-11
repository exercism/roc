module [encode, decode]

encode : Str -> Result Str [BadUtf8 _ _]
encode = \string ->
    appendCountAndLetter = \state ->
        if state.count == 0 then
            []
        else if state.count == 1 then
            state.chars |> List.append state.lastChar
        else
            digits = state.count |> Num.toStr |> Str.toUtf8
            state.chars |> List.concat digits |> List.append state.lastChar

    string
    |> Str.toUtf8
    |> List.walk { chars: [], lastChar: 0, count: 0 } \state, char ->
        if state.count == 0 then
            { chars: [], lastChar: char, count: 1 }
        else if state.lastChar == char then
            { state & count: state.count + 1 }
        else
            chars = appendCountAndLetter state
            { chars, lastChar: char, count: 1 }
    |> appendCountAndLetter
    |> Str.fromUtf8

decode : Str -> Result Str [BadUtf8 _ _, InvalidNumStr]
decode = \string ->
    string
        |> Str.toUtf8
        |> List.walkTry? { chars: [], digits: [] } \state, char ->
            if char >= '0' && char <= '9' then
                digits = state.digits |> List.append char
                Ok { state & digits }
            else if state.digits == [] then
                chars = state.chars |> List.append char
                Ok { state & chars }
            else
                countStr = Str.fromUtf8? state.digits
                count = Str.toU64? countStr
                chars = state.chars |> List.concat (List.repeat char count)
                Ok { chars, digits: [] }
        |> .chars
        |> Str.fromUtf8
