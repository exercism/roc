# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/meetup/canonical-data.json
# File last updated on 2024-10-18
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
    isodate: "https://github.com/imclerran/roc-isodate/releases/download/v0.5.1/XHx5wx95nuICKpN8sxMwYnCme5oX_YFbJUL1s6D1feU.tar.br",
}

main =
    Task.ok {}

import Meetup exposing [meetup]

# when teenth Monday is the 13th, the first day of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 5,
        week: Teenth,
        dayOfWeek: Monday,
    }
    expected = Ok "2013-05-13"
    result == expected

# when teenth Monday is the 19th, the last day of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 8,
        week: Teenth,
        dayOfWeek: Monday,
    }
    expected = Ok "2013-08-19"
    result == expected

# when teenth Monday is some day in the middle of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 9,
        week: Teenth,
        dayOfWeek: Monday,
    }
    expected = Ok "2013-09-16"
    result == expected

# when teenth Tuesday is the 19th, the last day of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 3,
        week: Teenth,
        dayOfWeek: Tuesday,
    }
    expected = Ok "2013-03-19"
    result == expected

# when teenth Tuesday is some day in the middle of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 4,
        week: Teenth,
        dayOfWeek: Tuesday,
    }
    expected = Ok "2013-04-16"
    result == expected

# when teenth Tuesday is the 13th, the first day of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 8,
        week: Teenth,
        dayOfWeek: Tuesday,
    }
    expected = Ok "2013-08-13"
    result == expected

# when teenth Wednesday is some day in the middle of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 1,
        week: Teenth,
        dayOfWeek: Wednesday,
    }
    expected = Ok "2013-01-16"
    result == expected

# when teenth Wednesday is the 13th, the first day of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 2,
        week: Teenth,
        dayOfWeek: Wednesday,
    }
    expected = Ok "2013-02-13"
    result == expected

# when teenth Wednesday is the 19th, the last day of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 6,
        week: Teenth,
        dayOfWeek: Wednesday,
    }
    expected = Ok "2013-06-19"
    result == expected

# when teenth Thursday is some day in the middle of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 5,
        week: Teenth,
        dayOfWeek: Thursday,
    }
    expected = Ok "2013-05-16"
    result == expected

# when teenth Thursday is the 13th, the first day of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 6,
        week: Teenth,
        dayOfWeek: Thursday,
    }
    expected = Ok "2013-06-13"
    result == expected

# when teenth Thursday is the 19th, the last day of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 9,
        week: Teenth,
        dayOfWeek: Thursday,
    }
    expected = Ok "2013-09-19"
    result == expected

# when teenth Friday is the 19th, the last day of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 4,
        week: Teenth,
        dayOfWeek: Friday,
    }
    expected = Ok "2013-04-19"
    result == expected

# when teenth Friday is some day in the middle of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 8,
        week: Teenth,
        dayOfWeek: Friday,
    }
    expected = Ok "2013-08-16"
    result == expected

# when teenth Friday is the 13th, the first day of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 9,
        week: Teenth,
        dayOfWeek: Friday,
    }
    expected = Ok "2013-09-13"
    result == expected

# when teenth Saturday is some day in the middle of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 2,
        week: Teenth,
        dayOfWeek: Saturday,
    }
    expected = Ok "2013-02-16"
    result == expected

# when teenth Saturday is the 13th, the first day of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 4,
        week: Teenth,
        dayOfWeek: Saturday,
    }
    expected = Ok "2013-04-13"
    result == expected

# when teenth Saturday is the 19th, the last day of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 10,
        week: Teenth,
        dayOfWeek: Saturday,
    }
    expected = Ok "2013-10-19"
    result == expected

# when teenth Sunday is the 19th, the last day of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 5,
        week: Teenth,
        dayOfWeek: Sunday,
    }
    expected = Ok "2013-05-19"
    result == expected

# when teenth Sunday is some day in the middle of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 6,
        week: Teenth,
        dayOfWeek: Sunday,
    }
    expected = Ok "2013-06-16"
    result == expected

# when teenth Sunday is the 13th, the first day of the teenth week
expect
    result = meetup {
        year: 2013,
        month: 10,
        week: Teenth,
        dayOfWeek: Sunday,
    }
    expected = Ok "2013-10-13"
    result == expected

