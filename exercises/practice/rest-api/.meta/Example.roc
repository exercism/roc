RestApi :: {}.{
	User : {
		name : Str,
		owes : Dict(Str, Dec),
		owed_by : Dict(Str, Dec),
		balance : Dec,
	}

	Database : { users : List(User) }

	Loan : { lender : Str, borrower : Str, amount : Dec }

	get : Database, { url : Str, payload ?: Str } -> Try(Str, [Http404(Str), Http422(Str)])
	get = |database, { url, payload }| {
		match url {
			"/users" | "/users/" => {
				match payload {
					Ok(request_payload) => (database |> get_users(request_payload)).map_err(|_| Http422(request_payload))
					Err(MissingField) => Ok(users_to_json(database.users))
				}
			}
			bad_url => Err(Http404(bad_url))
		}
	}

	post : Database, { url : Str, payload ?: Str } -> Try(Str, [Http404(Str), Http422(Str), MissingField])
	post = |database, { url, payload }| {
		match url {
			"/add" => {
				match payload {
					Ok(request_payload) => (database |> add_user(request_payload)).map_err(|_| Http422(request_payload))
					Err(MissingField) => Err(MissingField)
				}
			}
			"/iou" => {
				match payload {
					Ok(request_payload) => {
						handle_error = |err| {
							match err {
								InvalidJson => Http422(request_payload)
								NotFound => Http404(request_payload)
							}
						}
						(database |> add_loan(request_payload)).map_err(handle_error)
					}
					Err(MissingField) => Err(MissingField)
				}
			}
			bad_url => Err(Http404(bad_url))
		}
	}
}

get_users : RestApi.Database, Str -> Try(Str, [InvalidJson])
get_users = |database, payload| {
	names = get_user_names(payload)?
	users = database.users.keep_if(|user| names.contains(user.name))
	Ok(users_to_json(users))
}

get_user_names : Str -> Try(List(Str), [InvalidJson])
get_user_names = |payload| {
	match parse_json_user(payload) {
		Ok(user_record) => Ok([user_record.user])
		Err(InvalidJson) => {
			users_record = parse_json_users(payload)?
			Ok(users_record.users)
		}
	}
}

users_to_json : List(RestApi.User) -> Str
users_to_json = |users| {
	sorted_users = users.sort_with(|user1, user2| compare_strings(user1.name, user2.name))
	{ users: sorted_users } |> Json.to_str
}

parse_json_user : Str -> Try({ user : Str }, [InvalidJson])
parse_json_user = |payload| {
	Json.parse(payload).map_err(|_| InvalidJson)
}

parse_json_users : Str -> Try({ users : List(Str) }, [InvalidJson])
parse_json_users = |payload| {
	Json.parse(payload).map_err(|_| InvalidJson)
}

add_user : RestApi.Database, Str -> Try(Str, [InvalidJson])
add_user = |_database, payload| {
	user_payload = parse_json_user(payload)?
	new_user : RestApi.User
	new_user =
		{
			name: user_payload.user,
			owes: Dict.empty(),
			owed_by: Dict.empty(),
			balance: 0.0,
		}
	Ok(new_user |> Json.to_str)
}

add_loan : RestApi.Database, Str -> Try(Str, [NotFound, InvalidJson])
add_loan = |database, payload| {
	loan = parse_json_loan(payload)?
	lender = database |> get_user(loan.lender)?
	borrower = database |> get_user(loan.borrower)?
	updated_lender = lender |> update_lender(borrower.name, loan.amount)
	updated_borrower = borrower |> update_lender(lender.name, -loan.amount)
	Ok(users_to_json([updated_lender, updated_borrower]))
}

update_lender : RestApi.User, Str, Dec -> RestApi.User
update_lender = |lender, borrower_name, amount| {
	(new_owes_dict, owes_amount) = lender.owes |> pop_amount(borrower_name)
	(new_owed_by_dict, owed_by_amount) = lender.owed_by |> pop_amount(borrower_name)
	total_lender_owes_to_borrower = owes_amount - owed_by_amount - amount
	final_owes_dict =
		if total_lender_owes_to_borrower > 0.0
			new_owes_dict.insert(borrower_name, total_lender_owes_to_borrower)
		else
			new_owes_dict
	final_owed_by_dict =
		if total_lender_owes_to_borrower < 0.0
			new_owed_by_dict.insert(borrower_name, -total_lender_owes_to_borrower)
		else
			new_owed_by_dict
	final_balance = lender.balance + amount
	{ ..lender, owes: final_owes_dict, owed_by: final_owed_by_dict, balance: final_balance }
}

pop_amount : Dict(Str, Dec), Str -> (Dict(Str, Dec), Dec)
pop_amount = |dict, key| {
	match dict.get(key) {
		Ok(value) => {
			new_dict = dict.remove(key)
			(new_dict, value)
		}
		Err(KeyNotFound) => (dict, 0.0)
	}
}

parse_json_loan : Str -> Try(RestApi.Loan, [InvalidJson, ..])
parse_json_loan = |payload| Json.parse(payload).map_err(|_| InvalidJson)

get_user : RestApi.Database, Str -> Try(RestApi.User, [NotFound, ..])
get_user = |database, name| {
	database.users
		.find_first(|user| user.name == name).map_err(|_| NotFound)
}

compare_strings : Str, Str -> [LT, EQ, GT]
compare_strings = |string1, string2| {
	b1 = string1.to_utf8()
	b2 = string2.to_utf8()
	result =
		b1.map2(b2, |c1, c2| c1.compare(c2))
			|> fold_try(
				Ok(EQ),
				|_state, cmp| {
					match cmp {
						EQ => Ok(EQ)
						res => Err(res)
					}
				},
			)
	match result {
		Ok(_cmp) => b1.len().compare(b2.len())
		Err(res) => res
	}
}

# The following function should soon be available in Roc's builtins
fold_try = |list, init, func| {
	var $state = init
	for item in list {
		$state = func($state, item)?
	}
	Ok($state)
}
