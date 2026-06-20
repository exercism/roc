Temp :: {}.{
	get_user : UserId -> Try(User, [UserNotFound(UserId)])
	get_user = |user_id| {
		match users.get(user_id) {
			Ok(user) => Ok(user)
			Err(KeyNotFound) => Err(UserNotFound(user_id))
		}
	}

	parse_user_id : Str -> Try(UserId, [InvalidUserId(Str)])
	parse_user_id = |path| {
		user_id_str = Str.replace_each(path, "/users/", "")
		match U64.from_str(user_id_str) {
			Ok(id) => Ok(id)
			Err(BadNumStr) => Err(InvalidUserId(user_id_str))
		}
	}

	get_page : Str -> Try(Str, [InsecureConnection(Str), InvalidDomain(Str), InvalidUserId(Str), UserNotFound(UserId), PageNotFound(Str)])
	get_page = |url| {
		match parse_path(url) {
			Ok(path) => {
				match path {
					"/" => Ok("Home page")
					"/users/" => Ok("Users page")
					user_path if user_path.starts_with("/users/") => {
						match parse_user_id(user_path) {
							Ok(user_id) => {
								match get_user(user_id) {
									Ok(user) => Ok("${user.name}'s page")
									Err(UserNotFound(uid)) => Err(UserNotFound(uid))
								}
							}
							Err(InvalidUserId(uid_str)) => Err(InvalidUserId(uid_str))
						}
					}

					unknown_path => Err(PageNotFound(unknown_path))
				}
			}

			Err(InsecureConnection(url_err)) => Err(InsecureConnection(url_err))
			Err(InvalidDomain(url_err)) => Err(InvalidDomain(url_err))
		}
	}

	error_message : [InsecureConnection(Str), InvalidDomain(Str), InvalidUserId(Str), UserNotFound(UserId), PageNotFound(Str)], [English, French] -> Str
	error_message = |err, language| {
		match language {
			English => {
				match err {
					InsecureConnection(url) => "Insecure connection (non HTTPS): ${url}"
					InvalidDomain(url) => "Invalid domain name: ${url}"
					InvalidUserId(user_id_str) => "User ID is not a positive integer: ${user_id_str}"
					UserNotFound(user_id) => "User #${user_id.to_str()} was not found"
					PageNotFound(path) => "Page not found: ${path}"
				}
			}

			French => {
				match err {
					InsecureConnection(url) => "Connexion non sécurisée (non HTTPS): ${url}"
					InvalidDomain(url) => "Ce nom de domaine est incorrect: ${url}"
					InvalidUserId(user_id_str) => "Cet identifiant utilisateur devrait être un entier positif: ${user_id_str}"
					UserNotFound(user_id) => "L'utilisateur #${user_id.to_str()} est inconnu"
					PageNotFound(path) => "Cette page est inconnue: ${path}"
				}
			}
		}
	}
}

User : { name : Str }

UserId : U64

users : Dict(UserId, User)
users = 
	Dict.from_list(
		[
			(123, { name: "Alice" }),
			(456, { name: "Bob" }),
			(789, { name: "Charlie" }),
		],
	)

parse_path : Str -> Try(Str, [InvalidDomain(Str), InsecureConnection(Str)])
parse_path = |url| {
	prefix = "https://example.com"
	if url.starts_with(prefix) {
		Ok(Str.replace_each(url, prefix, ""))
	} else if url.starts_with("https://") {
		Err(InvalidDomain(url))
	} else {
		Err(InsecureConnection(url))
	}
}
