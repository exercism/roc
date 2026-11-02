# Hints

## General

- Use `match` to distinguish `Closed` from `Open(balance)`.

- An operation returns an updated account rather than modifying the account passed to it.
  Use `Ok(updated_account)` for a successful update and `Err(...)` for a rejected operation.
