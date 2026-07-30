# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/reverse-string/canonical-data.json
# File last updated on 2026-07-30
app [main!] {
	pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.21.0/4rAQg8kUYZ3Vksr4qMQHpaFYNiHSn9GgS7gVxghd1XYV.tar.zst",
	unicode: "https://github.com/roc-lang/unicode/releases/download/2.0.0/9ZvqNzsNkpqFmGTeATAY3BNBD7mP41jqZx2w2N19tBvh.tar.zst",
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
