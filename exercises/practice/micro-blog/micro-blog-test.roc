# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/micro-blog/canonical-data.json
# File last updated on 2026-06-13
app [main!] {
	pf: platform "https://github.com/lukewilliamboswell/roc-platform-template-zig/releases/download/0.7/DuRUyJh31Gt41YArMcVcvybLa2bCWboccWQ7Zq1KZPZ6.tar.zst",
	unicode: "https://github.com/roc-lang/unicode/releases/download/0.3.0/9KKFsA4CdOz0JIOL7iBSI_2jGIXQ6TsFBXgd086idpY.tar.br",
}

import pf.Stdout

import MicroBlog exposing [truncate]

# English language short
expect {
	result = truncate("Hi")
	result == Ok("Hi")
}

# English language long
expect {
	result = truncate("Hello there")
	result == Ok("Hello")
}

# German language short (broth)
expect {
	result = truncate("brühe")
	result == Ok("brühe")
}

# German language long (bear carpet → beards)
expect {
	result = truncate("Bärteppich")
	result == Ok("Bärte")
}

# Bulgarian language short (good)
expect {
	result = truncate("Добър")
	result == Ok("Добър")
}

# Greek language short (health)
expect {
	result = truncate("υγειά")
	result == Ok("υγειά")
}

# Maths short
expect {
	result = truncate("a=πr²")
	result == Ok("a=πr²")
}

# Maths long
expect {
	result = truncate("∅⊊ℕ⊊ℤ⊊ℚ⊊ℝ⊊ℂ")
	result == Ok("∅⊊ℕ⊊ℤ")
}

# English and emoji short
expect {
	result = truncate("Fly 🛫")
	result == Ok("Fly 🛫")
}

# Emoji short
expect {
	result = truncate("💇")
	result == Ok("💇")
}

# Emoji long
expect {
	result = truncate("❄🌡🤧🤒🏥🕰😀")
	result == Ok("❄🌡🤧🤒🏥")
}

# Royal Flush?
expect {
	result = truncate("🃎🂸🃅🃋🃍🃁🃊")
	result == Ok("🃎🂸🃅🃋🃍")
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
