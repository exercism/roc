# File last updated on 2026-08-12
app [main!] {
	pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.21.0/4rAQg8kUYZ3Vksr4qMQHpaFYNiHSn9GgS7gVxghd1XYV.tar.zst",
	random: "https://github.com/kili-ilo/roc-random/releases/download/0.9.0/CwDEAmyUMCsqW6dh4pxYnp7suUZAj5b5gpZuh7udtyE7.tar.zst",
}

import SimpleCipher
import random.Random

##
# Random key cipher
##

# Can encode
expect {
	{ cipher, random_state: _ } = SimpleCipher.create_random({ random_state: Random.seed(0), key_length: 100 })
	plaintext = "aaaaaaaaaa"
	ciphertext = cipher.encode(plaintext)
	expected = cipher.key |> substring(0, plaintext.count_utf8_bytes())?
	ciphertext == expected
}

# Can decode
expect {
	{ cipher, random_state: _ } = SimpleCipher.create_random({ random_state: Random.seed(0), key_length: 100 })
	expected = "aaaaaaaaaa"
	ciphertext = cipher.key |> substring(0, expected.count_utf8_bytes())?
	decoded = cipher.decode(ciphertext)
	decoded == expected
}

# Is reversible. I.e., if you apply decode to an encoded result, you must see the original plaintext
expect {
	{ cipher, random_state: _ } = SimpleCipher.create_random({ random_state: Random.seed(0), key_length: 100 })
	plaintext = "abcdefghij"
	ciphertext = cipher.encode(plaintext)
	decoded = cipher.decode(ciphertext)
	decoded == plaintext
}

# Key is made only of lowercase letters
expect {
	{ cipher, random_state: _ } = SimpleCipher.create_random({ random_state: Random.seed(0), key_length: 100 })
	cipher.key |> all_lowercase_letters
}

##
# Substitution cipher
##

# Can encode
expect {
	cipher = SimpleCipher.create({ key: "abcdefghij" })
	plaintext = "aaaaaaaaaa"
	ciphertext = cipher.encode(plaintext)
	ciphertext == "abcdefghij"
}

# Can decode
expect {
	cipher = SimpleCipher.create({ key: "abcdefghij" })
	plaintext = "abcdefghij"
	ciphertext = cipher.decode(plaintext)
	ciphertext == "aaaaaaaaaa"
}

# Is reversible. I.e., if you apply decode to an encoded result, you must see the original plaintext
expect {
	cipher = SimpleCipher.create({ key: "abcdefghij" })
	plaintext = "abcdefghij"
	ciphertext = cipher.encode(plaintext)
	decoded = cipher.decode(ciphertext)
	decoded == plaintext
}

# Can double shift encode
expect {
	cipher = SimpleCipher.create({ key: "iamapandabear" })
	plaintext = "iamapandabear"
	ciphertext = cipher.encode(plaintext)
	ciphertext == "qayaeaagaciai"
}

# Can wrap on encode
expect {
	cipher = SimpleCipher.create({ key: "abcdefghij" })
	plaintext = "zzzzzzzzzz"
	ciphertext = cipher.encode(plaintext)
	ciphertext == "zabcdefghi"
}

# Can wrap on decode
expect {
	cipher = SimpleCipher.create({ key: "abcdefghij" })
	ciphertext = "zabcdefghi"
	decoded = cipher.decode(ciphertext)
	decoded == "zzzzzzzzzz"
}

# Can encode messages longer than the key
expect {
	cipher = SimpleCipher.create({ key: "abc" })
	plaintext = "iamapandabear"
	ciphertext = cipher.encode(plaintext)
	ciphertext == "iboaqcnecbfcr"
}

# Can decode messages longer than the key
expect {
	cipher = SimpleCipher.create({ key: "abc" })
	ciphertext = "iboaqcnecbfcr"
	decoded = cipher.decode(ciphertext)
	decoded == "iamapandabear"
}

substring = |str, start, end| {
	len = str.count_utf8_bytes()
	str.drop_last_bytes(len - end)?.drop_first_bytes(start)
}

all_lowercase_letters = |str| {
	str.to_utf8().all(|c| c >= 'a' and c < 'z') # only characters a to z
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
