# Hints

## General

- Try storing the backend and counters together in the opaque type.

- To call a function stored in a record field, use parentheses: `(backend.read!)(backend.state, max_bytes)`.

- Watch out for `?`: returning early on an error would lose the updated wrapper and its operation count.
