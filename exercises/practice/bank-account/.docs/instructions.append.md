# Instructions Append

In this Roc exercise, account operations are pure: each update returns a new account value. Accounts start closed, reopening resets the balance, and deposits and withdrawals must be positive. Invalid operations return errors. This exercise focuses on the account logic and does not test concurrency.

In Roc, we generally leave concurrency to the platform, so there are no concurrency tests here. In a concurrent application, these pure operations would run within a mechanism that applies each account update atomically. For example, the platform might process account commands sequentially, or it might rely on database transactions.

You may also want to check out the `parallel-letter-frequency` exercise, where the platform gives the Roc code access to parallel computing primitives. The actual parallelism is still managed by the platform, but the Roc code is given more control over it.
