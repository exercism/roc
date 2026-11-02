ErrorHandling :: {}.{
	User : { name : Str }
	UserId : U64
	users : Dict(UserId, User)
	users = Dict.from_list([
		(123, { name: "Alice" }),
		(456, { name: "Bob" }),
		(789, { name: "Charlie" }),
	])

	get_user : UserId -> Try(User, _)
	get_user = |user_id| {
		crash "Please implement the 'get_user' function"
	}

	parse_user_id : Str -> Try(UserId, _)
	parse_user_id = |path| {
		crash "Please implement the 'parse_user_id' function"
	}

	get_page : Str -> Try(Str, _)
	get_page = |url| {
		crash "Please implement the 'get_page' function"
	}

	error_message : [InsecureConnection(Str), InvalidDomain(Str), InvalidUserId(Str), UserNotFound(UserId), PageNotFound(Str)], [English, French] -> Str
	error_message = |err, language| {
		crash "Please implement the 'error_message' function"
	}
}
