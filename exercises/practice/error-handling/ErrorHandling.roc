ErrorHandling :: {}.{
	User : { name : Str }
	UserId : U64
	users : Dict(UserId, User)
	users = Dict.from_list(
		[
			(123, { name: "Alice" }),
			(456, { name: "Bob" }),
			(789, { name: "Charlie" }),
		],
	)

	# # Returns the user with the given user_id, or UserNotFound(user_id)
	get_user : UserId -> Try(User, _)
	get_user = |user_id| {
		crash "Please implement the 'get_user' function"
	}

	# # Parses a string formatted as "/users/<user_id>" and returns the user_id
	# # or InvalidUserId(user_id_str) is the <user_id> part of the path cannot
	# # be parsed to a U64
	parse_user_id : Str -> Try(UserId, _)
	parse_user_id = |path| {
		crash "Please implement the 'parse_user_id' function"
	}

	# # Takes a URL and returns the page content, or the appropriate error
	get_page : Str -> Try(Str, _)
	get_page = |url| {
		crash "Please implement the 'get_page' function"
	}

	# # Takes an error and returns the corresponding error message in the
	# # given language
	error_message : [InsecureConnection(Str), InvalidDomain(Str), InvalidUserId(Str), UserNotFound(UserId), PageNotFound(Str)], [English, French] -> Str
	error_message = |err, language| {
		crash "Please implement the 'error_message' function"
	}
}