# when first Monday is some day in the middle of the first week
expect
    result = meetup {
        year: 2013,
        month: 3,
        week: First,
        dayOfWeek: Monday,
    }
    expected = Ok "2013-03-04"
    result == expected

# when first Monday is the 1st, the first day of the first week
expect
    result = meetup {
        year: 2013,
        month: 4,
        week: First,
        dayOfWeek: Monday,
    }
    expected = Ok "2013-04-01"
    result == expected

# when first Tuesday is the 7th, the last day of the first week
expect
    result = meetup {
        year: 2013,
        month: 5,
        week: First,
        dayOfWeek: Tuesday,
    }
    expected = Ok "2013-05-07"
    result == expected

# when first Tuesday is some day in the middle of the first week
expect
    result = meetup {
        year: 2013,
        month: 6,
        week: First,
        dayOfWeek: Tuesday,
    }
    expected = Ok "2013-06-04"
    result == expected

# when first Wednesday is some day in the middle of the first week
expect
    result = meetup {
        year: 2013,
        month: 7,
        week: First,
        dayOfWeek: Wednesday,
    }
    expected = Ok "2013-07-03"
    result == expected

# when first Wednesday is the 7th, the last day of the first week
expect
    result = meetup {
        year: 2013,
        month: 8,
        week: First,
        dayOfWeek: Wednesday,
    }
    expected = Ok "2013-08-07"
    result == expected

# when first Thursday is some day in the middle of the first week
expect
    result = meetup {
        year: 2013,
        month: 9,
        week: First,
        dayOfWeek: Thursday,
    }
    expected = Ok "2013-09-05"
    result == expected

# when first Thursday is another day in the middle of the first week
expect
    result = meetup {
        year: 2013,
        month: 10,
        week: First,
        dayOfWeek: Thursday,
    }
    expected = Ok "2013-10-03"
    result == expected

# when first Friday is the 1st, the first day of the first week
expect
    result = meetup {
        year: 2013,
        month: 11,
        week: First,
        dayOfWeek: Friday,
    }
    expected = Ok "2013-11-01"
    result == expected

# when first Friday is some day in the middle of the first week
expect
    result = meetup {
        year: 2013,
        month: 12,
        week: First,
        dayOfWeek: Friday,
    }
    expected = Ok "2013-12-06"
    result == expected

# when first Saturday is some day in the middle of the first week
expect
    result = meetup {
        year: 2013,
        month: 1,
        week: First,
        dayOfWeek: Saturday,
    }
    expected = Ok "2013-01-05"
    result == expected

# when first Saturday is another day in the middle of the first week
expect
    result = meetup {
        year: 2013,
        month: 2,
        week: First,
        dayOfWeek: Saturday,
    }
    expected = Ok "2013-02-02"
    result == expected

# when first Sunday is some day in the middle of the first week
expect
    result = meetup {
        year: 2013,
        month: 3,
        week: First,
        dayOfWeek: Sunday,
    }
    expected = Ok "2013-03-03"
    result == expected

# when first Sunday is the 7th, the last day of the first week
expect
    result = meetup {
        year: 2013,
        month: 4,
        week: First,
        dayOfWeek: Sunday,
    }
    expected = Ok "2013-04-07"
    result == expected

# when second Monday is some day in the middle of the second week
expect
    result = meetup {
        year: 2013,
        month: 3,
        week: Second,
        dayOfWeek: Monday,
    }
    expected = Ok "2013-03-11"
    result == expected

# when second Monday is the 8th, the first day of the second week
expect
    result = meetup {
        year: 2013,
        month: 4,
        week: Second,
        dayOfWeek: Monday,
    }
    expected = Ok "2013-04-08"
    result == expected

# when second Tuesday is the 14th, the last day of the second week
expect
    result = meetup {
        year: 2013,
        month: 5,
        week: Second,
        dayOfWeek: Tuesday,
    }
    expected = Ok "2013-05-14"
    result == expected

# when second Tuesday is some day in the middle of the second week
expect
    result = meetup {
        year: 2013,
        month: 6,
        week: Second,
        dayOfWeek: Tuesday,
    }
    expected = Ok "2013-06-11"
    result == expected

# when second Wednesday is some day in the middle of the second week
expect
    result = meetup {
        year: 2013,
        month: 7,
        week: Second,
        dayOfWeek: Wednesday,
    }
    expected = Ok "2013-07-10"
    result == expected

