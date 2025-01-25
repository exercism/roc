module [answer]

evaluate_expression = |accumulator, operations|
    when operations is
        [] -> Ok(accumulator)
        ["plus", number_string, .. as rest] ->
            evaluate_expression((accumulator + Str.to_i64(number_string)?), rest)

        ["minus", number_string, .. as rest] ->
            evaluate_expression(accumulator - Str.to_i64(number_string)?, rest)

        ["multiplied", "by", number_string, .. as rest] ->
            evaluate_expression(accumulator * Str.to_i64(number_string)?, rest)

        ["divided", "by", number_string, .. as rest] ->
            evaluate_expression(accumulator // Str.to_i64(number_string)?, rest)

        ["cubed"] -> Err(OperationsArgHadAnInvalidOperation(operations))
        _ -> Err(OperationsArgHadASyntaxError(operations))

answer : Str -> Result I64 [QuestionArgHadAnUnknownOperation Str, QuestionArgHadASyntaxError Str]
answer = |question|
    words = question |> Str.replace_each("?", " ?") |> Str.split_on(" ")
    when words is
        ["What", "is", number_string, .. as operations, "?"] ->
            maybe_start_number = Str.to_i64(number_string)
            when maybe_start_number is
                Ok(start_number) ->
                    when evaluate_expression(start_number, operations) is
                        Err(OperationsArgHadAnInvalidOperation(_)) -> Err(QuestionArgHadAnUnknownOperation(question))
                        Err(OperationsArgHadASyntaxError(_)) -> Err(QuestionArgHadASyntaxError(question))
                        Err(InvalidNumStr) -> Err(QuestionArgHadASyntaxError(question))
                        Ok(result) -> Ok(result)

                Err(InvalidNumStr) -> Err(QuestionArgHadASyntaxError(question))

        [_, "is", _, .., "?"] -> Err(QuestionArgHadAnUnknownOperation(question))
        [_, "are", .., "?"] -> Err(QuestionArgHadAnUnknownOperation(question))
        _ -> Err(QuestionArgHadASyntaxError(question))
