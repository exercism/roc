module [response]

isQuestion = \heyBob ->
    Str.endsWith heyBob "?"

isYelling = \heyBob ->
    isLower = \c ->
        c >= 'a' && c <= 'z'
    isUpper = \c ->
        c >= 'A' && c <= 'Z'
    chars = Str.toUtf8 heyBob
    (chars |> List.any isUpper) && !(chars |> List.any isLower)

response : Str -> Str
response = \heyBob ->
    trimmed = Str.trim heyBob
    if trimmed == "" then
        "Fine. Be that way!"
    else
        isQ = isQuestion trimmed
        isY = isYelling trimmed
        if isQ && isY then
            "Calm down, I know what I'm doing!"
        else if isQ then
            "Sure."
        else if isY then
            "Whoa, chill out!"
        else
            "Whatever."
