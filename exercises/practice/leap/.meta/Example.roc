module [is_leap_year]

is_leap_year : I64 -> Bool
is_leap_year = |year|
    (year % 4 == 0) and (year % 400 == 0 or year % 100 != 0)
