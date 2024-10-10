module [truncate]

import unicode.Grapheme

GraphemeErrors : [
    CodepointTooLarge,
    EncodesSurrogateHalf,
    ExpectedContinuation,
    InvalidUtf8,
    ListWasEmpty,
    OverlongEncoding,
]

truncate : Str -> Result Str GraphemeErrors
truncate = \input ->
    input
        |> Grapheme.split?
        |> List.takeFirst 5
        |> Str.joinWith ""
        |> Ok
