# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/two-bucket/canonical-data.json
# File last updated on 2025-07-26
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import TwoBucket exposing [measure]

# Measure using bucket one of size 3 and bucket two of size 5 - start with bucket one
expect
    result = measure(
        {
            bucket_one: 3,
            bucket_two: 5,
            goal: 1,
            start_bucket: One,
        },
    )
    expected = Ok(
        {
            moves: 4,
            goal_bucket: One,
            other_bucket: 5,
        },
    )
    result == expected

# Measure using bucket one of size 3 and bucket two of size 5 - start with bucket two
expect
    result = measure(
        {
            bucket_one: 3,
            bucket_two: 5,
            goal: 1,
            start_bucket: Two,
        },
    )
    expected = Ok(
        {
            moves: 8,
            goal_bucket: Two,
            other_bucket: 3,
        },
    )
    result == expected

# Measure using bucket one of size 7 and bucket two of size 11 - start with bucket one
expect
    result = measure(
        {
            bucket_one: 7,
            bucket_two: 11,
            goal: 2,
            start_bucket: One,
        },
    )
    expected = Ok(
        {
            moves: 14,
            goal_bucket: One,
            other_bucket: 11,
        },
    )
    result == expected

# Measure using bucket one of size 7 and bucket two of size 11 - start with bucket two
expect
    result = measure(
        {
            bucket_one: 7,
            bucket_two: 11,
            goal: 2,
            start_bucket: Two,
        },
    )
    expected = Ok(
        {
            moves: 18,
            goal_bucket: Two,
            other_bucket: 7,
        },
    )
    result == expected

# Measure one step using bucket one of size 1 and bucket two of size 3 - start with bucket two
expect
    result = measure(
        {
            bucket_one: 1,
            bucket_two: 3,
            goal: 3,
            start_bucket: Two,
        },
    )
    expected = Ok(
        {
            moves: 1,
            goal_bucket: Two,
            other_bucket: 0,
        },
    )
    result == expected

# Measure using bucket one of size 2 and bucket two of size 3 - start with bucket one and end with bucket two
expect
    result = measure(
        {
            bucket_one: 2,
            bucket_two: 3,
            goal: 3,
            start_bucket: One,
        },
    )
    expected = Ok(
        {
            moves: 2,
            goal_bucket: Two,
            other_bucket: 2,
        },
    )
    result == expected

# Not possible to reach the goal
expect
    result = measure(
        {
            bucket_one: 6,
            bucket_two: 15,
            goal: 5,
            start_bucket: One,
        },
    )
    result |> Result.is_err

# With the same buckets but a different goal, then it is possible
expect
    result = measure(
        {
            bucket_one: 6,
            bucket_two: 15,
            goal: 9,
            start_bucket: One,
        },
    )
    expected = Ok(
        {
            moves: 10,
            goal_bucket: Two,
            other_bucket: 0,
        },
    )
    result == expected

# Goal larger than both buckets is impossible
expect
    result = measure(
        {
            bucket_one: 5,
            bucket_two: 7,
            goal: 8,
            start_bucket: One,
        },
    )
    result |> Result.is_err

