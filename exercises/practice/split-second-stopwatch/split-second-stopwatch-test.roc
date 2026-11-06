# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/split-second-stopwatch/canonical-data.json
# File last updated on 2026-09-26

import Stopwatch

## new stopwatch starts in ready state
expect {
	result = Stopwatch.create()
		|> expect_state(Ready)

	result.is_ok()
}

## new stopwatch's current lap has no elapsed time
expect {
	result = Stopwatch.create()
		|> expect_current_lap("00:00:00")

	result.is_ok()
}

## new stopwatch's total has no elapsed time
expect {
	result = Stopwatch.create()
		|> expect_total("00:00:00")

	result.is_ok()
}

## new stopwatch does not have previous laps
expect {
	result = Stopwatch.create()
		|> expect_previous_laps([])

	result.is_ok()
}

## start from ready state changes state to running
expect {
	result = Stopwatch.create()
		.start()?
		|> expect_state(Running)

	result.is_ok()
}

## start does not change previous laps
expect {
	result = Stopwatch.create()
		.start()?
		|> expect_previous_laps([])

	result.is_ok()
}

## start initiates time tracking for current lap
expect {
	result = Stopwatch.create()
		.start()?
		.advance_time("00:00:05")
		|> expect_current_lap("00:00:05")

	result.is_ok()
}

## start initiates time tracking for total
expect {
	result = Stopwatch.create()
		.start()?
		.advance_time("00:00:23")
		|> expect_total("00:00:23")

	result.is_ok()
}

## start cannot be called from running state
expect {
	result = Stopwatch.create()
		.start()?
		.start()

	result.is_err()
}

## stop from running state changes state to stopped
expect {
	result = Stopwatch.create()
		.start()?
		.stop()?
		|> expect_state(Stopped)

	result.is_ok()
}

## stop pauses time tracking for current lap
expect {
	result = Stopwatch.create()
		.start()?
		.advance_time("00:00:05")
		.stop()?
		.advance_time("00:00:08")
		|> expect_current_lap("00:00:05")

	result.is_ok()
}

## stop pauses time tracking for total
expect {
	result = Stopwatch.create()
		.start()?
		.advance_time("00:00:13")
		.stop()?
		.advance_time("00:00:44")
		|> expect_total("00:00:13")

	result.is_ok()
}

## stop cannot be called from ready state
expect {
	result = Stopwatch.create()
		.stop()

	result.is_err()
}

## stop cannot be called from stopped state
expect {
	result = Stopwatch.create()
		.start()?
		.stop()?
		.stop()

	result.is_err()
}

## start from stopped state changes state to running
expect {
	result = Stopwatch.create()
		.start()?
		.stop()?
		.start()?
		|> expect_state(Running)

	result.is_ok()
}

## start from stopped state resumes time tracking for current lap
expect {
	result = Stopwatch.create()
		.start()?
		.advance_time("00:01:20")
		.stop()?
		.advance_time("00:00:20")
		.start()?
		.advance_time("00:00:08")
		|> expect_current_lap("00:01:28")

	result.is_ok()
}

## start from stopped state resumes time tracking for total
expect {
	result = Stopwatch.create()
		.start()?
		.advance_time("00:00:23")
		.stop()?
		.advance_time("00:00:44")
		.start()?
		.advance_time("00:00:09")
		|> expect_total("00:00:32")

	result.is_ok()
}

## lap adds current lap to previous laps
expect {
	result = Stopwatch.create()
		.start()?
		.advance_time("00:01:38")
		.lap()?
		|> expect_previous_laps(["00:01:38"])?
		.advance_time("00:00:44")
		.lap()?
		|> expect_previous_laps(["00:01:38", "00:00:44"])

	result.is_ok()
}

## lap resets current lap and resumes time tracking
expect {
	result = Stopwatch.create()
		.start()?
		.advance_time("00:08:22")
		.lap()?
		|> expect_current_lap("00:00:00")?
		.advance_time("00:00:15")
		|> expect_current_lap("00:00:15")

	result.is_ok()
}