# when second Wednesday is the 14th, the last day of the second week
expect
    result = meetup {
        year: 2013,
        month: 8,
        week: Second,
        dayOfWeek: Wednesday,
    }
    expected = Ok "2013-08-14"
    result == expected

# when second Thursday is some day in the middle of the second week
expect
    result = meetup {
        year: 2013,
        month: 9,
        week: Second,
        dayOfWeek: Thursday,
    }
    expected = Ok "2013-09-12"
    result == expected

# when second Thursday is another day in the middle of the second week
expect
    result = meetup {
        year: 2013,
        month: 10,
        week: Second,
        dayOfWeek: Thursday,
    }
    expected = Ok "2013-10-10"
    result == expected

# when second Friday is the 8th, the first day of the second week
expect
    result = meetup {
        year: 2013,
        month: 11,
        week: Second,
        dayOfWeek: Friday,
    }
    expected = Ok "2013-11-08"
    result == expected

# when second Friday is some day in the middle of the second week
expect
    result = meetup {
        year: 2013,
        month: 12,
        week: Second,
        dayOfWeek: Friday,
    }
    expected = Ok "2013-12-13"
    result == expected

# when second Saturday is some day in the middle of the second week
expect
    result = meetup {
        year: 2013,
        month: 1,
        week: Second,
        dayOfWeek: Saturday,
    }
    expected = Ok "2013-01-12"
    result == expected

# when second Saturday is another day in the middle of the second week
expect
    result = meetup {
        year: 2013,
        month: 2,
        week: Second,
        dayOfWeek: Saturday,
    }
    expected = Ok "2013-02-09"
    result == expected

# when second Sunday is some day in the middle of the second week
expect
    result = meetup {
        year: 2013,
        month: 3,
        week: Second,
        dayOfWeek: Sunday,
    }
    expected = Ok "2013-03-10"
    result == expected

# when second Sunday is the 14th, the last day of the second week
expect
    result = meetup {
        year: 2013,
        month: 4,
        week: Second,
        dayOfWeek: Sunday,
    }
    expected = Ok "2013-04-14"
    result == expected

# when third Monday is some day in the middle of the third week
expect
    result = meetup {
        year: 2013,
        month: 3,
        week: Third,
        dayOfWeek: Monday,
    }
    expected = Ok "2013-03-18"
    result == expected

# when third Monday is the 15th, the first day of the third week
expect
    result = meetup {
        year: 2013,
        month: 4,
        week: Third,
        dayOfWeek: Monday,
    }
    expected = Ok "2013-04-15"
    result == expected

# when third Tuesday is the 21st, the last day of the third week
expect
    result = meetup {
        year: 2013,
        month: 5,
        week: Third,
        dayOfWeek: Tuesday,
    }
    expected = Ok "2013-05-21"
    result == expected

# when third Tuesday is some day in the middle of the third week
expect
    result = meetup {
        year: 2013,
        month: 6,
        week: Third,
        dayOfWeek: Tuesday,
    }
    expected = Ok "2013-06-18"
    result == expected

# when third Wednesday is some day in the middle of the third week
expect
    result = meetup {
        year: 2013,
        month: 7,
        week: Third,
        dayOfWeek: Wednesday,
    }
    expected = Ok "2013-07-17"
    result == expected

# when third Wednesday is the 21st, the last day of the third week
expect
    result = meetup {
        year: 2013,
        month: 8,
        week: Third,
        dayOfWeek: Wednesday,
    }
    expected = Ok "2013-08-21"
    result == expected

# when third Thursday is some day in the middle of the third week
expect
    result = meetup {
        year: 2013,
        month: 9,
        week: Third,
        dayOfWeek: Thursday,
    }
    expected = Ok "2013-09-19"
    result == expected

# when third Thursday is another day in the middle of the third week
expect
    result = meetup {
        year: 2013,
        month: 10,
        week: Third,
        dayOfWeek: Thursday,
    }
    expected = Ok "2013-10-17"
    result == expected

# when third Friday is the 15th, the first day of the third week
expect
    result = meetup {
        year: 2013,
        month: 11,
        week: Third,
        dayOfWeek: Friday,
    }
    expected = Ok "2013-11-15"
    result == expected

