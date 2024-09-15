# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/circular-buffer/canonical-data.json
# File last updated on 2024-09-15
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import CircularBuffer exposing [create, read, write, overwrite, clear]

# reading empty buffer should fail
runOperations1 =
    result =
        create { capacity: 1 }
        |> \bufferBeforeRead ->
            readResult = bufferBeforeRead |> read
            expect readResult == Err BufferEmpty
            bufferBeforeRead
    Ok result

expect
    result = runOperations1
    result |> Result.isOk

# can read an item just written
runOperations2 =
    result =
        create { capacity: 1 }
            |> write? 1
            |> read?
            |> \readResult ->
                expect readResult.value == 1
                readResult.newBuffer
    Ok result

expect
    result = runOperations2
    result |> Result.isOk

# each item may only be read once
runOperations3 =
    result =
        create { capacity: 1 }
            |> write? 1
            |> read?
            |> \readResult ->
                expect readResult.value == 1
                readResult.newBuffer
            |> \bufferBeforeRead ->
                readResult = bufferBeforeRead |> read
                expect readResult == Err BufferEmpty
                bufferBeforeRead
    Ok result

expect
    result = runOperations3
    result |> Result.isOk

# items are read in the order they are written
runOperations4 =
    result =
        create { capacity: 2 }
            |> write? 1
            |> write? 2
            |> read?
            |> \readResult ->
                expect readResult.value == 1
                readResult.newBuffer
            |> read?
            |> \readResult ->
                expect readResult.value == 2
                readResult.newBuffer
    Ok result

expect
    result = runOperations4
    result |> Result.isOk

# full buffer can't be written to
runOperations5 =
    result =
        create { capacity: 1 }
            |> write? 1
            |> \bufferBeforeWrite ->
                writeResult = bufferBeforeWrite |> write 2
                expect writeResult == Err BufferFull
                bufferBeforeWrite
    Ok result

expect
    result = runOperations5
    result |> Result.isOk

# a read frees up capacity for another write
runOperations6 =
    result =
        create { capacity: 1 }
            |> write? 1
            |> read?
            |> \readResult ->
                expect readResult.value == 1
                readResult.newBuffer
            |> write? 2
            |> read?
            |> \readResult ->
                expect readResult.value == 2
                readResult.newBuffer
    Ok result

expect
    result = runOperations6
    result |> Result.isOk

# read position is maintained even across multiple writes
runOperations7 =
    result =
        create { capacity: 3 }
            |> write? 1
            |> write? 2
            |> read?
            |> \readResult ->
                expect readResult.value == 1
                readResult.newBuffer
            |> write? 3
            |> read?
            |> \readResult ->
                expect readResult.value == 2
                readResult.newBuffer
            |> read?
            |> \readResult ->
                expect readResult.value == 3
                readResult.newBuffer
    Ok result

expect
    result = runOperations7
    result |> Result.isOk

# items cleared out of buffer can't be read
runOperations8 =
    result =
        create { capacity: 1 }
            |> write? 1
            |> clear
            |> \bufferBeforeRead ->
                readResult = bufferBeforeRead |> read
                expect readResult == Err BufferEmpty
                bufferBeforeRead
    Ok result

expect
    result = runOperations8
    result |> Result.isOk

# clear frees up capacity for another write
runOperations9 =
    result =
        create { capacity: 1 }
            |> write? 1
            |> clear
            |> write? 2
            |> read?
            |> \readResult ->
                expect readResult.value == 2
                readResult.newBuffer
    Ok result

expect
    result = runOperations9
    result |> Result.isOk

# clear does nothing on empty buffer
runOperations10 =
    result =
        create { capacity: 1 }
            |> clear
            |> write? 1
            |> read?
            |> \readResult ->
                expect readResult.value == 1
                readResult.newBuffer
    Ok result

expect
    result = runOperations10
    result |> Result.isOk

# overwrite acts like write on non-full buffer
runOperations11 =
    result =
        create { capacity: 2 }
            |> write? 1
            |> overwrite 2
            |> read?
            |> \readResult ->
                expect readResult.value == 1
                readResult.newBuffer
            |> read?
            |> \readResult ->
                expect readResult.value == 2
                readResult.newBuffer
    Ok result

expect
    result = runOperations11
    result |> Result.isOk

# overwrite replaces the oldest item on full buffer
runOperations12 =
    result =
        create { capacity: 2 }
            |> write? 1
            |> write? 2
            |> overwrite 3
            |> read?
            |> \readResult ->
                expect readResult.value == 2
                readResult.newBuffer
            |> read?
            |> \readResult ->
                expect readResult.value == 3
                readResult.newBuffer
    Ok result

expect
    result = runOperations12
    result |> Result.isOk

# overwrite replaces the oldest item remaining in buffer following a read
runOperations13 =
    result =
        create { capacity: 3 }
            |> write? 1
            |> write? 2
            |> write? 3
            |> read?
            |> \readResult ->
                expect readResult.value == 1
                readResult.newBuffer
            |> write? 4
            |> overwrite 5
            |> read?
            |> \readResult ->
                expect readResult.value == 3
                readResult.newBuffer
            |> read?
            |> \readResult ->
                expect readResult.value == 4
                readResult.newBuffer
            |> read?
            |> \readResult ->
                expect readResult.value == 5
                readResult.newBuffer
    Ok result

expect
    result = runOperations13
    result |> Result.isOk

# initial clear does not affect wrapping around
runOperations14 =
    result =
        create { capacity: 2 }
            |> clear
            |> write? 1
            |> write? 2
            |> overwrite 3
            |> overwrite 4
            |> read?
            |> \readResult ->
                expect readResult.value == 3
                readResult.newBuffer
            |> read?
            |> \readResult ->
                expect readResult.value == 4
                readResult.newBuffer
            |> \bufferBeforeRead ->
                readResult = bufferBeforeRead |> read
                expect readResult == Err BufferEmpty
                bufferBeforeRead
    Ok result

expect
    result = runOperations14
    result |> Result.isOk

