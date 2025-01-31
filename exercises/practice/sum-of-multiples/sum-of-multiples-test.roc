# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/sum-of-multiples/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import SumOfMultiples exposing [sum_of_multiples]

# no multiples within limit
expect
    result = [3, 5] |> sum_of_multiples(1)
    result == 0

# one factor has multiples within limit
expect
    result = [3, 5] |> sum_of_multiples(4)
    result == 3

# more than one multiple within limit
expect
    result = [3] |> sum_of_multiples(7)
    result == 9

# more than one factor with multiples within limit
expect
    result = [3, 5] |> sum_of_multiples(10)
    result == 23

# each multiple is only counted once
expect
    result = [3, 5] |> sum_of_multiples(100)
    result == 2318

# a much larger limit
expect
    result = [3, 5] |> sum_of_multiples(1000)
    result == 233168

# three factors
expect
    result = [7, 13, 17] |> sum_of_multiples(20)
    result == 51

# factors not relatively prime
expect
    result = [4, 6] |> sum_of_multiples(15)
    result == 30

# some pairs of factors relatively prime and some not
expect
    result = [5, 6, 8] |> sum_of_multiples(150)
    result == 4419

# one factor is a multiple of another
expect
    result = [5, 25] |> sum_of_multiples(51)
    result == 275

# much larger factors
expect
    result = [43, 47] |> sum_of_multiples(10000)
    result == 2203160

# all numbers are multiples of 1
expect
    result = [1] |> sum_of_multiples(100)
    result == 4950

# no factors means an empty sum
expect
    result = [] |> sum_of_multiples(10000)
    result == 0

# the only multiple of 0 is 0
expect
    result = [0] |> sum_of_multiples(1)
    result == 0

# the factor 0 does not affect the sum of multiples of other factors
expect
    result = [3, 0] |> sum_of_multiples(4)
    result == 3

# solutions using include-exclude must extend to cardinality greater than 3
expect
    result = [2, 3, 5, 7, 11] |> sum_of_multiples(10000)
    result == 39614537

