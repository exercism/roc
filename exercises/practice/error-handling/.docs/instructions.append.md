# Instructions append

You are building a tiny web server that queries an even tinier user database. Sounds easy, but in the real world many things can (and often do) go wrong:

- the connection may be insecure: the URL must start with `"https://"`
- the domain name may be invalid: in this exercise, it should be `"example.com"`
- the page may not be found: only `"https://example.com/"`, `"https://example.com/users/"` and `"https://example.com/users/<userId>"` are allowed
- the `userId` may not be a positive integer
- no user may exist in the database with this `userId`

When things go wrong, it's important to give the end user a nice and helpful error message so that they can solve the issue. For this, you need to ensure that your code propagates informative errors from the point where the error is detected to the point where the error message is produced.

Luckily, Roc allows you to carry payload (i.e., data) inside your `Err` tag. It's tempting to carry an error message directly (e.g., `Err "User #42 was not found"`), and this may be fine in some simple cases, but this has several limitations:

- you might not have enough context inside the function that detects the error to produce a sufficiently helpful error message.
  - For example, the `Str.to_u64` function can be used to parse all sorts of integers: days, seconds, user IDs, and more. If the error message just says `Could not convert string "0.5" to a positive integer`, the user may not have enough context to solve the issue.
- in many cases your error handling code may need to handle some errors differently than others. However, if the errors only carry string payloads, your error handling code will have to parse that string to know what problem occurred: this is inefficient and it can easily break if the error message is ever tweaked.
- if your website is multilingual, you will need to translate the error message to the user's language. It's going to be much easier to do that if the error payload is machine-friendly data rather than an English string.

So in this exercise, your errors will instead carry a meaningful tag along with its own helpful payload. For example, if the user is not found, the error will look like `Err (UserNotFound 42)`.

Okay, let's get started! Here's what you need to do:

1. Implement `getUser` to return the requested user from the `users` "database" (it's actually just a `Dict`). Make sure the function returns `Err (UserNotFound userId)` in case the user is not found, instead of `Err KeyNotFound`.
2. Implement `parseUserId` to convert the URL's path (such as `"/users/123"`) to a positive integer user ID (`123`). In case of error, return `Err (InvalidUserId userIdStr)`.
3. Implement `getPage`:
   - If the URL is `"https://example.com/"`, return `Ok "Home page"`
   - If the URL is `"https://example.com/users/"`, return `Ok "Users page"`
   - If the URL is `"https://example.com/users/<userId>"`, parse the user ID, load the user with that ID, and return `Ok "<user name>'s page"`
   - If the URL prefix is not `"https://"`, return `Err (InsecureConnection url)`
   - If the URL domain name is not `"example.com"`, return `Err (InvalidDomain url)`
   - If the path is not `/` or `/users/` or `/users/<user id>`, return `Err (PageNotFound path)`
   - If the user ID is not a positive integer, return `Err (InvalidUserId userIdStr)`
   - If the user does not exist, return `Err (UserNotFound userId)`
4. Implement `errorMessage` to convert the previous errors to translated error messages. The function should at least handle English, but you are encouraged to try handling another language as well. The English error messages should like this:

- `"Insecure connection (non HTTPS): http://example.com/users/789"`
- `"Invalid domain name: https://google.com/wrong"`
- `"Page not found: /oops"`
- `"User ID is not a positive integer: abc"`
- `"User #42 was not found"`

Note: instead of displaying an error message to the user when they use HTTP instead of HTTPS, your web server could redirect their browser to HTTPS, and the user would not even notice the error. Since the errors are machine-friendly in Roc, this would be very easy to implement.
