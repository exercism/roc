# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/sum-of-multiples/canonical-data.json
# File last updated on 2024-09-02
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import SumOfMultiples exposing [sumOfMultiples]

# no multiples within limit
expect
    result = [3, 5] |> sumOfMultiples 1
    result == 0

# one factor has multiples within limit
expect
    result = [3, 5] |> sumOfMultiples 4
    result == 3

# more than one multiple within limit
expect
    result = [3] |> sumOfMultiples 7
    result == 9

# more than one factor with multiples within limit
expect
    result = [3, 5] |> sumOfMultiples 10
    result == 23

# each multiple is only counted once
expect
    result = [3, 5] |> sumOfMultiples 100
    result == 2318

# a much larger limit
expect
    result = [3, 5] |> sumOfMultiples 1000
    result == 233168

# three factors
expect
    result = [7, 13, 17] |> sumOfMultiples 20
    result == 51

# factors not relatively prime
expect
    result = [4, 6] |> sumOfMultiples 15
    result == 30

# some pairs of factors relatively prime and some not
expect
    result = [5, 6, 8] |> sumOfMultiples 150
    result == 4419

# one factor is a multiple of another
expect
    result = [5, 25] |> sumOfMultiples 51
    result == 275

# much larger factors
expect
    result = [43, 47] |> sumOfMultiples 10000
    result == 2203160

# all numbers are multiples of 1
expect
    result = [1] |> sumOfMultiples 100
    result == 4950

# no factors means an empty sum
expect
    result = [] |> sumOfMultiples 10000
    result == 0

# the only multiple of 0 is 0
expect
    result = [0] |> sumOfMultiples 1
    result == 0

# the factor 0 does not affect the sum of multiples of other factors
expect
    result = [3, 0] |> sumOfMultiples 4
    result == 3

# solutions using include-exclude must extend to cardinality greater than 3
expect
    result = [2, 3, 5, 7, 11] |> sumOfMultiples 10000
    result == 39614537

