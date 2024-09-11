# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/clock/canonical-data.json
# File last updated on 2024-09-11
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import Clock exposing [create, add, subtract, toStr]

##
## Create a new clock with an initial time
##

# on the hour
expect
    clock = create { hours: 8 }
    result = clock |> toStr
    expected = "08:00"
    result == expected

# past the hour
expect
    clock = create { hours: 11, minutes: 9 }
    result = clock |> toStr
    expected = "11:09"
    result == expected

# midnight is zero hours
expect
    clock = create { hours: 24 }
    result = clock |> toStr
    expected = "00:00"
    result == expected

# hour rolls over
expect
    clock = create { hours: 25 }
    result = clock |> toStr
    expected = "01:00"
    result == expected

# hour rolls over continuously
expect
    clock = create { hours: 100 }
    result = clock |> toStr
    expected = "04:00"
    result == expected

# sixty minutes is next hour
expect
    clock = create { hours: 1, minutes: 60 }
    result = clock |> toStr
    expected = "02:00"
    result == expected

# minutes roll over
expect
    clock = create { minutes: 160 }
    result = clock |> toStr
    expected = "02:40"
    result == expected

# minutes roll over continuously
expect
    clock = create { minutes: 1723 }
    result = clock |> toStr
    expected = "04:43"
    result == expected

# hour and minutes roll over
expect
    clock = create { hours: 25, minutes: 160 }
    result = clock |> toStr
    expected = "03:40"
    result == expected

# hour and minutes roll over continuously
expect
    clock = create { hours: 201, minutes: 3001 }
    result = clock |> toStr
    expected = "11:01"
    result == expected

# hour and minutes roll over to exactly midnight
expect
    clock = create { hours: 72, minutes: 8640 }
    result = clock |> toStr
    expected = "00:00"
    result == expected

# negative hour
expect
    clock = create { hours: -1, minutes: 15 }
    result = clock |> toStr
    expected = "23:15"
    result == expected

# negative hour rolls over
expect
    clock = create { hours: -25 }
    result = clock |> toStr
    expected = "23:00"
    result == expected

# negative hour rolls over continuously
expect
    clock = create { hours: -91 }
    result = clock |> toStr
    expected = "05:00"
    result == expected

# negative minutes
expect
    clock = create { hours: 1, minutes: -40 }
    result = clock |> toStr
    expected = "00:20"
    result == expected

# negative minutes roll over
expect
    clock = create { hours: 1, minutes: -160 }
    result = clock |> toStr
    expected = "22:20"
    result == expected

# negative minutes roll over continuously
expect
    clock = create { hours: 1, minutes: -4820 }
    result = clock |> toStr
    expected = "16:40"
    result == expected

# negative sixty minutes is previous hour
expect
    clock = create { hours: 2, minutes: -60 }
    result = clock |> toStr
    expected = "01:00"
    result == expected

# negative hour and minutes both roll over
expect
    clock = create { hours: -25, minutes: -160 }
    result = clock |> toStr
    expected = "20:20"
    result == expected

# negative hour and minutes both roll over continuously
expect
    clock = create { hours: -121, minutes: -5810 }
    result = clock |> toStr
    expected = "22:10"
    result == expected

##
## Add minutes
##

# add minutes
expect
    clock = create { hours: 10 }
    result = clock |> add { minutes: 3 } |> toStr
    expected = "10:03"
    result == expected

# add no minutes
expect
    clock = create { hours: 6, minutes: 41 }
    result = clock |> add { minutes: 0 } |> toStr
    expected = "06:41"
    result == expected

# add to next hour
expect
    clock = create { minutes: 45 }
    result = clock |> add { minutes: 40 } |> toStr
    expected = "01:25"
    result == expected

# add more than one hour
expect
    clock = create { hours: 10 }
    result = clock |> add { minutes: 61 } |> toStr
    expected = "11:01"
    result == expected

# add more than two hours with carry
expect
    clock = create { minutes: 45 }
    result = clock |> add { minutes: 160 } |> toStr
    expected = "03:25"
    result == expected

# add across midnight
expect
    clock = create { hours: 23, minutes: 59 }
    result = clock |> add { minutes: 2 } |> toStr
    expected = "00:01"
    result == expected

# add more than one day (1500 min = 25 hrs)
expect
    clock = create { hours: 5, minutes: 32 }
    result = clock |> add { minutes: 1500 } |> toStr
    expected = "06:32"
    result == expected

