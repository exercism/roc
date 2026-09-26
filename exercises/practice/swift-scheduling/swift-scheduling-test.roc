# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/swift-scheduling/canonical-data.json
# File last updated on 2026-09-26
app [] {
	isodate: "https://github.com/ageron/roc-isodate/releases/download/v0.8.3/9SypUHT4Tn18tJyHyvtt929ByTx15djH3UaKkagRxGwA.tar.zst",
}

import SwiftScheduling exposing [delivery_date]

## NOW translates to two hours later
expect {
	result = delivery_date({
		meeting_start: "2012-02-13T09:00:00",
		delivery: Now,
	})?
	result == "2012-02-13T11:00:00"
}

## ASAP before one in the afternoon translates to today at five in the afternoon
expect {
	result = delivery_date({
		meeting_start: "1999-06-03T09:45:00",
		delivery: Asap,
	})?
	result == "1999-06-03T17:00:00"
}

## ASAP at one in the afternoon translates to tomorrow at one in the afternoon
expect {
	result = delivery_date({
		meeting_start: "2008-12-21T13:00:00",
		delivery: Asap,
	})?
	result == "2008-12-22T13:00:00"
}

## ASAP after one in the afternoon translates to tomorrow at one in the afternoon
expect {
	result = delivery_date({
		meeting_start: "2008-12-21T14:50:00",
		delivery: Asap,
	})?
	result == "2008-12-22T13:00:00"
}

## EOW on Monday translates to Friday at five in the afternoon
expect {
	result = delivery_date({
		meeting_start: "2025-02-03T16:00:00",
		delivery: Eow,
	})?
	result == "2025-02-07T17:00:00"
}

## EOW on Tuesday translates to Friday at five in the afternoon
expect {
	result = delivery_date({
		meeting_start: "1997-04-29T10:50:00",
		delivery: Eow,
	})?
	result == "1997-05-02T17:00:00"
}

## EOW on Wednesday translates to Friday at five in the afternoon
expect {
	result = delivery_date({
		meeting_start: "2005-09-14T11:00:00",
		delivery: Eow,
	})?
	result == "2005-09-16T17:00:00"
}

## EOW on Thursday translates to Sunday at eight in the evening
expect {
	result = delivery_date({
		meeting_start: "2011-05-19T08:30:00",
		delivery: Eow,
	})?
	result == "2011-05-22T20:00:00"
}

## EOW on Friday translates to Sunday at eight in the evening
expect {
	result = delivery_date({
		meeting_start: "2022-08-05T14:00:00",
		delivery: Eow,
	})?
	result == "2022-08-07T20:00:00"
}

## EOW translates to leap day
expect {
	result = delivery_date({
		meeting_start: "2008-02-25T10:30:00",
		delivery: Eow,
	})?
	result == "2008-02-29T17:00:00"
}

## 2M before the second month of this year translates to the first workday of the second month of this year
expect {
	result = delivery_date({
		meeting_start: "2007-01-02T14:15:00",
		delivery: Month(2),
	})?
	result == "2007-02-01T08:00:00"
}

## 11M in the eleventh month translates to the first workday of the eleventh month of next year
expect {
	result = delivery_date({
		meeting_start: "2013-11-21T15:30:00",
		delivery: Month(11),
	})?
	result == "2014-11-03T08:00:00"
}

## 4M in the ninth month translates to the first workday of the fourth month of next year
expect {
	result = delivery_date({
		meeting_start: "2019-11-18T15:15:00",
		delivery: Month(4),
	})?
	result == "2020-04-01T08:00:00"
}

## Q1 in the first quarter translates to the last workday of the first quarter of this year
expect {
	result = delivery_date({
		meeting_start: "2003-01-01T10:45:00",
		delivery: Quarter(1),
	})?
	result == "2003-03-31T08:00:00"
}

## Q4 in the second quarter translates to the last workday of the fourth quarter of this year
expect {
	result = delivery_date({
		meeting_start: "2001-04-09T09:00:00",
		delivery: Quarter(4),
	})?
	result == "2001-12-31T08:00:00"
}

## Q3 in the fourth quarter translates to the last workday of the third quarter of next year
expect {
	result = delivery_date({
		meeting_start: "2022-10-06T11:00:00",
		delivery: Quarter(3),
	})?
	result == "2023-09-29T08:00:00"
}

## Q2 starting in the last month of the second quarter translates to the last workday of the second quarter of this year
expect {
	result = delivery_date({
		meeting_start: "2019-06-15T09:50:00",
		delivery: Quarter(2),
	})?
	result == "2019-06-28T08:00:00"
}
