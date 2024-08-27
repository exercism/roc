module [abbreviate]

abbreviate : Str -> Str
abbreviate = \text ->
    bytes = Str.toUtf8 text

    { acronym } = List.walk bytes { acronym: [], readyForLetter: Bool.true } \state, byte ->
        if state.readyForLetter && isLetter byte then
            { acronym: List.append state.acronym byte, readyForLetter: Bool.false }
        else if byte == ' ' || byte == '-' then
            { acronym: state.acronym, readyForLetter: Bool.true }
        else
            state

    capitalized = List.map acronym capitalize

    when Str.fromUtf8 capitalized is
        Err _ -> crash "There was an error converting the bytes to a Str! This should never happen."
        Ok str -> str

isLetter : U8 -> Bool
isLetter = \byte ->
    ('a' <= byte && byte <= 'z')
    ||
    ('A' <= byte && byte <= 'Z')

capitalize : U8 -> U8
capitalize = \byte ->
    if 'a' <= byte && byte <= 'z' then
        byte - 32
    else
        byte
