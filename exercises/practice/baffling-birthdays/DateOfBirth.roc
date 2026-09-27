## This exercise uses the https://github.com/kili-ilo/roc-random library
import random.Random

DateOfBirth := { year : I64, month : U8, day : U8 }.{
	# The following line enables the default `is_eq` implementation
	is_eq : _

	## This function parses a Str formatted as "YYYY-MM-DD" to a DateOfBirth at compile time
	from_quote : Str -> Try(DateOfBirth, [BadQuotedBytes(Str)])
	from_quote = |date_str| {
		crash "Please implement the 'from_quote' function"
	}

	shared_birthday : List(DateOfBirth) -> Bool
	shared_birthday = |dates| {
		crash "Please implement the 'shared_birthday' function"
	}

	random_birthdates : { random_state : Random.State, num_dates : U64 } -> List(DateOfBirth)
	random_birthdates = |{ random_state, num_dates }| {
		crash "Please implement the 'random_birthdates' function"
	}

	estimated_probability_of_shared_birthday : { random_state : Random.State, num_groups : U64, group_size : U64 } -> F64
	estimated_probability_of_shared_birthday = |{ random_state, num_groups, group_size }| {
		crash "Please implement the 'estimated_probability_of_shared_birthday' function"
	}
}
