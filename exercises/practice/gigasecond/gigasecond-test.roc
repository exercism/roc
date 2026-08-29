# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/gigasecond/canonical-data.json
# File last updated on 2026-08-29
app [] {
	isodate: "https://github.com/ageron/roc-isodate/releases/download/v0.8.3/9SypUHT4Tn18tJyHyvtt929ByTx15djH3UaKkagRxGwA.tar.zst",
}

import Gigasecond exposing [add]

# date only specification of time
expect {
	result = add("2011-04-25")
	result == "2043-01-01T01:46:40"
}

# second test for date only specification of time
expect {
	result = add("1977-06-13")
	result == "2009-02-19T01:46:40"
}

# third test for date only specification of time
expect {
	result = add("1959-07-19")
	result == "1991-03-27T01:46:40"
}

# full time specified
expect {
	result = add("2015-01-24T22:00:00")
	result == "2046-10-02T23:46:40"
}

# full time with day roll-over
expect {
	result = add("2015-01-24T23:59:59")
	result == "2046-10-03T01:46:39"
}
