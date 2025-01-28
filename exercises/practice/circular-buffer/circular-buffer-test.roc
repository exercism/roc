# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/circular-buffer/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import CircularBuffer exposing [create, read, write, overwrite, clear]

# reading empty buffer should fail
run_operations1 = |_|
    result =
        create({ capacity: 1 })
        |> |buffer_before_read|
            read_result = buffer_before_read |> read
            expect read_result == Err(BufferEmpty)
            buffer_before_read
    Ok(result)

expect
    result = run_operations1({})
    result |> Result.is_ok

# can read an item just written
run_operations2 = |_|
    result =
        create({ capacity: 1 })
        |> write(1)?
        |> read?
        |> |read_result|
            expect read_result.value == 1
            read_result.new_buffer
    Ok(result)

expect
    result = run_operations2({})
    result |> Result.is_ok

# each item may only be read once
run_operations3 = |_|
    result =
        create({ capacity: 1 })
        |> write(1)?
        |> read?
        |> |read_result|
            expect read_result.value == 1
            read_result.new_buffer
        |> |buffer_before_read|
            read_result = buffer_before_read |> read
            expect read_result == Err(BufferEmpty)
            buffer_before_read
    Ok(result)

expect
    result = run_operations3({})
    result |> Result.is_ok

# items are read in the order they are written
run_operations4 = |_|
    result =
        create({ capacity: 2 })
        |> write(1)?
        |> write(2)?
        |> read?
        |> |read_result|
            expect read_result.value == 1
            read_result.new_buffer
        |> read?
        |> |read_result|
            expect read_result.value == 2
            read_result.new_buffer
    Ok(result)

expect
    result = run_operations4({})
    result |> Result.is_ok

# full buffer can't be written to
run_operations5 = |_|
    result =
        create({ capacity: 1 })
        |> write(1)?
        |> |buffer_before_write|
            write_result = buffer_before_write |> write(2)
            expect write_result == Err(BufferFull)
            buffer_before_write
    Ok(result)

expect
    result = run_operations5({})
    result |> Result.is_ok

# a read frees up capacity for another write
run_operations6 = |_|
    result =
        create({ capacity: 1 })
        |> write(1)?
        |> read?
        |> |read_result|
            expect read_result.value == 1
            read_result.new_buffer
        |> write(2)?
        |> read?
        |> |read_result|
            expect read_result.value == 2
            read_result.new_buffer
    Ok(result)

expect
    result = run_operations6({})
    result |> Result.is_ok

# read position is maintained even across multiple writes
run_operations7 = |_|
    result =
        create({ capacity: 3 })
        |> write(1)?
        |> write(2)?
        |> read?
        |> |read_result|
            expect read_result.value == 1
            read_result.new_buffer
        |> write(3)?
        |> read?
        |> |read_result|
            expect read_result.value == 2
            read_result.new_buffer
        |> read?
        |> |read_result|
            expect read_result.value == 3
            read_result.new_buffer
    Ok(result)

expect
    result = run_operations7({})
    result |> Result.is_ok

# items cleared out of buffer can't be read
run_operations8 = |_|
    result =
        create({ capacity: 1 })
        |> write(1)?
        |> clear
        |> |buffer_before_read|
            read_result = buffer_before_read |> read
            expect read_result == Err(BufferEmpty)
            buffer_before_read
    Ok(result)

expect
    result = run_operations8({})
    result |> Result.is_ok

# clear frees up capacity for another write
run_operations9 = |_|
    result =
        create({ capacity: 1 })
        |> write(1)?
        |> clear
        |> write(2)?
        |> read?
        |> |read_result|
            expect read_result.value == 2
            read_result.new_buffer
    Ok(result)

expect
    result = run_operations9({})
    result |> Result.is_ok

# clear does nothing on empty buffer
run_operations10 = |_|
    result =
        create({ capacity: 1 })
        |> clear
        |> write(1)?
        |> read?
        |> |read_result|
            expect read_result.value == 1
            read_result.new_buffer
    Ok(result)

expect
    result = run_operations10({})
    result |> Result.is_ok

# overwrite acts like write on non-full buffer
run_operations11 = |_|
    result =
        create({ capacity: 2 })
        |> write(1)?
        |> overwrite(2)
        |> read?
        |> |read_result|
            expect read_result.value == 1
            read_result.new_buffer
        |> read?
        |> |read_result|
            expect read_result.value == 2
            read_result.new_buffer
    Ok(result)

expect
    result = run_operations11({})
    result |> Result.is_ok

# overwrite replaces the oldest item on full buffer
run_operations12 = |_|
    result =
        create({ capacity: 2 })
        |> write(1)?
        |> write(2)?
        |> overwrite(3)
        |> read?
        |> |read_result|
            expect read_result.value == 2
            read_result.new_buffer
        |> read?
        |> |read_result|
            expect read_result.value == 3
            read_result.new_buffer
    Ok(result)

expect
    result = run_operations12({})
    result |> Result.is_ok

# overwrite replaces the oldest item remaining in buffer following a read
run_operations13 = |_|
    result =
        create({ capacity: 3 })
        |> write(1)?
        |> write(2)?
        |> write(3)?
        |> read?
        |> |read_result|
            expect read_result.value == 1
            read_result.new_buffer
        |> write(4)?
        |> overwrite(5)
        |> read?
        |> |read_result|
            expect read_result.value == 3
            read_result.new_buffer
        |> read?
        |> |read_result|
            expect read_result.value == 4
            read_result.new_buffer
        |> read?
        |> |read_result|
            expect read_result.value == 5
            read_result.new_buffer
    Ok(result)

expect
    result = run_operations13({})
    result |> Result.is_ok

# initial clear does not affect wrapping around
run_operations14 = |_|
    result =
        create({ capacity: 2 })
        |> clear
        |> write(1)?
        |> write(2)?
        |> overwrite(3)
        |> overwrite(4)
        |> read?
        |> |read_result|
            expect read_result.value == 3
            read_result.new_buffer
        |> read?
        |> |read_result|
            expect read_result.value == 4
            read_result.new_buffer
        |> |buffer_before_read|
            read_result = buffer_before_read |> read
            expect read_result == Err(BufferEmpty)
            buffer_before_read
    Ok(result)

expect
    result = run_operations14({})
    result |> Result.is_ok

