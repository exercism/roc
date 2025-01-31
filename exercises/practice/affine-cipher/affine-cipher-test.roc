# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/affine-cipher/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import AffineCipher exposing [encode, decode]

##
## encode
##

# encode yes
expect
    phrase = "yes"
    key = { a: 5, b: 7 }
    result = encode(phrase, key)
    expected = Ok("xbt")
    result == expected

# encode no
expect
    phrase = "no"
    key = { a: 15, b: 18 }
    result = encode(phrase, key)
    expected = Ok("fu")
    result == expected

# encode OMG
expect
    phrase = "OMG"
    key = { a: 21, b: 3 }
    result = encode(phrase, key)
    expected = Ok("lvz")
    result == expected

# encode O M G
expect
    phrase = "O M G"
    key = { a: 25, b: 47 }
    result = encode(phrase, key)
    expected = Ok("hjp")
    result == expected

# encode mindblowingly
expect
    phrase = "mindblowingly"
    key = { a: 11, b: 15 }
    result = encode(phrase, key)
    expected = Ok("rzcwa gnxzc dgt")
    result == expected

# encode numbers
expect
    phrase = "Testing,1 2 3, testing."
    key = { a: 3, b: 4 }
    result = encode(phrase, key)
    expected = Ok("jqgjc rw123 jqgjc rw")
    result == expected

# encode deep thought
expect
    phrase = "Truth is fiction."
    key = { a: 5, b: 17 }
    result = encode(phrase, key)
    expected = Ok("iynia fdqfb ifje")
    result == expected

# encode all the letters
expect
    phrase = "The quick brown fox jumps over the lazy dog."
    key = { a: 17, b: 33 }
    result = encode(phrase, key)
    expected = Ok("swxtj npvyk lruol iejdc blaxk swxmh qzglf")
    result == expected

# encode with a not coprime to m
expect
    phrase = "This is a test."
    key = { a: 6, b: 17 }
    result = encode(phrase, key)
    result |> Result.is_err

##
## decode
##

# decode exercism
expect
    phrase = "tytgn fjr"
    key = { a: 3, b: 7 }
    result = decode(phrase, key)
    expected = Ok("exercism")
    result == expected

# decode a sentence
expect
    phrase = "qdwju nqcro muwhn odqun oppmd aunwd o"
    key = { a: 19, b: 16 }
    result = decode(phrase, key)
    expected = Ok("anobstacleisoftenasteppingstone")
    result == expected

# decode numbers
expect
    phrase = "odpoz ub123 odpoz ub"
    key = { a: 25, b: 7 }
    result = decode(phrase, key)
    expected = Ok("testing123testing")
    result == expected

# decode all the letters
expect
    phrase = "swxtj npvyk lruol iejdc blaxk swxmh qzglf"
    key = { a: 17, b: 33 }
    result = decode(phrase, key)
    expected = Ok("thequickbrownfoxjumpsoverthelazydog")
    result == expected

# decode with no spaces in input
expect
    phrase = "swxtjnpvyklruoliejdcblaxkswxmhqzglf"
    key = { a: 17, b: 33 }
    result = decode(phrase, key)
    expected = Ok("thequickbrownfoxjumpsoverthelazydog")
    result == expected

# decode with too many spaces
expect
    phrase = "vszzm    cly   yd cg    qdp"
    key = { a: 15, b: 16 }
    result = decode(phrase, key)
    expected = Ok("jollygreengiant")
    result == expected

# decode with a not coprime to m
expect
    phrase = "Test"
    key = { a: 13, b: 5 }
    result = decode(phrase, key)
    result |> Result.is_err