## lap continues time tracking for total
expect {
	result = Stopwatch.create()
		.start()?
		.advance_time("00:00:22")
		.lap()?
		.advance_time("00:00:33")
		|> expect_total("00:00:55")

	result.is_ok()
}

## lap cannot be called from ready state
expect {
	result = Stopwatch.create()
		.lap()

	result.is_err()
}

## lap cannot be called from stopped state
expect {
	result = Stopwatch.create()
		.start()?
		.stop()?
		.lap()

	result.is_err()
}

## stop does not change previous laps
expect {
	result = Stopwatch.create()
		.start()?
		.advance_time("00:11:22")
		.lap()?
		|> expect_previous_laps(["00:11:22"])?
		.stop()?
		|> expect_previous_laps(["00:11:22"])

	result.is_ok()
}

## reset from stopped state changes state to ready
expect {
	result = Stopwatch.create()
		.start()?
		.stop()?
		.reset()?
		|> expect_state(Ready)

	result.is_ok()
}

## reset resets current lap
expect {
	result = Stopwatch.create()
		.start()?
		.advance_time("00:00:10")
		.stop()?
		.reset()?
		|> expect_current_lap("00:00:00")

	result.is_ok()
}

## reset clears previous laps
expect {
	result = Stopwatch.create()
		.start()?
		.advance_time("00:00:10")
		.lap()?
		.advance_time("00:00:20")
		.lap()?
		|> expect_previous_laps(["00:00:10", "00:00:20"])?
		.stop()?
		.reset()?
		|> expect_previous_laps([])

	result.is_ok()
}

## reset cannot be called from ready state
expect {
	result = Stopwatch.create()
		.reset()

	result.is_err()
}

## reset cannot be called from running state
expect {
	result = Stopwatch.create()
		.start()?
		.reset()

	result.is_err()
}

## supports very long laps
expect {
	result = Stopwatch.create()
		.start()?
		.advance_time("01:23:45")
		|> expect_current_lap("01:23:45")?
		.lap()?
		|> expect_previous_laps(["01:23:45"])?
		.advance_time("04:01:40")
		|> expect_current_lap("04:01:40")?
		|> expect_total("05:25:25")?
		.lap()?
		|> expect_previous_laps(["01:23:45", "04:01:40"])?
		.advance_time("08:43:05")
		|> expect_current_lap("08:43:05")?
		|> expect_total("14:08:30")?
		.lap()?
		|> expect_previous_laps(["01:23:45", "04:01:40", "08:43:05"])

	result.is_ok()
}

expect_state : Stopwatch, [Ready, Running, Stopped] -> Try(Stopwatch, _)
expect_state = |stopwatch, expected| {
	actual = stopwatch.state()
	if actual == expected {
		Ok(stopwatch)
	} else {
		Err(UnexpectedState({ expected, actual }))
	}
}

expect_current_lap : Stopwatch, Stopwatch.Time -> Try(Stopwatch, _)
expect_current_lap = |stopwatch, expected| {
	actual = stopwatch.current_lap()
	if actual == expected {
		Ok(stopwatch)
	} else {
		Err(UnexpectedCurrentLap({ expected, actual }))
	}
}

expect_previous_laps : Stopwatch, List(Stopwatch.Time) -> Try(Stopwatch, _)
expect_previous_laps = |stopwatch, expected| {
	actual = stopwatch.previous_laps()
	if actual == expected {
		Ok(stopwatch)
	} else {
		Err(UnexpectedPreviousLaps({ expected, actual }))
	}
}

expect_total : Stopwatch, Stopwatch.Time -> Try(Stopwatch, _)
expect_total = |stopwatch, expected| {
	actual = stopwatch.total()
	if actual == expected {
		Ok(stopwatch)
	} else {
		Err(UnexpectedTotal({ expected, actual }))
	}
}
