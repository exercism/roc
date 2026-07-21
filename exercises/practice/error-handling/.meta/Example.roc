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
	get_user : UserId -> Try(User, [UserNotFound(UserId), ..])
	get_user = |user_id| {
		users.get(user_id).map_err(|_| UserNotFound(user_id))
	}

	# # Parses a string formatted as "/users/<user_id>" and returns the user_id
	# # or InvalidUserId(user_id_str) is the <user_id> part of the path cannot
	# # be parsed to a U64
	parse_user_id : Str -> Try(UserId, [InvalidUserId(Str), ..])
	parse_user_id = |path| {
		user_id_str = path.drop_prefix("/users/")
		user_id_str->U64.from_str().map_err(|_| InvalidUserId(user_id_str))
	}

	# # Takes a URL and returns the page content, or the appropriate error
	get_page : Str -> Try(Str, [InsecureConnection(Str), InvalidDomain(Str), InvalidUserId(Str), UserNotFound(UserId), PageNotFound(Str)])
	get_page = |url| {
		match parse_path(url) {
			Ok(path) => {
				match path {
					"/" => Ok("Home page")
					"/users/" => Ok("Users page")
					user_path if user_path.starts_with("/users/") => {
						user = user_path->parse_user_id()?->get_user()?
						Ok("${user.name}'s page")
					}
					unknown_path => Err(PageNotFound(unknown_path))
				}
			}
			Err(InsecureConnection(url_err)) => Err(InsecureConnection(url_err))
			Err(InvalidDomain(url_err)) => Err(InvalidDomain(url_err))
		}
	}

	# # Takes an error and returns the corresponding error message in the
	# # given language
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

# # Parses a URL formatted as https://example.com/<path> and returns "/<path>"
# # or the appropriate error if the URL is malformed or http instead of https
parse_path : Str -> Try(Str, [InvalidDomain(Str), InsecureConnection(Str), ..])
parse_path = |url| {
	prefix = "https://example.com"
	if url.starts_with(prefix) {
		path = url.drop_prefix(prefix)
		if path == "" {
			Ok("/")
		} else if path.starts_with("/") Ok(path) else Err(InvalidDomain(url))
	} else if url.starts_with("https://") {
		Err(InvalidDomain(url))
	} else {
		Err(InsecureConnection(url))
	}
}
