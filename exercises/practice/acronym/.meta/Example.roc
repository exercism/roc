module [abbreviate]

abbreviate : Str -> Str
abbreviate = |text|
    bytes = Str.to_utf8(text)

    { acronym } = List.walk(
        bytes,
        { acronym: [], ready_for_letter: Bool.true },
        |state, byte|
            if state.ready_for_letter and is_letter(byte) then
                { acronym: List.append(state.acronym, byte), ready_for_letter: Bool.false }
            else if byte == ' ' or byte == '-' then
                { acronym: state.acronym, ready_for_letter: Bool.true }
            else
                state,
    )

    capitalized = List.map(acronym, capitalize)

    when Str.from_utf8(capitalized) is
        Err(_) -> crash("There was an error converting the bytes to a Str! This should never happen.")
        Ok(str) -> str

is_letter : U8 -> Bool
is_letter = |byte|
    ('a' <= byte and byte <= 'z')
    or
    ('A' <= byte and byte <= 'Z')

capitalize : U8 -> U8
capitalize = |byte|
    if 'a' <= byte and byte <= 'z' then
        byte - 'a' + 'A'
    else
        byte
