# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/prime-factors/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/bi5zubJ-_Hva9vxxPq4kNx4WHX6oFs8OP6Ad0tCYlrY.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import PrimeFactors exposing [prime_factors]

# no factors
expect
    result = prime_factors(1)
    result == []

# prime number
expect
    result = prime_factors(2)
    result == [2]

# another prime number
expect
    result = prime_factors(3)
    result == [3]

# square of a prime
expect
    result = prime_factors(9)
    result == [3, 3]

# product of first prime
expect
    result = prime_factors(4)
    result == [2, 2]

# cube of a prime
expect
    result = prime_factors(8)
    result == [2, 2, 2]

# product of second prime
expect
    result = prime_factors(27)
    result == [3, 3, 3]

# product of third prime
expect
    result = prime_factors(625)
    result == [5, 5, 5, 5]

# product of first and second prime
expect
    result = prime_factors(6)
    result == [2, 3]

# product of primes and non-primes
expect
    result = prime_factors(12)
    result == [2, 2, 3]

# product of primes
expect
    result = prime_factors(901255)
    result == [5, 17, 23, 461]

# factors include a large prime
expect
    result = prime_factors(93819012551)
    result == [11, 9539, 894119]

