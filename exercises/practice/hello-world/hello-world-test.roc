# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/hello-world/canonical-data.json
# File last updated on 2026-06-22

import HelloWorld exposing [hello]

# Say Hi!
expect {
	result = hello
	result == "Hello, World!"

}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
