# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/gigasecond/canonical-data.json
# File last updated on 2024-08-25
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br",
    isodate: "https://github.com/imclerran/roc-isodate/releases/download/v0.4.1/OQwyjDUYQkmGRiaISkzBcw5dpnbi1OHi8KUDl7NZmC8.tar.br",
}

import pf.Task exposing [Task]

main =
    Task.ok {}

import Gigasecond exposing [add]

# date only specification of time
expect add "2011-04-25" == "2043-01-01T01:46:40"

# second test for date only specification of time
expect add "1977-06-13" == "2009-02-19T01:46:40"

# third test for date only specification of time
expect add "1959-07-19" == "1991-03-27T01:46:40"

# full time specified
expect add "2015-01-24T22:00:00" == "2046-10-02T23:46:40"

# full time with day roll-over
expect add "2015-01-24T23:59:59" == "2046-10-03T01:46:39"