# add more than two days
expect
    clock = create { hours: 1, minutes: 1 }
    result = clock |> add { minutes: 3500 } |> toStr
    expected = "11:21"
    result == expected

##
## Subtract minutes
##

# subtract minutes
expect
    clock = create { hours: 10, minutes: 3 }
    result = clock |> subtract { minutes: 3 } |> toStr
    expected = "10:00"
    result == expected

# subtract to previous hour
expect
    clock = create { hours: 10, minutes: 3 }
    result = clock |> subtract { minutes: 30 } |> toStr
    expected = "09:33"
    result == expected

# subtract more than an hour
expect
    clock = create { hours: 10, minutes: 3 }
    result = clock |> subtract { minutes: 70 } |> toStr
    expected = "08:53"
    result == expected

# subtract across midnight
expect
    clock = create { minutes: 3 }
    result = clock |> subtract { minutes: 4 } |> toStr
    expected = "23:59"
    result == expected

# subtract more than two hours
expect
    clock = create {}
    result = clock |> subtract { minutes: 160 } |> toStr
    expected = "21:20"
    result == expected

# subtract more than two hours with borrow
expect
    clock = create { hours: 6, minutes: 15 }
    result = clock |> subtract { minutes: 160 } |> toStr
    expected = "03:35"
    result == expected

# subtract more than one day (1500 min = 25 hrs)
expect
    clock = create { hours: 5, minutes: 32 }
    result = clock |> subtract { minutes: 1500 } |> toStr
    expected = "04:32"
    result == expected

# subtract more than two days
expect
    clock = create { hours: 2, minutes: 20 }
    result = clock |> subtract { minutes: 3000 } |> toStr
    expected = "00:20"
    result == expected

##
## Compare two clocks for equality
##

# clocks with same time
expect
    clock1 = create { hours: 15, minutes: 37 }
    clock2 = create { hours: 15, minutes: 37 }
    clock1 == clock2

# clocks a minute apart
expect
    clock1 = create { hours: 15, minutes: 36 }
    clock2 = create { hours: 15, minutes: 37 }
    clock1 != clock2

# clocks an hour apart
expect
    clock1 = create { hours: 14, minutes: 37 }
    clock2 = create { hours: 15, minutes: 37 }
    clock1 != clock2

# clocks with hour overflow
expect
    clock1 = create { hours: 10, minutes: 37 }
    clock2 = create { hours: 34, minutes: 37 }
    clock1 == clock2

# clocks with hour overflow by several days
expect
    clock1 = create { hours: 3, minutes: 11 }
    clock2 = create { hours: 99, minutes: 11 }
    clock1 == clock2

# clocks with negative hour
expect
    clock1 = create { hours: 22, minutes: 40 }
    clock2 = create { hours: -2, minutes: 40 }
    clock1 == clock2

# clocks with negative hour that wraps
expect
    clock1 = create { hours: 17, minutes: 3 }
    clock2 = create { hours: -31, minutes: 3 }
    clock1 == clock2

# clocks with negative hour that wraps multiple times
expect
    clock1 = create { hours: 13, minutes: 49 }
    clock2 = create { hours: -83, minutes: 49 }
    clock1 == clock2

# clocks with minute overflow
expect
    clock1 = create { minutes: 1 }
    clock2 = create { minutes: 1441 }
    clock1 == clock2

# clocks with minute overflow by several days
expect
    clock1 = create { hours: 2, minutes: 2 }
    clock2 = create { hours: 2, minutes: 4322 }
    clock1 == clock2

# clocks with negative minute
expect
    clock1 = create { hours: 2, minutes: 40 }
    clock2 = create { hours: 3, minutes: -20 }
    clock1 == clock2

# clocks with negative minute that wraps
expect
    clock1 = create { hours: 4, minutes: 10 }
    clock2 = create { hours: 5, minutes: -1490 }
    clock1 == clock2

# clocks with negative minute that wraps multiple times
expect
    clock1 = create { hours: 6, minutes: 15 }
    clock2 = create { hours: 6, minutes: -4305 }
    clock1 == clock2

# clocks with negative hours and minutes
expect
    clock1 = create { hours: 7, minutes: 32 }
    clock2 = create { hours: -12, minutes: -268 }
    clock1 == clock2

# clocks with negative hours and minutes that wrap
expect
    clock1 = create { hours: 18, minutes: 7 }
    clock2 = create { hours: -54, minutes: -11513 }
    clock1 == clock2

# full clock and zeroed clock
expect
    clock1 = create { hours: 24 }
    clock2 = create {}
    clock1 == clock2

