# Instructions Append

## Roc/Host responsibilities

In Roc code, we typically focus on the business logic while the platform handles concurrency and shared state.
Therefore, in this exercise you only need to implement the account operations in `BankAccount.roc` without having to worry about concurrency.
Accounts start closed, reopening resets the balance, and deposits and withdrawals must be positive.

## Optional server demo

The included `bank-account-demo.roc` shows how your implementation can be used in a small web service.
You can read it in the editor, but it is independent of the tests and is not part of your solution.

To run the demo, you must [install Roc](https://www.roc-lang.org/install/) on your machine, install the [Exercism CLI](https://exercism.org/cli-walkthrough), then run this command in a terminal:

```sh
exercism download --exercise=bank-account --track=roc
```

Next, implement `BankAccount.roc` and test it with the following command (change the download location printed by the CLI if it differs from the path below):

```sh
cd ~/Exercism/roc/bank-account
roc test bank-account-test.roc
```

Once all the tests pass, you can start the demo server with the following command:

```sh
roc bank-account-demo.roc
```

The server uses the [basic-webserver platform](https://github.com/roc-lang/basic-webserver) and its built-in SQLite support (Roc downloads the platform on the first run).
No separate database server is needed.
The server listens on `http://127.0.0.1:8000` and creates `bank-account-demo.db` in your current directory (set `DB_PATH` to use a different database file).
Stop the server with Ctrl-C.
The data survives restarts.

In another terminal, you can call the webservice using `curl` (on Windows, use `curl.exe` throughout to avoid PowerShell's `curl` alias).
For example, here is how to open account #123, deposit 50, withdraw 10, and check its balance:

```sh
curl -X POST http://127.0.0.1:8000/accounts/123/open
curl -X POST http://127.0.0.1:8000/accounts/123/deposit/50
curl -X POST http://127.0.0.1:8000/accounts/123/withdraw/10
curl http://127.0.0.1:8000/accounts/123/balance
```

The balance is `40`.
Account IDs and amounts must be unsigned integers.
Updates return `OK` on success or an error from your account implementation on failure.
To close account #123:

```sh
curl -X POST http://127.0.0.1:8000/accounts/123/close
```

To try concurrent requests on Linux/macOS, use a fresh account ID and send 100 deposits from eight clients:

```sh
curl -X POST http://127.0.0.1:8000/accounts/456/open
seq 100 | xargs -P 8 -I '{}' curl --fail --silent --show-error -X POST http://127.0.0.1:8000/accounts/456/deposit/1
curl http://127.0.0.1:8000/accounts/456/balance
```

On Windows, use [PowerShell 7+](https://learn.microsoft.com/powershell/scripting/install/installing-powershell-on-windows) for the parallel example:

```powershell
curl.exe -X POST http://127.0.0.1:8000/accounts/456/open
1..100 | ForEach-Object -Parallel { curl.exe --fail --silent --show-error -X POST http://127.0.0.1:8000/accounts/456/deposit/1 } -ThrottleLimit 8
curl.exe http://127.0.0.1:8000/accounts/456/balance
```

The deposits should all succeed and the balance should be `100`.

## How the demo handles concurrency

Each request reads the account, calls your Roc functions, and saves the result within an SQLite `Immediate` transaction.
Failed operations roll back without changing the account.
SQLite allows one writer at a time, preventing concurrent requests from overwriting each other's updates (even across different accounts).

Note: The exercise uses `U64`, but the demo stores balances as SQLite integers and rejects updates exceeding the maximum `I64` value (`9223372036854775807`).

For an example of running independent computations in parallel, try the [parallel-letter-frequency exercise](https://exercism.org/tracks/roc/exercises/parallel-letter-frequency).

## Hints

<details>
<summary>Show hints</summary>

Use `match` to distinguish `Closed` from `Open(balance)`.
An operation returns an updated account rather than modifying the account passed to it.
Use `Ok(updated_account)` for a successful update and `Err(...)` for a rejected operation.

</details>
