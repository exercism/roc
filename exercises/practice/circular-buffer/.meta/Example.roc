module [create, read, write, overwrite, clear]

CircularBuffer : { data : List I64, start : U64, length : U64 }

create : { capacity : U64 } -> CircularBuffer
create = \{ capacity } ->
    { data: List.repeat 0 capacity, start: 0, length: 0 }

read : CircularBuffer -> Result { newBuffer : CircularBuffer, value : I64 } [BufferEmpty]
read = \{ data, start, length } ->
    if length == 0 then
        Err BufferEmpty
    else
        incrementStart = (start + 1) % List.len data
        newBuffer = { data, start: incrementStart, length: length - 1 }
        when data |> List.get start is
            Ok value -> Ok { newBuffer, value }
            Err OutOfBounds -> crash "Unreachable: start should never be out of bounds"

write : CircularBuffer, I64 -> Result CircularBuffer [BufferFull]
write = \{ data, start, length }, value ->
    if length == List.len data then
        Err BufferFull
    else
        index = (start + length) % List.len data
        newData = data |> List.replace index value |> .list
        Ok { data: newData, start, length: length + 1 }

overwrite : CircularBuffer, I64 -> CircularBuffer
overwrite = \{ data, start, length }, value ->
    index = (start + length) % List.len data
    newData = data |> List.replace index value |> .list
    if length == List.len data then
        incStart = (start + 1) % List.len data
        { data: newData, start: incStart, length: length }
    else
        { data: newData, start, length: length + 1 }

clear : CircularBuffer -> CircularBuffer
clear = \circularBuffer ->
    { data: circularBuffer.data, start: 0, length: 0 }
