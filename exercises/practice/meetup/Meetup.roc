module [meetup]

Week : [First, Second, Third, Fourth, Last, Teenth]
DayOfWeek : [Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday]

meetup : { year : I64, month : U8, week : Week, dayOfWeek : DayOfWeek } -> Result Str _
meetup = \{ year, month, week, dayOfWeek } ->
    crash "Please implement the 'meetup' function"

# HINT: we have added the `roc-isodate` package to the app's header in
#       meetup-test.roc, so you can use it here if you need to.
#       For example, you could import isodate.Date, just sayin'.