# when third Friday is some day in the middle of the third week
expect
    result = meetup {
        year: 2013,
        month: 12,
        week: Third,
        dayOfWeek: Friday,
    }
    expected = Ok "2013-12-20"
    result == expected

# when third Saturday is some day in the middle of the third week
expect
    result = meetup {
        year: 2013,
        month: 1,
        week: Third,
        dayOfWeek: Saturday,
    }
    expected = Ok "2013-01-19"
    result == expected

# when third Saturday is another day in the middle of the third week
expect
    result = meetup {
        year: 2013,
        month: 2,
        week: Third,
        dayOfWeek: Saturday,
    }
    expected = Ok "2013-02-16"
    result == expected

# when third Sunday is some day in the middle of the third week
expect
    result = meetup {
        year: 2013,
        month: 3,
        week: Third,
        dayOfWeek: Sunday,
    }
    expected = Ok "2013-03-17"
    result == expected

# when third Sunday is the 21st, the last day of the third week
expect
    result = meetup {
        year: 2013,
        month: 4,
        week: Third,
        dayOfWeek: Sunday,
    }
    expected = Ok "2013-04-21"
    result == expected

# when fourth Monday is some day in the middle of the fourth week
expect
    result = meetup {
        year: 2013,
        month: 3,
        week: Fourth,
        dayOfWeek: Monday,
    }
    expected = Ok "2013-03-25"
    result == expected

# when fourth Monday is the 22nd, the first day of the fourth week
expect
    result = meetup {
        year: 2013,
        month: 4,
        week: Fourth,
        dayOfWeek: Monday,
    }
    expected = Ok "2013-04-22"
    result == expected

# when fourth Tuesday is the 28th, the last day of the fourth week
expect
    result = meetup {
        year: 2013,
        month: 5,
        week: Fourth,
        dayOfWeek: Tuesday,
    }
    expected = Ok "2013-05-28"
    result == expected

# when fourth Tuesday is some day in the middle of the fourth week
expect
    result = meetup {
        year: 2013,
        month: 6,
        week: Fourth,
        dayOfWeek: Tuesday,
    }
    expected = Ok "2013-06-25"
    result == expected

# when fourth Wednesday is some day in the middle of the fourth week
expect
    result = meetup {
        year: 2013,
        month: 7,
        week: Fourth,
        dayOfWeek: Wednesday,
    }
    expected = Ok "2013-07-24"
    result == expected

# when fourth Wednesday is the 28th, the last day of the fourth week
expect
    result = meetup {
        year: 2013,
        month: 8,
        week: Fourth,
        dayOfWeek: Wednesday,
    }
    expected = Ok "2013-08-28"
    result == expected

# when fourth Thursday is some day in the middle of the fourth week
expect
    result = meetup {
        year: 2013,
        month: 9,
        week: Fourth,
        dayOfWeek: Thursday,
    }
    expected = Ok "2013-09-26"
    result == expected

# when fourth Thursday is another day in the middle of the fourth week
expect
    result = meetup {
        year: 2013,
        month: 10,
        week: Fourth,
        dayOfWeek: Thursday,
    }
    expected = Ok "2013-10-24"
    result == expected

# when fourth Friday is the 22nd, the first day of the fourth week
expect
    result = meetup {
        year: 2013,
        month: 11,
        week: Fourth,
        dayOfWeek: Friday,
    }
    expected = Ok "2013-11-22"
    result == expected

# when fourth Friday is some day in the middle of the fourth week
expect
    result = meetup {
        year: 2013,
        month: 12,
        week: Fourth,
        dayOfWeek: Friday,
    }
    expected = Ok "2013-12-27"
    result == expected

# when fourth Saturday is some day in the middle of the fourth week
expect
    result = meetup {
        year: 2013,
        month: 1,
        week: Fourth,
        dayOfWeek: Saturday,
    }
    expected = Ok "2013-01-26"
    result == expected

# when fourth Saturday is another day in the middle of the fourth week
expect
    result = meetup {
        year: 2013,
        month: 2,
        week: Fourth,
        dayOfWeek: Saturday,
    }
    expected = Ok "2013-02-23"
    result == expected

# when fourth Sunday is some day in the middle of the fourth week
expect
    result = meetup {
        year: 2013,
        month: 3,
        week: Fourth,
        dayOfWeek: Sunday,
    }
    expected = Ok "2013-03-24"
    result == expected

