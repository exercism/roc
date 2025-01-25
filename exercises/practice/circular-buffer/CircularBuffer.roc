module [create, read, write, overwrite, clear]

CircularBuffer : { data : List I64, start : U64, length : U64 }

create : { capacity : U64 } -> CircularBuffer
create = |{ capacity }|
    crash("Please implement the 'create' function")

read : CircularBuffer -> Result { new_buffer : CircularBuffer, value : I64 } [BufferEmpty]
read = |{ data, start, length }|
    crash("Please implement the 'read' function")

write : CircularBuffer, I64 -> Result CircularBuffer [BufferFull]
write = |circular_buffer, value|
    crash("Please implement the 'write' function")

overwrite : CircularBuffer, I64 -> CircularBuffer
overwrite = |{ data, start, length }, value|
    crash("Please implement the 'overwrite' function")

clear : CircularBuffer -> CircularBuffer
clear = |circular_buffer|
    crash("Please implement the 'clear' function")
