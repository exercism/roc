# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/atbash-cipher/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import AtbashCipher exposing [encode, decode]

##
## encode
##

# encode yes
expect
    phrase = "yes"
    result = phrase |> encode
    expected = "bvh"
    result == Ok(expected)

# encode no
expect
    phrase = "no"
    result = phrase |> encode
    expected = "ml"
    result == Ok(expected)

# encode OMG
expect
    phrase = "OMG"
    result = phrase |> encode
    expected = "lnt"
    result == Ok(expected)

# encode spaces
expect
    phrase = "O M G"
    result = phrase |> encode
    expected = "lnt"
    result == Ok(expected)

# encode mindblowingly
expect
    phrase = "mindblowingly"
    result = phrase |> encode
    expected = "nrmwy oldrm tob"
    result == Ok(expected)

# encode numbers
expect
    phrase = "Testing,1 2 3, testing."
    result = phrase |> encode
    expected = "gvhgr mt123 gvhgr mt"
    result == Ok(expected)

# encode deep thought
expect
    phrase = "Truth is fiction."
    result = phrase |> encode
    expected = "gifgs rhurx grlm"
    result == Ok(expected)

# encode all the letters
expect
    phrase = "The quick brown fox jumps over the lazy dog."
    result = phrase |> encode
    expected = "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
    result == Ok(expected)

##
## decode
##

# decode exercism
expect
    phrase = "vcvix rhn"
    result = phrase |> decode
    expected = "exercism"
    result == Ok(expected)

# decode a sentence
expect
    phrase = "zmlyh gzxov rhlug vmzhg vkkrm thglm v"
    result = phrase |> decode
    expected = "anobstacleisoftenasteppingstone"
    result == Ok(expected)

# decode numbers
expect
    phrase = "gvhgr mt123 gvhgr mt"
    result = phrase |> decode
    expected = "testing123testing"
    result == Ok(expected)

# decode all the letters
expect
    phrase = "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
    result = phrase |> decode
    expected = "thequickbrownfoxjumpsoverthelazydog"
    result == Ok(expected)

# decode with too many spaces
expect
    phrase = "vc vix    r hn"
    result = phrase |> decode
    expected = "exercism"
    result == Ok(expected)

# decode with no spaces
expect
    phrase = "zmlyhgzxovrhlugvmzhgvkkrmthglmv"
    result = phrase |> decode
    expected = "anobstacleisoftenasteppingstone"
    result == Ok(expected)

