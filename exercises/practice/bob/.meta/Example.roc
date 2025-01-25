module [response]

is_question = |hey_bob|
    Str.ends_with(hey_bob, "?")

is_yelling = |hey_bob|
    is_lower = |c|
        c >= 'a' and c <= 'z'
    is_upper = |c|
        c >= 'A' and c <= 'Z'
    chars = Str.to_utf8(hey_bob)
    (chars |> List.any(is_upper)) and !(chars |> List.any(is_lower))

response : Str -> Str
response = |hey_bob|
    trimmed = Str.trim(hey_bob)
    if trimmed == "" then
        "Fine. Be that way!"
    else
        is_q = is_question(trimmed)
        is_y = is_yelling(trimmed)
        if is_q and is_y then
            "Calm down, I know what I'm doing!"
        else if is_q then
            "Sure."
        else if is_y then
            "Whoa, chill out!"
        else
            "Whatever."
