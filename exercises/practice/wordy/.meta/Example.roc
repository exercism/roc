module [answer]

parseInteger = \integerString ->
    Str.toI64 integerString |> Result.mapErr? \_ -> SyntaxError

evaluateExpression = \accumulator, operations ->
    when operations is
        [] -> Ok accumulator
        ["plus", numberString, .. as rest] ->
            evaluateExpression (accumulator + (parseInteger? numberString)) rest

        ["minus", numberString, .. as rest] ->
            evaluateExpression (accumulator - (parseInteger? numberString)) rest

        ["multiplied", "by", numberString, .. as rest] ->
            evaluateExpression (accumulator * (parseInteger? numberString)) rest

        ["divided", "by", numberString, .. as rest] ->
            evaluateExpression (accumulator // (parseInteger? numberString)) rest

        ["cubed"] -> Err UnknownOperation
        _ -> Err SyntaxError

answer : Str -> Result I64 [UnknownOperation, SyntaxError]
answer = \question ->
    words = question |> Str.replaceEach "?" " ?" |> Str.split " "
    when words is
        ["What", "is", numberString, .. as operations, "?"] ->
            evaluateExpression (parseInteger? numberString) operations

        [_, "is", _, .., "?"] -> Err UnknownOperation
        [_, "are", .., "?"] -> Err UnknownOperation
        _ -> Err SyntaxError

