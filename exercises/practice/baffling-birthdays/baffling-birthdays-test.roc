# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/baffling-birthdays/canonical-data.json
# File last updated on 2026-09-25
app [] {
	random: "https://github.com/kili-ilo/roc-random/releases/download/0.9.2/2ZXLX8WRqrosGu1V3VL5aXqgtfTRvJmjFPx8a26ecVmc.tar.zst",
}

import DateOfBirth exposing [estimated_probability_of_shared_birthday, random_birthdates, shared_birthday]
import random.Random

num_groups = 50_000

num_dates = 50_000

many_random_birthdates = random_birthdates({ random_state: Random.seed(0), num_dates })

# one birthdate
expect {
	!shared_birthday(["2000-01-01"])
}

# two birthdates with same year, month, and day
expect {
	shared_birthday(["2000-01-01", "2000-01-01"])
}

# two birthdates with same year and month, but different day
expect {
	!shared_birthday(["2012-05-09", "2012-05-17"])
}

# two birthdates with same month and day, but different year
expect {
	shared_birthday(["1999-10-23", "1988-10-23"])
}

# two birthdates with same year, but different month and day
expect {
	!shared_birthday(["2007-12-19", "2007-04-27"])
}

# two birthdates with different year, month, and day
expect {
	!shared_birthday(["1997-08-04", "1963-11-23"])
}

# multiple birthdates without shared birthday
expect {
	!shared_birthday(["1966-07-29", "1977-02-12", "2001-12-25", "1980-11-10"])
}

# multiple birthdates with one shared birthday
expect {
	shared_birthday(["1966-07-29", "1977-02-12", "2001-07-29", "1980-11-10"])
}

# multiple birthdates with more than one shared birthday
expect {
	shared_birthday(["1966-07-29", "1977-02-12", "2001-12-25", "1980-07-29", "2019-02-12"])
}

# generate requested number of birthdates
expect {
	many_random_birthdates.len() == num_dates
}

# years are not leap years
expect {
	is_not_leap = |year| year % 4 != 0 or (year % 400 != 0 and year % 100 == 0)
	many_random_birthdates.all(|date| is_not_leap(date.year))
}

# days are random
expect {
	# Number of days before each month in a non-leap year.
	month_offsets = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
	days_of_year = many_random_birthdates.map_try(
		|date| {
			offset = month_offsets.get(date.month.to_u64() - 1)?
			Ok(offset + date.day.to_u16())
		},
	)?
	is_uniformly_distributed(days_of_year, 1, 365)
}

# for one person
expect {
	result = estimated_probability_of_shared_birthday({ random_state: Random.seed(0), num_groups, group_size: 1 })
	result == 0
}

# among ten people
expect {
	result = estimated_probability_of_shared_birthday({ random_state: Random.seed(0), num_groups, group_size: 10 })
	result |> is_approx_eq(11.694818, { abs: 0.5 })
}

# among twenty-three people
expect {
	result = estimated_probability_of_shared_birthday({ random_state: Random.seed(0), num_groups, group_size: 23 })
	result |> is_approx_eq(50.729723, { abs: 0.5 })
}

# among seventy people
expect {
	result = estimated_probability_of_shared_birthday({ random_state: Random.seed(0), num_groups, group_size: 70 })
	result |> is_approx_eq(99.915958, { abs: 0.5 })
}

# Check that every value is in range and occurs roughly equally often.
# Allow sampling noise (five standard deviations), rather than exact counts.
is_uniformly_distributed : List(U16), U16, U16 -> Bool
is_uniformly_distributed = |values, low, high| {
	if values.is_empty() {
		return False
	}
	if !values.all(|value| value >= low and value <= high) {
		return False
	}
	expected = values.len().to_f64() / (high - low + 1).to_f64()
	tolerance = 5 * expected.sqrt()
	for value in low..=high {
		count = values.keep_if(|item| item == value).len().to_f64()
		if (count - expected).abs() > tolerance {
			return False
		}
	}
	True
}

# The following function should soon be available in Roc's builtins
is_approx_eq : F64, F64, { abs : F64 } -> Bool
is_approx_eq = |x, y, { abs }| {
	(x - y).abs() < abs
}