# when fourth Sunday is the 28th, the last day of the fourth week
expect
    result = meetup {
        year: 2013,
        month: 4,
        week: Fourth,
        dayOfWeek: Sunday,
    }
    expected = Ok "2013-04-28"
    result == expected

# last Monday in a month with four Mondays
expect
    result = meetup {
        year: 2013,
        month: 3,
        week: Last,
        dayOfWeek: Monday,
    }
    expected = Ok "2013-03-25"
    result == expected

# last Monday in a month with five Mondays
expect
    result = meetup {
        year: 2013,
        month: 4,
        week: Last,
        dayOfWeek: Monday,
    }
    expected = Ok "2013-04-29"
    result == expected

# last Tuesday in a month with four Tuesdays
expect
    result = meetup {
        year: 2013,
        month: 5,
        week: Last,
        dayOfWeek: Tuesday,
    }
    expected = Ok "2013-05-28"
    result == expected

# last Tuesday in another month with four Tuesdays
expect
    result = meetup {
        year: 2013,
        month: 6,
        week: Last,
        dayOfWeek: Tuesday,
    }
    expected = Ok "2013-06-25"
    result == expected

# last Wednesday in a month with five Wednesdays
expect
    result = meetup {
        year: 2013,
        month: 7,
        week: Last,
        dayOfWeek: Wednesday,
    }
    expected = Ok "2013-07-31"
    result == expected

# last Wednesday in a month with four Wednesdays
expect
    result = meetup {
        year: 2013,
        month: 8,
        week: Last,
        dayOfWeek: Wednesday,
    }
    expected = Ok "2013-08-28"
    result == expected

# last Thursday in a month with four Thursdays
expect
    result = meetup {
        year: 2013,
        month: 9,
        week: Last,
        dayOfWeek: Thursday,
    }
    expected = Ok "2013-09-26"
    result == expected

# last Thursday in a month with five Thursdays
expect
    result = meetup {
        year: 2013,
        month: 10,
        week: Last,
        dayOfWeek: Thursday,
    }
    expected = Ok "2013-10-31"
    result == expected

# last Friday in a month with five Fridays
expect
    result = meetup {
        year: 2013,
        month: 11,
        week: Last,
        dayOfWeek: Friday,
    }
    expected = Ok "2013-11-29"
    result == expected

# last Friday in a month with four Fridays
expect
    result = meetup {
        year: 2013,
        month: 12,
        week: Last,
        dayOfWeek: Friday,
    }
    expected = Ok "2013-12-27"
    result == expected

# last Saturday in a month with four Saturdays
expect
    result = meetup {
        year: 2013,
        month: 1,
        week: Last,
        dayOfWeek: Saturday,
    }
    expected = Ok "2013-01-26"
    result == expected

# last Saturday in another month with four Saturdays
expect
    result = meetup {
        year: 2013,
        month: 2,
        week: Last,
        dayOfWeek: Saturday,
    }
    expected = Ok "2013-02-23"
    result == expected

# last Sunday in a month with five Sundays
expect
    result = meetup {
        year: 2013,
        month: 3,
        week: Last,
        dayOfWeek: Sunday,
    }
    expected = Ok "2013-03-31"
    result == expected

# last Sunday in a month with four Sundays
expect
    result = meetup {
        year: 2013,
        month: 4,
        week: Last,
        dayOfWeek: Sunday,
    }
    expected = Ok "2013-04-28"
    result == expected

# when last Wednesday in February in a leap year is the 29th
expect
    result = meetup {
        year: 2012,
        month: 2,
        week: Last,
        dayOfWeek: Wednesday,
    }
    expected = Ok "2012-02-29"
    result == expected

# last Wednesday in December that is also the last day of the year
expect
    result = meetup {
        year: 2014,
        month: 12,
        week: Last,
        dayOfWeek: Wednesday,
    }
    expected = Ok "2014-12-31"
    result == expected

# when last Sunday in February in a non-leap year is not the 29th
expect
    result = meetup {
        year: 2015,
        month: 2,
        week: Last,
        dayOfWeek: Sunday,
    }
    expected = Ok "2015-02-22"
    result == expected

# when first Friday is the 7th, the last day of the first week
expect
    result = meetup {
        year: 2012,
        month: 12,
        week: First,
        dayOfWeek: Friday,
    }
    expected = Ok "2012-12-07"
    result == expected

