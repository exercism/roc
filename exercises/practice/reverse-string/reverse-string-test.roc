# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/reverse-string/canonical-data.json
# File last updated on 2026-08-01
app [main!] {
	pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.22.0/F1JVZPYfWP71s8vk6tHcV1Qx1Ef6CZkwswGoCn8VHZmL.tar.zst",
	unicode: "https://github.com/roc-lang/unicode/releases/download/4.0.0/3DGC3M4b2pxaRLg4i8cmxWkm2E2WbCPCLntQzf2mkbUV.tar.zst",
}

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
