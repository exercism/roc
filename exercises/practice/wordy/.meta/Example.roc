module [answer]

evaluateExpression = \accumulator, operations ->
    when operations is
        [] -> Ok accumulator
        ["plus", numberString, .. as rest] ->
            evaluateExpression (accumulator + (Str.toI64? numberString)) rest

        ["minus", numberString, .. as rest] ->
            evaluateExpression (accumulator - (Str.toI64? numberString)) rest

        ["multiplied", "by", numberString, .. as rest] ->
            evaluateExpression (accumulator * (Str.toI64? numberString)) rest

        ["divided", "by", numberString, .. as rest] ->
            evaluateExpression (accumulator // (Str.toI64? numberString)) rest

        ["cubed"] -> Err (OperationsArgHadAnInvalidOperation operations)
        _ -> Err (OperationsArgHadASyntaxError operations)

answer : Str -> Result I64 [QuestionArgHadAnUnknownOperation Str, QuestionArgHadASyntaxError Str]
answer = \question ->
    words = question |> Str.replaceEach "?" " ?" |> Str.split " "
    when words is
        ["What", "is", numberString, .. as operations, "?"] ->
            maybeStartNumber = Str.toI64 numberString
            when maybeStartNumber is
                Ok startNumber ->
                    when evaluateExpression startNumber operations is
                        Err (OperationsArgHadAnInvalidOperation _) -> Err (QuestionArgHadAnUnknownOperation question)
                        Err (OperationsArgHadASyntaxError _) -> Err (QuestionArgHadASyntaxError question)
                        Err InvalidNumStr -> Err (QuestionArgHadASyntaxError question)
                        Ok result -> Ok result

                Err InvalidNumStr -> Err (QuestionArgHadASyntaxError question)

        [_, "is", _, .., "?"] -> Err (QuestionArgHadAnUnknownOperation question)
        [_, "are", .., "?"] -> Err (QuestionArgHadAnUnknownOperation question)
        _ -> Err (QuestionArgHadASyntaxError question)

