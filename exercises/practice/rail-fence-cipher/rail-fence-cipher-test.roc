# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/rail-fence-cipher/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import RailFenceCipher exposing [encode, decode]

##
## encode
##

# encode with two rails
expect
    message = "XOXOXOXOXOXOXOXOXO"
    result = message |> encode(2)
    expected = Ok("XXXXXXXXXOOOOOOOOO")
    result == expected

# encode with three rails
expect
    message = "WEAREDISCOVEREDFLEEATONCE"
    result = message |> encode(3)
    expected = Ok("WECRLTEERDSOEEFEAOCAIVDEN")
    result == expected

# encode with ending in the middle
expect
    message = "EXERCISES"
    result = message |> encode(4)
    expected = Ok("ESXIEECSR")
    result == expected

##
## decode
##

# decode with three rails
expect
    message = "TEITELHDVLSNHDTISEIIEA"
    result = message |> decode(3)
    expected = Ok("THEDEVILISINTHEDETAILS")
    result == expected

# decode with five rails
expect
    message = "EIEXMSMESAORIWSCE"
    result = message |> decode(5)
    expected = Ok("EXERCISMISAWESOME")
    result == expected

# decode with six rails
expect
    message = "133714114238148966225439541018335470986172518171757571896261"
    result = message |> decode(6)
    expected = Ok("112358132134558914423337761098715972584418167651094617711286")
    result == expected

