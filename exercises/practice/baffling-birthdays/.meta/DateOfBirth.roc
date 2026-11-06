##
## Example solution
##

## This exercise uses the https://github.com/kili-ilo/roc-random library
import random.Random

DateOfBirth := { year : I64, month : U8, day : U8 }.{
	# The following line enables the default `is_eq` implementation
	is_eq : _

	## This function parses a Str formatted as "YYYY-MM-DD" to a DateOfBirth at compile time
	from_quote : Str -> Try(DateOfBirth, [BadQuotedBytes(Str)])
	from_quote = |date_str| {
		match date_str.split_on("-") {
			[y, m, d] => {
				year = I64.from_str(y) ? |_| BadQuotedBytes(date_str)
				month = U8.from_str(m) ? |_| BadQuotedBytes(date_str)
				if month < 1 or month > 12 {
					return Err(BadQuotedBytes(date_str))
				}
				day = U8.from_str(d) ? |_| BadQuotedBytes(date_str)
				num_days = if month == 2 {
					28
				} else if [4, 6, 9, 11].contains(month) {
					30
				} else {
					31
				}
				if day < 1 or day > num_days {
					return Err(BadQuotedBytes(date_str))
				}
				Ok({ year, month, day })
			}
			_ => Err(BadQuotedBytes(date_str))
		}
	}

	shared_birthday : List(DateOfBirth) -> Bool
	shared_birthday = |dates| {
		mmdd = dates.map(|date| date.month.to_u16() * 100 + date.day.to_u16())
		Set.from_list(mmdd).len() < mmdd.len()
	}

	random_birthdates : { random_state : Random.State, num_dates : U64 } -> List(DateOfBirth)
	random_birthdates = |{ random_state, num_dates }| {
		Random.step(random_state, Random.list(random_birthdate, num_dates)).value
	}

	estimated_probability_of_shared_birthday : { random_state : Random.State, num_groups : U64, group_size : U64 } -> F64
	estimated_probability_of_shared_birthday = |{ random_state, num_groups, group_size }| {
		if group_size < 2 or num_groups == 0 {
			return 0
		}
		group_generator = Random.list(random_birthdate, group_size)
		result = (0..<num_groups).iter().fold(
			{ random_state, num_shared: 0.U64 },
			|acc, _| {
				{ value: group, state } = Random.step(acc.random_state, group_generator)
				is_shared = if shared_birthday(group) {
					1
				} else {
					0
				}
				{
					random_state: state,
					num_shared: acc.num_shared + is_shared,
				}
			},
		)
		100 * result.num_shared.to_f64() / num_groups.to_f64()
	}
}

# Pick a day of the year so every birthday is equally likely
random_birthdate : Random.Generator(DateOfBirth)
random_birthdate = Random.bounded_u16(1, 365)
	|> Random.map(
		|day_of_year| {
			month_offsets = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
				.keep_if(|offset| offset < day_of_year)
			month = month_offsets.len().to_u8_wrap()
			day = (day_of_year - (month_offsets.last() ?? 0)).to_u8_wrap()
			# The year does not affect shared birthdays; 2001 is not a leap year.
			DateOfBirth.{ year: 2001, month, day }
		},
	)
