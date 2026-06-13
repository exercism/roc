# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/reverse-string/canonical-data.json
# File last updated on 2026-06-13
app [main!] {
	pf: platform "https://github.com/lukewilliamboswell/roc-platform-template-zig/releases/download/0.7/DuRUyJh31Gt41YArMcVcvybLa2bCWboccWQ7Zq1KZPZ6.tar.zst",
	unicode: "https://github.com/roc-lang/unicode/releases/download/0.3.0/9KKFsA4CdOz0JIOL7iBSI_2jGIXQ6TsFBXgd086idpY.tar.br",
}

import pf.Stdout

import ReverseString exposing [reverse]

# an empty string
expect {
	result = reverse("")
	result == ""
}

# a word
expect {
	result = reverse("robot")
	result == "tobor"
}

# a capitalized word
expect {
	result = reverse("Ramen")
	result == "nemaR"
}

# a sentence with punctuation
expect {
	result = reverse("I'm hungry!")
	result == "!yrgnuh m'I"
}

# a palindrome
expect {
	result = reverse("racecar")
	result == "racecar"
}

# an even-sized word
expect {
	result = reverse("drawer")
	result == "reward"
}

# wide characters
expect {
	result = reverse("子猫")
	result == "猫子"
}

# grapheme cluster with pre-combined form
expect {
	result = reverse("Würstchenstand")
	result == "dnatsnehctsrüW"
}

# grapheme clusters
expect {
	result = reverse("ผู้เขียนโปรแกรม")
	result == "มรกแรปโนยขีเผู้"
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
