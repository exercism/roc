RestApi :: {}.{
	User : {
		name : Str,
		owes : Dict(Str, Dec),
		owed_by : Dict(Str, Dec),
		balance : Dec,
	}

	Database : { users : List(User) }

	get : Database, { url : Str, payload : Str } -> Try(Str, _)
	get = |database, { url, payload }| {
		crash "Please implement the 'get' function"
	}

	post : Database, { url : Str, payload : Str } -> Try(Str, _)
	post = |database, { url, payload }| {
		crash "Please implement the 'post' function"
	}
}
