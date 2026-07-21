# File last updated on 2026-06-13

import ErrorHandling exposing [get_user, parse_user_id, get_page, error_message]

##
## get_user should return Ok(<user>) or Err(UserNotFound(<user_id>))
##

# get_user 123 should return Alice
expect {
	result = get_user(123)
	result == Ok({ name: "Alice" })
}

# get_user 456 should return Bob
expect {
	result = get_user(456)
	result == Ok({ name: "Bob" })
}

# get_user 789 should return Charlie
expect {
	result = get_user(789)
	result == Ok({ name: "Charlie" })
}

# get_user 42 should return an error
expect {
	result = get_user(42)
	result == Err(UserNotFound(42))
}

##
## parse_user_id should parse a string formatted as "/users/<user_id>" to a
## positive integer, and return Ok(<user_id>) if successful, or
## Err(InvalidUserId(<user_id_str>)) otherwise
##

# Parsing a valid user ID should return Ok(<user_id>)
expect {
	result = parse_user_id("/users/123")
	result == Ok(123)
}

# Parsing an empty string should fail
expect {
	result = parse_user_id("/users/")
	result == Err(InvalidUserId(""))
}

# Parsing a negative number should fail
expect {
	result = parse_user_id("/users/-123")
	result == Err(InvalidUserId("-123"))
}

# Parsing a fractional number should fail
expect {
	result = parse_user_id("/users/123.456")
	result == Err(InvalidUserId("123.456"))
}

# Parsing a number in scientific format should fail
expect {
	result = parse_user_id("/users/1e03")
	result == Err(InvalidUserId("1e03"))
}

# Parsing a string containing letters should fail
expect {
	result = parse_user_id("/users/abc")
	result == Err(InvalidUserId("abc"))
}

# Parsing a string containing a valid user_id followed by junk should fail
expect {
	result = parse_user_id("/users/123 abc")
	result == Err(InvalidUserId("123 abc"))
}

##
## get_page should return Ok with the desired page if it exists
## or it should return the proper Err value if anything fails
##

# No error for root URL
expect {
	result = get_page("https://example.com/")
	result == Ok("Home page")
}

# No error for users URL
expect {
	result = get_page("https://example.com/users/")
	result == Ok("Users page")
}

# No error for specific user URL
expect {
	result = get_page("https://example.com/users/123")
	result == Ok("Alice's page")
}

# No error for specific user URL
expect {
	result = get_page("https://example.com/users/456")
	result == Ok("Bob's page")
}

# No error for specific user URL
expect {
	result = get_page("https://example.com/users/789")
	result == Ok("Charlie's page")
}

# Error: insecure connection
expect {
	result = get_page("http://example.com/users/789")
	result == Err(InsecureConnection("http://example.com/users/789"))
}

# Error: invalid domain name
expect {
	result = get_page("https://google.com/wrong")
	result == Err(InvalidDomain("https://google.com/wrong"))
}

# Error: page not found
expect {
	result = get_page("https://example.com/oops")
	result == Err(PageNotFound("/oops"))
}

# Error: invalid user_id
expect {
	result = get_page("https://example.com/users/abc")
	result == Err(InvalidUserId("abc"))
}

# Error: user not found
expect {
	result = get_page("https://example.com/users/42")
	result == Err(UserNotFound(42))
}

##
## Handle errors and return a clear message to the user, in the user's language.
## Your implementation must at least handle English, but you can handle other
## languages if you want
##

# Error: insecure connection
# Note: instead of displaying an error message, the server could automatically
# redirect the user to the HTTPS URL. This is an example of a recoverable error
# which would be easy to handle because the error payload is machine-friendly
expect {
	page = get_page("http://example.com/users/789")
	result = page.map_err(|e| e->error_message(English))
	result == Err("Insecure connection (non HTTPS): http://example.com/users/789")
}

# Error: invalid domain name
expect {
	page = get_page("https://google.com/wrong")
	result = page.map_err(|e| e->error_message(English))
	result == Err("Invalid domain name: https://google.com/wrong")
}

# Error: page not found
expect {
	page = get_page("https://example.com/oops")
	result = page.map_err(|e| e->error_message(English))
	result == Err("Page not found: /oops")
}

# Error: invalid user_id
expect {
	page = get_page("https://example.com/users/abc")
	result = page.map_err(|e| e->error_message(English))
	result == Err("User ID is not a positive integer: abc")
}

# Error: user not found
expect {
	page = get_page("https://example.com/users/42")
	result = page.map_err(|e| e->error_message(English))
	result == Err("User #42 was not found")
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
