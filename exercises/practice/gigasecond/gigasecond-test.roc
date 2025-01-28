# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/gigasecond/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
    isodate: "https://github.com/imclerran/roc-isodate/releases/download/v0.6.0/79DATSmwkFXMsS0dF7w1RTHeQCGwFNzh9zylic4Fw9w.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Gigasecond exposing [add]

# date only specification of time
expect
    result = add("2011-04-25")
    result == "2043-01-01T01:46:40"

# second test for date only specification of time
expect
    result = add("1977-06-13")
    result == "2009-02-19T01:46:40"

# third test for date only specification of time
expect
    result = add("1959-07-19")
    result == "1991-03-27T01:46:40"

# full time specified
expect
    result = add("2015-01-24T22:00:00")
    result == "2046-10-02T23:46:40"

# full time with day roll-over
expect
    result = add("2015-01-24T23:59:59")
    result == "2046-10-03T01:46:39"

