# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/bank-account/canonical-data.json
# File last updated on 2026-09-28

import BankAccount

## Newly opened account has zero balance
expect {
	result = BankAccount.create()
		.open()?
		.balance()?
	result == 0
}

## Single deposit
expect {
	result = BankAccount.create()
		.open()?
		.deposit(100)?
		.balance()?
	result == 100
}

## Multiple deposits
expect {
	result = BankAccount.create()
		.open()?
		.deposit(100)?
		.deposit(50)?
		.balance()?
	result == 150
}

## Withdraw once
expect {
	result = BankAccount.create()
		.open()?
		.deposit(100)?
		.withdraw(75)?
		.balance()?
	result == 25
}

## Withdraw twice
expect {
	result = BankAccount.create()
		.open()?
		.deposit(100)?
		.withdraw(80)?
		.withdraw(20)?
		.balance()?
	result == 0
}

## Can do multiple operations sequentially
expect {
	result = BankAccount.create()
		.open()?
		.deposit(100)?
		.deposit(110)?
		.withdraw(200)?
		.deposit(60)?
		.withdraw(50)?
		.balance()?
	result == 20
}

## Cannot check balance of closed account
expect {
	result = BankAccount.create()
		.open()?
		.close()?
		.balance()
	result.is_err()
}

## Cannot deposit into closed account
expect {
	result = BankAccount.create()
		.open()?
		.close()?
		.deposit(50)
	result.is_err()
}

## Cannot deposit into unopened account
expect {
	result = BankAccount.create()
		.deposit(50)
	result.is_err()
}

## Cannot withdraw from closed account
expect {
	result = BankAccount.create()
		.open()?
		.close()?
		.withdraw(50)
	result.is_err()
}

## Cannot close an account that was not opened
expect {
	result = BankAccount.create()
		.close()
	result.is_err()
}

## Cannot open an already opened account
expect {
	result = BankAccount.create()
		.open()?
		.open()
	result.is_err()
}

## Reopened account does not retain balance
expect {
	result = BankAccount.create()
		.open()?
		.deposit(50)?
		.close()?
		.open()?
		.balance()?
	result == 0
}

## Cannot withdraw more than deposited
expect {
	result = BankAccount.create()
		.open()?
		.deposit(25)?
		.withdraw(50)
	result.is_err()
}

## Cannot check balance of unopened account
expect {
	result = BankAccount.create()
		.balance()
	result.is_err()
}

## Cannot withdraw from unopened account
expect {
	result = BankAccount.create()
		.withdraw(1)
	result.is_err()
}

## Cannot close an account twice
expect {
	result = BankAccount.create()
		.open()?
		.close()?
		.close()
	result.is_err()
}

## Cannot deposit zero
expect {
	result = BankAccount.create()
		.open()?
		.deposit(0)
	result.is_err()
}

## Cannot withdraw zero
expect {
	result = BankAccount.create()
		.open()?
		.withdraw(0)
	result.is_err()
}

## Can use the maximum balance
expect {
	result = BankAccount.create()
		.open()?
		.deposit(18446744073709551615)?
		.withdraw(18446744073709551615)?
		.balance()?
	result == 0
}

## Cannot overflow the balance
expect {
	result = BankAccount.create()
		.open()?
		.deposit(18446744073709551615)?
		.deposit(1)
	result.is_err()
}
