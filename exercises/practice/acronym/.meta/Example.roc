module [abbreviate]

abbreviate : Str -> Str
abbreviate = \text ->
    bytes = Str.toUtf8 text

    { acronym } = List.walk bytes { acronym: [], ready_for_letter: Bool.true } \state, byte ->
        if state.ready_for_letter && isLetter byte then
            { acronym: List.append state.acronym byte, ready_for_letter: Bool.false }
        else if byte == ' ' || byte == '-' then
            { acronym: state.acronym, ready_for_letter: Bool.true }
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
        byte - 'a' + 'A'
    else
        byte
