# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/prime-factors/canonical-data.json
# File last updated on 2024-09-04
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import PrimeFactors exposing [primeFactors]

# no factors
expect
    result = primeFactors 1
    result == []

# prime number
expect
    result = primeFactors 2
    result == [2]

# another prime number
expect
    result = primeFactors 3
    result == [3]

# square of a prime
expect
    result = primeFactors 9
    result == [3, 3]

# product of first prime
expect
    result = primeFactors 4
    result == [2, 2]

# cube of a prime
expect
    result = primeFactors 8
    result == [2, 2, 2]

# product of second prime
expect
    result = primeFactors 27
    result == [3, 3, 3]

# product of third prime
expect
    result = primeFactors 625
    result == [5, 5, 5, 5]

# product of first and second prime
expect
    result = primeFactors 6
    result == [2, 3]

# product of primes and non-primes
expect
    result = primeFactors 12
    result == [2, 2, 3]

# product of primes
expect
    result = primeFactors 901255
    result == [5, 17, 23, 461]

# factors include a large prime
expect
    result = primeFactors 93819012551
    result == [11, 9539, 894119]

