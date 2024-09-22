module [truncate]

import unicode.CodePoint

truncate : Str -> Result Str _
truncate = \input ->
    Str.toUtf8 input
        |> CodePoint.parseUtf8?
        |> List.takeFirst 5
        |> CodePoint.toStr
