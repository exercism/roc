module [isLeapYear]

isLeapYear = \year ->
    (year % 4 == 0) && (year % 400 == 0 || year % 100 != 0)
