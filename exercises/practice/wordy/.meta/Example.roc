Wordy :: {}.{
	answer : Str -> Try(I64, [QuestionArgHadAnUnknownOperation(Str), QuestionArgHadASyntaxError(Str)])
	answer = |question| {
		words = question.drop_suffix("?").split_on(" ")
		match words {
			["What", "is", number_string, .. as operations] => {
				maybe_start_number = I64.from_str(number_string)
				match maybe_start_number {
					Ok(start_number) => {
						match evaluate_expression(start_number, operations) {
							Err(OperationsArgHadAnInvalidOperation(_)) => Err(QuestionArgHadAnUnknownOperation(question))
							Err(OperationsArgHadASyntaxError(_)) => Err(QuestionArgHadASyntaxError(question))
							Err(BadNumStr) => Err(QuestionArgHadASyntaxError(question))
							Ok(result) => Ok(result)
						}
					}
					Err(BadNumStr) => Err(QuestionArgHadASyntaxError(question))
				}
			}
			[_, "is", _, ..] => Err(QuestionArgHadAnUnknownOperation(question))
			[_, "are", ..] => Err(QuestionArgHadAnUnknownOperation(question))
			_ => Err(QuestionArgHadASyntaxError(question))
		}
	}
}

evaluate_expression = |accumulator, operations| {
	match operations {
		[] => Ok(accumulator)
		["plus", number_string, .. as rest] => {
			evaluate_expression((accumulator + I64.from_str(number_string)?), rest)
		}
		["minus", number_string, .. as rest] => {
			evaluate_expression((accumulator - I64.from_str(number_string)?), rest)
		}
		["multiplied", "by", number_string, .. as rest] => {
			evaluate_expression((accumulator * I64.from_str(number_string)?), rest)
		}
		["divided", "by", number_string, .. as rest] => {
			evaluate_expression((accumulator // I64.from_str(number_string)?), rest)
		}
		["cubed"] => Err(OperationsArgHadAnInvalidOperation(operations))
		_ => Err(OperationsArgHadASyntaxError(operations))
	}
}
