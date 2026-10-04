# Optional demo; not part of the exercise tests. Run after implementing BankAccount:
#   roc bank-account-demo.roc
# See .docs/instructions.append.md for curl examples and the concurrency model.
app [Context, program] {
	http: "https://github.com/roc-lang/http/releases/download/1.0.0/6ZUwqYhCS8PU9Mo6MF7oV82ET2o7KYb57CLKDq4cq4sS.tar.zst",
	pf: platform "https://github.com/roc-lang/basic-webserver/releases/download/0.16.0/42jC1JT3auhHSmv2Ah8mW5F2MXiAakq1UQQ4NQceQjXw.tar.zst",
}

import BankAccount
import pf.Server
import pf.Sqlite
import pf.Path
import pf.Env
import pf.Stderr
import http.Response

Context : { db : Sqlite.Db }

Command : [Open, Close, Balance, Deposit(U64), Withdraw(U64)]

StoredAccount : { balance : I64, is_open : I64 }

program = { init!, respond!, shutdown! }

init! = || {
	path = match Env.var!("DB_PATH") {
		Ok(value) => Path.from_os_str(value)
		Err(_) => Path.utf8("bank-account-demo.db")
	}
	db = Sqlite.open!(Sqlite.default_config(path)) ? |error| {
		_ = Stderr.line!(Str.inspect(error))
		Exit(1.I64)
	}
	Sqlite.execute!({
		db,
		query: "CREATE TABLE IF NOT EXISTS accounts (id TEXT PRIMARY KEY, balance INTEGER NOT NULL CHECK(balance >= 0), is_open INTEGER NOT NULL CHECK(is_open IN (0, 1)))",
		params: {},
	}) ? |error| {
		_ = Stderr.line!(Str.inspect(error))
		Exit(1.I64)
	}
	_ = Stderr.line!("Bank account demo: http://127.0.0.1:8000 (Ctrl-C to stop)")
	Ok({ config: Server.default_config, context: { db } })
}

respond! = |request, { db }| {
	response = match route(request) {
		Err(_) => text_response(400, "Use GET /accounts/<id>/balance or POST /accounts/<id>/{open,close,deposit/<amount>,withdraw/<amount>}\n")
		Ok({ id, command }) => match transact!(db, id, command) {
			Ok(message) => text_response(200, "${message}\n")
			Err(AccountError(message)) => text_response(409, "${message}\n")
			Err(BalanceLimitExceeded) => text_response(409, "Balance exceeds the demo database limit of 9223372036854775807\n")
			Err(DatabaseError(message)) => {
				_ = Stderr.line!(message)
				text_response(503, "Database operation failed; check the server log.\n")
			}
		}
	}
	Ok(Server.respond(response))
}

shutdown! = |_reason, _context| Ok({})

route : Server.Request -> Try({ id : Str, command : Command }, [InvalidRequest])
route = |request| {
	path = match request.target() {
		Resource({ raw_path, .. }) => raw_path
		_ => return Err(InvalidRequest)
	}
	match (request.method(), path.split_on("/")) {
		(GET, ["", "accounts", id, "balance"]) => Ok({ id: account_id(id)?, command: Balance })
		(POST, ["", "accounts", id, "open"]) => Ok({ id: account_id(id)?, command: Open })
		(POST, ["", "accounts", id, "close"]) => Ok({ id: account_id(id)?, command: Close })
		(POST, ["", "accounts", id, "deposit", amount]) => Ok({ id: account_id(id)?, command: Deposit(U64.from_str(amount) ? |_| InvalidRequest) })
		(POST, ["", "accounts", id, "withdraw", amount]) => Ok({ id: account_id(id)?, command: Withdraw(U64.from_str(amount) ? |_| InvalidRequest) })
		_ => Err(InvalidRequest)
	}
}

account_id = |text| {
	id = U64.from_str(text) ? |_| InvalidRequest
	Ok(id.to_str())
}

text_response = |status, text| Response.from_status(status)
	.with_headers([{ name: "Content-Type", value: "text/plain; charset=utf-8" }])
	.with_body(text.to_utf8())

transact! : Sqlite.Db, Str, Command => Try(Str, [AccountError(Str), DatabaseError(Str), BalanceLimitExceeded])
transact! = |db, id, command| {
	# Acquire the write transaction BEFORE reading. Otherwise two requests could
	# read the same balance and overwrite each other's updates. SQLite permits
	# one writer per database, including when the requests target different IDs.
	transaction = Sqlite.begin!(db, Immediate) ? |error| DatabaseError(Str.inspect(error))
	rows : List(StoredAccount)
	rows = transaction.query_many!({
		query: "SELECT balance, is_open FROM accounts WHERE id = :id",
		params: { id },
		limits: Sqlite.default_query_limits,
	}) ? |error| DatabaseError(Str.inspect(error))
	account = restore_account(rows.first() ?? { balance: 0, is_open: 0 }) ? |error| DatabaseError(error)

	# These are the student's functions: the database does not implement the
	# account rules. Returning an error abandons and rolls back the transaction.
	result = apply(account, command) ? |error| AccountError(error)
	if command != Balance {
		# Reject balances outside SQLite's signed range before writing anything.
		stored : StoredAccount
		stored = match result.account.balance() {
			Ok(amount) => {
				balance = amount.to_i64_try() ? |_| BalanceLimitExceeded
				{ balance, is_open: 1 }
			}
			Err(_) => { balance: 0, is_open: 0 }
		}
		transaction.execute!({
			query: "INSERT INTO accounts (id, balance, is_open) VALUES (:id, :balance, :is_open) ON CONFLICT(id) DO UPDATE SET balance = excluded.balance, is_open = excluded.is_open",
			params: { id, balance: stored.balance, is_open: stored.is_open },
		}) ? |error| DatabaseError(Str.inspect(error))
	}
	transaction.commit!() ? |error| DatabaseError(Str.inspect(error))
	Ok(result.message)
}

# Persist through the public API, without depending on BankAccount's private
# representation. The database uses signed integers; the exercise uses U64.
restore_account : StoredAccount -> Try(BankAccount, Str)
restore_account = |stored| {
	if stored.is_open == 0 {
		return Ok(BankAccount.create())
	}
	balance = stored.balance.to_u64_try() ? |_| "Invalid stored balance"
	account = BankAccount.create().open() ? Str.inspect
	if balance == 0 {
		Ok(account)
	} else {
		account.deposit(balance).map_err(Str.inspect)
	}
}

apply : BankAccount, Command -> Try({ account : BankAccount, message : Str }, Str)
apply = |account, command| {
	updated = match command {
		Open => account.open() ? Str.inspect
		Close => account.close() ? Str.inspect
		Deposit(amount) => account.deposit(amount) ? Str.inspect
		Withdraw(amount) => account.withdraw(amount) ? Str.inspect
		Balance => return Ok({ account, message: account.balance().map_err(Str.inspect)?.to_str() })
	}
	Ok({ account: updated, message: "OK" })
}
