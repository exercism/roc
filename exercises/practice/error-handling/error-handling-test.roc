# File last updated on 2024-09-12
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import ErrorHandling exposing [getUser, parseUserId, getPage, errorMessage]

##
## getUser should return Ok <user> or Err UserNotFound <userId>
##

# getUser 123 should return Alice
expect
    result = getUser 123
    result == Ok { name: "Alice" }

# getUser 456 should return Bob
expect
    result = getUser 456
    result == Ok { name: "Bob" }

# getUser 789 should return Charlie
expect
    result = getUser 789
    result == Ok { name: "Charlie" }

# getUser 42 should return an error
expect
    result = getUser 42
    result == Err (UserNotFound 42)

##
## parseUserId should parse a string to a positive integer and return
## Ok <userId> if successful, or Err InvalidUserId <userIdStr> otherwise
##

# Parsing a valid userId should return Ok <userId>
expect
    result = parseUserId "123"
    result == Ok 123

# Parsing an empty string should fail
expect
    result = parseUserId ""
    result == Err (InvalidUserId "")

# Parsing a negative number should fail
expect
    result = parseUserId "-123"
    result == Err (InvalidUserId "-123")

# Parsing a fractional number should fail
expect
    result = parseUserId "123.456"
    result == Err (InvalidUserId "123.456")

# Parsing a number in scientific format should fail
expect
    result = parseUserId "1e03"
    result == Err (InvalidUserId "1e03")

# Parsing a string containing letters should fail
expect
    result = parseUserId "abc"
    result == Err (InvalidUserId "abc")

# Parsing a string containing a valid userId followed by junk should fail
expect
    result = parseUserId "123 abc"
    result == Err (InvalidUserId "123 abc")

##
## getPage should return Ok with the desired page if it exists
## or it should return the proper Err value if anything fails
##

# No error for root URL
expect
    result = getPage "https://example.com/"
    result == Ok "Home page"

# No error for users URL
expect
    result = getPage "https://example.com/users/"
    result == Ok "Users page"

# No error for specific user URL
expect
    result = getPage "https://example.com/users/123"
    result == Ok "Alice's page"

# No error for specific user URL
expect
    result = getPage "https://example.com/users/456"
    result == Ok "Bob's page"

# No error for specific user URL
expect
    result = getPage "https://example.com/users/789"
    result == Ok "Charlie's page"

# Error: insecure connection
expect
    result = getPage "http://example.com/users/789"
    result == Err (InsecureConnection "http://example.com/users/789")

# Error: invalid domain name
expect
    result = getPage "https://google.com/wrong"
    result == Err (InvalidDomain "https://google.com/wrong")

# Error: page not found
expect
    result = getPage "https://example.com/oops"
    result == Err (PageNotFound "/oops")

# Error: invalid userId
expect
    result = getPage "https://example.com/users/abc"
    result == Err (InvalidUserId "abc")

# Error: user not found
expect
    result = getPage "https://example.com/users/42"
    result == Err (UserNotFound 42)

##
## Handle errors and return a clear message to the user, in the user's language
## Your implementation must at least handle English, but you can handle other
## languages if you want
##

# No error for root URL: just return the Ok result
expect
    pageResult = getPage "https://example.com/"
    result = pageResult |> Result.mapErr \err -> err |> errorMessage English
    result == Ok "Home page"

# No error for users URL: just return the Ok result
expect
    pageResult = getPage "https://example.com/users/"
    result = pageResult |> Result.mapErr \err -> err |> errorMessage English
    result == Ok "Users page"

# No error for specific user URL: just return the Ok result
expect
    pageResult = getPage "https://example.com/users/123"
    result = pageResult |> Result.mapErr \err -> err |> errorMessage English
    result == Ok "Alice's page"

# No error for specific user URL: just return the Ok result
expect
    pageResult = getPage "https://example.com/users/456"
    result = pageResult |> Result.mapErr \err -> err |> errorMessage English
    result == Ok "Bob's page"

# No error for specific user URL: just return the Ok result
expect
    pageResult = getPage "https://example.com/users/789"
    result = pageResult |> Result.mapErr \err -> err |> errorMessage English
    result == Ok "Charlie's page"

# Error: insecure connection
# Note: instead of displaying an error message, the server could automatically
# redirect the user to the HTTPS URL. This is an example of a recoverable error
# which would be easy to handle because the error payload is machine-friendly
expect
    pageResult = getPage "http://example.com/users/789"
    result = pageResult |> Result.mapErr \err -> err |> errorMessage English
    result == Err "Insecure connection (non HTTPS): http://example.com/users/789"

# Error: invalid domain name
expect
    pageResult = getPage "https://google.com/wrong"
    result = pageResult |> Result.mapErr \err -> err |> errorMessage English
    result == Err "Invalid domain name: https://google.com/wrong"

# Error: page not found
expect
    pageResult = getPage "https://example.com/oops"
    result = pageResult |> Result.mapErr \err -> err |> errorMessage English
    result == Err "Page not found: /oops"

# Error: invalid userId
expect
    pageResult = getPage "https://example.com/users/abc"
    result = pageResult |> Result.mapErr \err -> err |> errorMessage English
    result == Err "User ID is not a positive integer: abc"

# Error: user not found
expect
    pageResult = getPage "https://example.com/users/42"
    result = pageResult |> Result.mapErr \err -> err |> errorMessage English
    result == Err "User #42 was not found"
