BankAccount :: [Closed, Open(U64)].{
	create : () -> BankAccount
	create = || {
		crash "Please implement the 'create' function"
	}

	open : BankAccount -> Try(BankAccount, _)
	open = |account| {
		crash "Please implement the 'open' function"
	}

	close : BankAccount -> Try(BankAccount, _)
	close = |account| {
		crash "Please implement the 'close' function"
	}

	balance : BankAccount -> Try(U64, _)
	balance = |account| {
		crash "Please implement the 'balance' function"
	}

	deposit : BankAccount, U64 -> Try(BankAccount, _)
	deposit = |account, amount| {
		crash "Please implement the 'deposit' function"
	}

	withdraw : BankAccount, U64 -> Try(BankAccount, _)
	withdraw = |account, amount| {
		crash "Please implement the 'withdraw' function"
	}
}
