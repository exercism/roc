# Instructions Append

## Keeping count in Roc

Your wrapper handles the bookkeeping; the supplied backend does the actual reading and writing.
There are no files or connections to open yourself.

`Paasio(state, err)` works with any backend state and error types.
The backend holds its initial `state` and two callbacks:

- `read!(state, max_bytes)` returns `{ state, result }`, with `Ok(bytes)` or `Err(error)`.
- `write!(state, bytes)` returns `{ state, result }`, with `Ok(bytes_written)` or `Err(error)`.

Start each wrapper's four counters at zero.
`create`, `stats`, and `get_state` must not invoke the callbacks.
For each `read!` or `write!`, call the matching callback exactly once, passing its arguments unchanged.
Keep the returned state and result, even on failure, and return `{ io, result }`.
Carry that updated `io` into the next call.

## Every attempt counts

Keep read and write statistics separate:

- Count every call, including failures, EOF, zero-byte reads, and empty writes.
- Count bytes only on success: the returned list's length for reads, and the reported number for writes.
- A short transfer still counts as one call—don't retry it or a failed operation.

Count what the backend reports; you don't need to track operating-system calls or buffering.
You can trust the backend's byte counts and assume the counters fit in `U64`.

## Running the tests

The tests use both in-memory backends and a real file in a temporary directory, which is cleaned up afterward.

Unlike most other exercises, this exercise uses effectful functions (in this case based on the `basic-cli` platform).
If you want to run the tests locally, you must therefore use `roc --opt=speed paasio-test.roc`, rather than `roc test` (since the `expect` statement cannot currently test effectful functions).

Any error returned by the Roc code is reported by the platform, using a different format than usual.

## Hints

<details>
<summary>Show hints</summary>

Try storing the backend and counters together in the opaque type.
To call a function stored in a record field, use parentheses: `(backend.read!)(backend.state, max_bytes)`.
Watch out for `?`: returning early on an error would lose the updated wrapper and its operation count.

</details>
