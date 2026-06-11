# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/affine-cipher/canonical-data.json
# File last updated on 2026-06-11

main! = |_args| {
	Ok({})
}

import AffineCipher

##
## encode
##

# encode yes
expect {
	phrase = "yes"
	affine_cipher = AffineCipher.new({ a: 5, b: 7 })?
	result = affine_cipher.encode(phrase)
	expected = "xbt"
	result == expected
}

# encode no
expect {
	phrase = "no"
	affine_cipher = AffineCipher.new({ a: 15, b: 18 })?
	result = affine_cipher.encode(phrase)
	expected = "fu"
	result == expected
}

# encode OMG
expect {
	phrase = "OMG"
	affine_cipher = AffineCipher.new({ a: 21, b: 3 })?
	result = affine_cipher.encode(phrase)
	expected = "lvz"
	result == expected
}

# encode O M G
expect {
	phrase = "O M G"
	affine_cipher = AffineCipher.new({ a: 25, b: 47 })?
	result = affine_cipher.encode(phrase)
	expected = "hjp"
	result == expected
}

# encode mindblowingly
expect {
	phrase = "mindblowingly"
	affine_cipher = AffineCipher.new({ a: 11, b: 15 })?
	result = affine_cipher.encode(phrase)
	expected = "rzcwa gnxzc dgt"
	result == expected
}

# encode numbers
expect {
	phrase = "Testing,1 2 3, testing."
	affine_cipher = AffineCipher.new({ a: 3, b: 4 })?
	result = affine_cipher.encode(phrase)
	expected = "jqgjc rw123 jqgjc rw"
	result == expected
}

# encode deep thought
expect {
	phrase = "Truth is fiction."
	affine_cipher = AffineCipher.new({ a: 5, b: 17 })?
	result = affine_cipher.encode(phrase)
	expected = "iynia fdqfb ifje"
	result == expected
}

# encode all the letters
expect {
	phrase = "The quick brown fox jumps over the lazy dog."
	affine_cipher = AffineCipher.new({ a: 17, b: 33 })?
	result = affine_cipher.encode(phrase)
	expected = "swxtj npvyk lruol iejdc blaxk swxmh qzglf"
	result == expected
}

# encode with a not coprime to m
expect {
	affine_cipher = AffineCipher.new({ a: 6, b: 17 })
	affine_cipher.is_err()
	# AffineCipher could not be created, so cannot encode or decode
}

##
## decode
##

# decode exercism
expect {
	phrase = "tytgn fjr"
	affine_cipher = AffineCipher.new({ a: 3, b: 7 })?
	result = affine_cipher.decode(phrase)
	expected = Ok("exercism")
	result == expected
}

# decode a sentence
expect {
	phrase = "qdwju nqcro muwhn odqun oppmd aunwd o"
	affine_cipher = AffineCipher.new({ a: 19, b: 16 })?
	result = affine_cipher.decode(phrase)
	expected = Ok("anobstacleisoftenasteppingstone")
	result == expected
}

# decode numbers
expect {
	phrase = "odpoz ub123 odpoz ub"
	affine_cipher = AffineCipher.new({ a: 25, b: 7 })?
	result = affine_cipher.decode(phrase)
	expected = Ok("testing123testing")
	result == expected
}

# decode all the letters
expect {
	phrase = "swxtj npvyk lruol iejdc blaxk swxmh qzglf"
	affine_cipher = AffineCipher.new({ a: 17, b: 33 })?
	result = affine_cipher.decode(phrase)
	expected = Ok("thequickbrownfoxjumpsoverthelazydog")
	result == expected
}

# decode with no spaces in input
expect {
	phrase = "swxtjnpvyklruoliejdcblaxkswxmhqzglf"
	affine_cipher = AffineCipher.new({ a: 17, b: 33 })?
	result = affine_cipher.decode(phrase)
	expected = Ok("thequickbrownfoxjumpsoverthelazydog")
	result == expected
}

# decode with too many spaces
expect {
	phrase = "vszzm    cly   yd cg    qdp"
	affine_cipher = AffineCipher.new({ a: 15, b: 16 })?
	result = affine_cipher.decode(phrase)
	expected = Ok("jollygreengiant")
	result == expected
}

# decode with a not coprime to m
expect {
	affine_cipher = AffineCipher.new({ a: 13, b: 5 })
	affine_cipher.is_err()
	# AffineCipher could not be created, so cannot encode or decode
}
