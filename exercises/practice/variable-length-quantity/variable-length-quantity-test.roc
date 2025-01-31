# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/variable-length-quantity/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import VariableLengthQuantity exposing [encode, decode]

##
## Encode a series of integers, producing a series of bytes.
##

# zero
expect
    integers = [0]
    result = encode(integers)
    expected = [0]
    result == expected

# arbitrary single byte
expect
    integers = [64]
    result = encode(integers)
    expected = [64]
    result == expected

# largest single byte
expect
    integers = [127]
    result = encode(integers)
    expected = [127]
    result == expected

# smallest double byte
expect
    integers = [128]
    result = encode(integers)
    expected = [129, 0]
    result == expected

# arbitrary double byte
expect
    integers = [8192]
    result = encode(integers)
    expected = [192, 0]
    result == expected

# largest double byte
expect
    integers = [16383]
    result = encode(integers)
    expected = [255, 127]
    result == expected

# smallest triple byte
expect
    integers = [16384]
    result = encode(integers)
    expected = [129, 128, 0]
    result == expected

# arbitrary triple byte
expect
    integers = [1048576]
    result = encode(integers)
    expected = [192, 128, 0]
    result == expected

# largest triple byte
expect
    integers = [2097151]
    result = encode(integers)
    expected = [255, 255, 127]
    result == expected

# smallest quadruple byte
expect
    integers = [2097152]
    result = encode(integers)
    expected = [129, 128, 128, 0]
    result == expected

# arbitrary quadruple byte
expect
    integers = [134217728]
    result = encode(integers)
    expected = [192, 128, 128, 0]
    result == expected

# largest quadruple byte
expect
    integers = [268435455]
    result = encode(integers)
    expected = [255, 255, 255, 127]
    result == expected

# smallest quintuple byte
expect
    integers = [268435456]
    result = encode(integers)
    expected = [129, 128, 128, 128, 0]
    result == expected

# arbitrary quintuple byte
expect
    integers = [4278190080]
    result = encode(integers)
    expected = [143, 248, 128, 128, 0]
    result == expected

# maximum 32-bit integer input
expect
    integers = [4294967295]
    result = encode(integers)
    expected = [143, 255, 255, 255, 127]
    result == expected

# two single-byte values
expect
    integers = [64, 127]
    result = encode(integers)
    expected = [64, 127]
    result == expected

# two multi-byte values
expect
    integers = [16384, 1193046]
    result = encode(integers)
    expected = [129, 128, 0, 200, 232, 86]
    result == expected

# many multi-byte values
expect
    integers = [8192, 1193046, 268435455, 0, 16383, 16384]
    result = encode(integers)
    expected = [192, 0, 200, 232, 86, 255, 255, 255, 127, 0, 255, 127, 129, 128, 0]
    result == expected

##
## Decode a series of bytes, producing a series of integers.
##

# one byte
expect
    bytes = [127]
    result = decode(bytes)
    expected = Ok([127])
    result == expected

# two bytes
expect
    bytes = [192, 0]
    result = decode(bytes)
    expected = Ok([8192])
    result == expected

# three bytes
expect
    bytes = [255, 255, 127]
    result = decode(bytes)
    expected = Ok([2097151])
    result == expected

# four bytes
expect
    bytes = [129, 128, 128, 0]
    result = decode(bytes)
    expected = Ok([2097152])
    result == expected

# maximum 32-bit integer
expect
    bytes = [143, 255, 255, 255, 127]
    result = decode(bytes)
    expected = Ok([4294967295])
    result == expected

# incomplete sequence causes error
expect
    bytes = [255]
    result = decode(bytes)
    result |> Result.is_err

# incomplete sequence causes error, even if value is zero
expect
    bytes = [128]
    result = decode(bytes)
    result |> Result.is_err

# multiple values
expect
    bytes = [192, 0, 200, 232, 86, 255, 255, 255, 127, 0, 255, 127, 129, 128, 0]
    result = decode(bytes)
    expected = Ok([8192, 1193046, 268435455, 0, 16383, 16384])
    result == expected

