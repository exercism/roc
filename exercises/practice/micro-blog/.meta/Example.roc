

import unicode.Grapheme
MicroBlog :: {}.{
    truncate : Str -> Result Str GraphemeErrors
    truncate = |input|
        input
        |> Grapheme.split?
        |> List.take_first(5)
        |> Str.join_with("")
        |> Ok
}

GraphemeErrors : [
    CodepointTooLarge,
    EncodesSurrogateHalf,
    ExpectedContinuation,
    InvalidUtf8,
    ListWasEmpty,
    OverlongEncoding,
]
