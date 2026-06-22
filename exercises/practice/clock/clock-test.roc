# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/clock/canonical-data.json
# File last updated on 2026-06-22

import Clock exposing [create, add, subtract, to_str]

##
## Create a new clock with an initial time
##

# on the hour
expect {
	clock = create({ hour: 8, minute: 0 })
	result = clock.to_str()
	expected = "08:00"
	result == expected
}

# past the hour
expect {
	clock = create({ hour: 11, minute: 9 })
	result = clock.to_str()
	expected = "11:09"
	result == expected
}

# midnight is zero hours
expect {
	clock = create({ hour: 24, minute: 0 })
	result = clock.to_str()
	expected = "00:00"
	result == expected
}

# hour rolls over
expect {
	clock = create({ hour: 25, minute: 0 })
	result = clock.to_str()
	expected = "01:00"
	result == expected
}

# hour rolls over continuously
expect {
	clock = create({ hour: 100, minute: 0 })
	result = clock.to_str()
	expected = "04:00"
	result == expected
}

# sixty minutes is next hour
expect {
	clock = create({ hour: 1, minute: 60 })
	result = clock.to_str()
	expected = "02:00"
	result == expected
}

# minutes roll over
expect {
	clock = create({ hour: 0, minute: 160 })
	result = clock.to_str()
	expected = "02:40"
	result == expected
}

# minutes roll over continuously
expect {
	clock = create({ hour: 0, minute: 1723 })
	result = clock.to_str()
	expected = "04:43"
	result == expected
}

# hour and minutes roll over
expect {
	clock = create({ hour: 25, minute: 160 })
	result = clock.to_str()
	expected = "03:40"
	result == expected
}

# hour and minutes roll over continuously
expect {
	clock = create({ hour: 201, minute: 3001 })
	result = clock.to_str()
	expected = "11:01"
	result == expected
}

# hour and minutes roll over to exactly midnight
expect {
	clock = create({ hour: 72, minute: 8640 })
	result = clock.to_str()
	expected = "00:00"
	result == expected
}

# negative hour
expect {
	clock = create({ hour: -1, minute: 15 })
	result = clock.to_str()
	expected = "23:15"
	result == expected
}

# negative hour rolls over
expect {
	clock = create({ hour: -25, minute: 0 })
	result = clock.to_str()
	expected = "23:00"
	result == expected
}

# negative hour rolls over continuously
expect {
	clock = create({ hour: -91, minute: 0 })
	result = clock.to_str()
	expected = "05:00"
	result == expected
}

# negative minutes
expect {
	clock = create({ hour: 1, minute: -40 })
	result = clock.to_str()
	expected = "00:20"
	result == expected
}

# negative minutes roll over
expect {
	clock = create({ hour: 1, minute: -160 })
	result = clock.to_str()
	expected = "22:20"
	result == expected
}

# negative minutes roll over continuously
expect {
	clock = create({ hour: 1, minute: -4820 })
	result = clock.to_str()
	expected = "16:40"
	result == expected
}

# negative sixty minutes is previous hour
expect {
	clock = create({ hour: 2, minute: -60 })
	result = clock.to_str()
	expected = "01:00"
	result == expected
}

# negative hour and minutes both roll over
expect {
	clock = create({ hour: -25, minute: -160 })
	result = clock.to_str()
	expected = "20:20"
	result == expected
}

# negative hour and minutes both roll over continuously
expect {
	clock = create({ hour: -121, minute: -5810 })
	result = clock.to_str()
	expected = "22:10"
	result == expected
}

##
## Add minutes
##

# add minutes
expect {
	clock = create({ hour: 10, minute: 0 })
	result = clock.add({ hour: 0, minute: 3 }).to_str()
	expected = "10:03"
	result == expected
}

# add no minutes
expect {
	clock = create({ hour: 6, minute: 41 })
	result = clock.add({ hour: 0, minute: 0 }).to_str()
	expected = "06:41"
	result == expected
}

# add to next hour
expect {
	clock = create({ hour: 0, minute: 45 })
	result = clock.add({ hour: 0, minute: 40 }).to_str()
	expected = "01:25"
	result == expected
}

# add more than one hour
expect {
	clock = create({ hour: 10, minute: 0 })
	result = clock.add({ hour: 0, minute: 61 }).to_str()
	expected = "11:01"
	result == expected
}

# add more than two hours with carry
expect {
	clock = create({ hour: 0, minute: 45 })
	result = clock.add({ hour: 0, minute: 160 }).to_str()
	expected = "03:25"
	result == expected
}

# add across midnight
expect {
	clock = create({ hour: 23, minute: 59 })
	result = clock.add({ hour: 0, minute: 2 }).to_str()
	expected = "00:01"
	result == expected
}

# add more than one day (1500 min = 25 hrs)
expect {
	clock = create({ hour: 5, minute: 32 })
	result = clock.add({ hour: 0, minute: 1500 }).to_str()
	expected = "06:32"
	result == expected
}

# add more than two days
expect {
	clock = create({ hour: 1, minute: 1 })
	result = clock.add({ hour: 0, minute: 3500 }).to_str()
	expected = "11:21"
	result == expected
}

##
## Subtract minutes
##

# subtract minutes
expect {
	clock = create({ hour: 10, minute: 3 })
	result = clock.subtract({ hour: 0, minute: 3 }).to_str()
	expected = "10:00"
	result == expected
}

# subtract to previous hour
expect {
	clock = create({ hour: 10, minute: 3 })
	result = clock.subtract({ hour: 0, minute: 30 }).to_str()
	expected = "09:33"
	result == expected
}

