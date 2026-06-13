# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/circular-buffer/canonical-data.json
# File last updated on 2026-06-13

import CircularBuffer

expect_value = |read_result, expected| {
	expect read_result.value == expected
	read_result.updated_buffer
}

# reading empty buffer should fail
expect {
	result = CircularBuffer.create({ capacity: 1 })
		.read()

	result == Err(BufferEmpty)
}

# can read an item just written
expect {
	_result = CircularBuffer.create({ capacity: 1 })
		.write(
			1,
		)?
		.read()?
		->expect_value(1)

	Bool.True
}

# each item may only be read once
expect {
	result = CircularBuffer.create({ capacity: 1 })
		.write(
			1,
		)?
		.read()?
		->expect_value(1)
		.read()

	result == Err(BufferEmpty)
}

# items are read in the order they are written
expect {
	_result = CircularBuffer.create({ capacity: 2 })
		.write(
			1,
		)?
		.write(
			2,
		)?
		.read()?
		->expect_value(1)
		.read()?
		->expect_value(2)

	Bool.True
}

# full buffer can't be written to
expect {
	result = CircularBuffer.create({ capacity: 1 })
		.write(
			1,
		)?
		.write(
			2,
		)

	result == Err(BufferFull)
}

# a read frees up capacity for another write
expect {
	_result = CircularBuffer.create({ capacity: 1 })
		.write(
			1,
		)?
		.read()?
		->expect_value(1)
		.write(
			2,
		)?
		.read()?
		->expect_value(2)

	Bool.True
}

# read position is maintained even across multiple writes
expect {
	_result = CircularBuffer.create({ capacity: 3 })
		.write(
			1,
		)?
		.write(
			2,
		)?
		.read()?
		->expect_value(1)
		.write(
			3,
		)?
		.read()?
		->expect_value(2)
		.read()?
		->expect_value(3)

	Bool.True
}

# items cleared out of buffer can't be read
expect {
	result = CircularBuffer.create({ capacity: 1 })
		.write(
			1,
		)?
		.clear()
		.read()

	result == Err(BufferEmpty)
}

# clear frees up capacity for another write
expect {
	_result = CircularBuffer.create({ capacity: 1 })
		.write(
			1,
		)?
		.clear()
		.write(
			2,
		)?
		.read()?
		->expect_value(2)

	Bool.True
}

# clear does nothing on empty buffer
expect {
	_result = CircularBuffer.create({ capacity: 1 })
		.clear()
		.write(
			1,
		)?
		.read()?
		->expect_value(1)

	Bool.True
}

# overwrite acts like write on non-full buffer
expect {
	_result = CircularBuffer.create({ capacity: 2 })
		.write(
			1,
		)?
		.overwrite(
			2,
		)
		.read()?
		->expect_value(1)
		.read()?
		->expect_value(2)

	Bool.True
}

# overwrite replaces the oldest item on full buffer
expect {
	_result = CircularBuffer.create({ capacity: 2 })
		.write(
			1,
		)?
		.write(
			2,
		)?
		.overwrite(
			3,
		)
		.read()?
		->expect_value(2)
		.read()?
		->expect_value(3)

	Bool.True
}

# overwrite replaces the oldest item remaining in buffer following a read
expect {
	_result = CircularBuffer.create({ capacity: 3 })
		.write(
			1,
		)?
		.write(
			2,
		)?
		.write(
			3,
		)?
		.read()?
		->expect_value(1)
		.write(
			4,
		)?
		.overwrite(
			5,
		)
		.read()?
		->expect_value(3)
		.read()?
		->expect_value(4)
		.read()?
		->expect_value(5)

	Bool.True
}

# initial clear does not affect wrapping around
expect {
	result = CircularBuffer.create({ capacity: 2 })
		.clear()
		.write(
			1,
		)?
		.write(
			2,
		)?
		.overwrite(
			3,
		)
		.overwrite(
			4,
		)
		.read()?
		->expect_value(3)
		.read()?
		->expect_value(4)
		.read()

	result == Err(BufferEmpty)
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
