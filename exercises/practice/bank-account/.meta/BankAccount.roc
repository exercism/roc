##
## Example solution
##

BankAccount :: [Closed, Open(U64)].{
	create : () -> BankAccount
	create = || Closed

	open : BankAccount -> Try(BankAccount, [AlreadyOpen, ..])
	open = |account| match account {
		Closed => Ok(Open(0))
		Open(_) => Err(AlreadyOpen)
	}

	close : BankAccount -> Try(BankAccount, [NotOpen, ..])
	close = |account| match account {
		Closed => Err(NotOpen)
		Open(_) => Ok(Closed)
	}

	balance : BankAccount -> Try(U64, [NotOpen, ..])
	balance = |account| match account {
		Closed => Err(NotOpen)
		Open(amount) => Ok(amount)
	}

	deposit : BankAccount, U64 -> Try(BankAccount, [NotOpen, InvalidAmount, BalanceOverflow, ..])
	deposit = |account, amount| {
		current = balance(account)?
		if amount == 0 {
			return Err(InvalidAmount)
		}
		updated = (current.to_u128() + amount.to_u128()).to_u64_try() ? |_| BalanceOverflow
		Ok(Open(updated))
	}

	withdraw : BankAccount, U64 -> Try(BankAccount, [NotOpen, InvalidAmount, InsufficientFunds, ..])
	withdraw = |account, amount| {
		current = balance(account)?
		if amount == 0 {
			return Err(InvalidAmount)
		}
		if amount > current {
			return Err(InsufficientFunds)
		}
		Ok(Open(current - amount))
	}
}