# subtract more than an hour
expect {
	clock = create({ hour: 10, minute: 3 })
	result = clock.subtract({ hour: 0, minute: 70 }).to_str()
	expected = "08:53"
	result == expected
}

# subtract across midnight
expect {
	clock = create({ hour: 0, minute: 3 })
	result = clock.subtract({ hour: 0, minute: 4 }).to_str()
	expected = "23:59"
	result == expected
}

# subtract more than two hours
expect {
	clock = create({ hour: 0, minute: 0 })
	result = clock.subtract({ hour: 0, minute: 160 }).to_str()
	expected = "21:20"
	result == expected
}

# subtract more than two hours with borrow
expect {
	clock = create({ hour: 6, minute: 15 })
	result = clock.subtract({ hour: 0, minute: 160 }).to_str()
	expected = "03:35"
	result == expected
}

# subtract more than one day (1500 min = 25 hrs)
expect {
	clock = create({ hour: 5, minute: 32 })
	result = clock.subtract({ hour: 0, minute: 1500 }).to_str()
	expected = "04:32"
	result == expected
}

# subtract more than two days
expect {
	clock = create({ hour: 2, minute: 20 })
	result = clock.subtract({ hour: 0, minute: 3000 }).to_str()
	expected = "00:20"
	result == expected
}

##
## Compare two clocks for equality
##

# clocks with same time
expect {
	clock1 = create({ hour: 15, minute: 37 })
	clock2 = create({ hour: 15, minute: 37 })
	clock1 == clock2
}

# clocks a minute apart
expect {
	clock1 = create({ hour: 15, minute: 36 })
	clock2 = create({ hour: 15, minute: 37 })
	clock1 != clock2
}

# clocks an hour apart
expect {
	clock1 = create({ hour: 14, minute: 37 })
	clock2 = create({ hour: 15, minute: 37 })
	clock1 != clock2
}

# clocks with hour overflow
expect {
	clock1 = create({ hour: 10, minute: 37 })
	clock2 = create({ hour: 34, minute: 37 })
	clock1 == clock2
}

# clocks with hour overflow by several days
expect {
	clock1 = create({ hour: 3, minute: 11 })
	clock2 = create({ hour: 99, minute: 11 })
	clock1 == clock2
}

# clocks with negative hour
expect {
	clock1 = create({ hour: 22, minute: 40 })
	clock2 = create({ hour: -2, minute: 40 })
	clock1 == clock2
}

# clocks with negative hour that wraps
expect {
	clock1 = create({ hour: 17, minute: 3 })
	clock2 = create({ hour: -31, minute: 3 })
	clock1 == clock2
}

# clocks with negative hour that wraps multiple times
expect {
	clock1 = create({ hour: 13, minute: 49 })
	clock2 = create({ hour: -83, minute: 49 })
	clock1 == clock2
}

# clocks with minute overflow
expect {
	clock1 = create({ hour: 0, minute: 1 })
	clock2 = create({ hour: 0, minute: 1441 })
	clock1 == clock2
}

# clocks with minute overflow by several days
expect {
	clock1 = create({ hour: 2, minute: 2 })
	clock2 = create({ hour: 2, minute: 4322 })
	clock1 == clock2
}

# clocks with negative minute
expect {
	clock1 = create({ hour: 2, minute: 40 })
	clock2 = create({ hour: 3, minute: -20 })
	clock1 == clock2
}

# clocks with negative minute that wraps
expect {
	clock1 = create({ hour: 4, minute: 10 })
	clock2 = create({ hour: 5, minute: -1490 })
	clock1 == clock2
}

# clocks with negative minute that wraps multiple times
expect {
	clock1 = create({ hour: 6, minute: 15 })
	clock2 = create({ hour: 6, minute: -4305 })
	clock1 == clock2
}

# clocks with negative hours and minutes
expect {
	clock1 = create({ hour: 7, minute: 32 })
	clock2 = create({ hour: -12, minute: -268 })
	clock1 == clock2
}

# clocks with negative hours and minutes that wrap
expect {
	clock1 = create({ hour: 18, minute: 7 })
	clock2 = create({ hour: -54, minute: -11513 })
	clock1 == clock2
}

# full clock and zeroed clock
expect {
	clock1 = create({ hour: 24, minute: 0 })
	clock2 = create({ hour: 0, minute: 0 })
	clock1 == clock2
}

##
## Extreme I64 values should not crash with overflow errors
##

# Can create a clock with max I64 values
expect {
	clock = create({ hour: 9223372036854775807, minute: 9223372036854775807 })
	result = clock.to_str()
	expected = "01:07"
	result == expected
}

# Can create a clock with min I64 values
expect {
	clock = create({ hour: -9223372036854775808, minute: -9223372036854775808 })
	result = clock.to_str()
	expected = "21:52"
	result == expected
}

# Can add max I64 values to a clock
expect {
	clock = create({ hour: 23, minute: 59 })
	result = clock.add({ hour: 0, minute: 9223372036854775807 }).to_str()
	expected = "18:06"
	result == expected
}

# Can add min I64 values to a clock
expect {
	clock = create({ hour: 23, minute: 59 })
	result = clock.add({ hour: 0, minute: -9223372036854775808 }).to_str()
	expected = "05:51"
	result == expected
}

# Can subtract max I64 values from a clock
expect {
	clock = create({ hour: 23, minute: 59 })
	result = clock.subtract({ hour: 0, minute: 9223372036854775807 }).to_str()
	expected = "05:52"
	result == expected
}

# Can subtract min I64 values from a clock
expect {
	clock = create({ hour: 23, minute: 59 })
	result = clock.subtract({ hour: 0, minute: -9223372036854775808 }).to_str()
	expected = "18:07"
	result == expected
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
