module [create, read, write, overwrite, clear]

CircularBuffer : { data : List I64, start : U64, length : U64 }

create : { capacity : U64 } -> CircularBuffer
create = \{ capacity } ->
    { data: List.repeat 0 capacity, start: 0, length: 0 }

read : CircularBuffer -> Result { new_buffer : CircularBuffer, value : I64 } [BufferEmpty]
read = \{ data, start, length } ->
    if length == 0 then
        Err BufferEmpty
    else
        increment_start = (start + 1) % List.len data
        new_buffer = { data, start: increment_start, length: length - 1 }
        when data |> List.get start is
            Ok value -> Ok { new_buffer, value }
            Err OutOfBounds -> crash "Unreachable: start should never be out of bounds"

write : CircularBuffer, I64 -> Result CircularBuffer [BufferFull]
write = \{ data, start, length }, value ->
    if length == List.len data then
        Err BufferFull
    else
        index = (start + length) % List.len data
        new_data = data |> List.replace index value |> .list
        Ok { data: new_data, start, length: length + 1 }

overwrite : CircularBuffer, I64 -> CircularBuffer
overwrite = \{ data, start, length }, value ->
    index = (start + length) % List.len data
    new_data = data |> List.replace index value |> .list
    if length == List.len data then
        inc_start = (start + 1) % List.len data
        { data: new_data, start: inc_start, length: length }
    else
        { data: new_data, start, length: length + 1 }

clear : CircularBuffer -> CircularBuffer
clear = \CircularBuffer ->
    { data: CircularBuffer.data, start: 0, length: 0 }