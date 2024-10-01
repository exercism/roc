# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/two-bucket/canonical-data.json
# File last updated on 2024-10-01
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import TwoBucket exposing [measure]

# Measure using bucket one of size 3 and bucket two of size 5 - start with bucket one
expect
    result = measure {
        bucketOne: 3,
        bucketTwo: 5,
        goal: 1,
        startBucket: One,
    }
    expected = Ok {
        moves: 4,
        goalBucket: One,
        otherBucket: 5,
    }
    result == expected

# Measure using bucket one of size 3 and bucket two of size 5 - start with bucket two
expect
    result = measure {
        bucketOne: 3,
        bucketTwo: 5,
        goal: 1,
        startBucket: Two,
    }
    expected = Ok {
        moves: 8,
        goalBucket: Two,
        otherBucket: 3,
    }
    result == expected

# Measure using bucket one of size 7 and bucket two of size 11 - start with bucket one
expect
    result = measure {
        bucketOne: 7,
        bucketTwo: 11,
        goal: 2,
        startBucket: One,
    }
    expected = Ok {
        moves: 14,
        goalBucket: One,
        otherBucket: 11,
    }
    result == expected

# Measure using bucket one of size 7 and bucket two of size 11 - start with bucket two
expect
    result = measure {
        bucketOne: 7,
        bucketTwo: 11,
        goal: 2,
        startBucket: Two,
    }
    expected = Ok {
        moves: 18,
        goalBucket: Two,
        otherBucket: 7,
    }
    result == expected

# Measure one step using bucket one of size 1 and bucket two of size 3 - start with bucket two
expect
    result = measure {
        bucketOne: 1,
        bucketTwo: 3,
        goal: 3,
        startBucket: Two,
    }
    expected = Ok {
        moves: 1,
        goalBucket: Two,
        otherBucket: 0,
    }
    result == expected

# Measure using bucket one of size 2 and bucket two of size 3 - start with bucket one and end with bucket two
expect
    result = measure {
        bucketOne: 2,
        bucketTwo: 3,
        goal: 3,
        startBucket: One,
    }
    expected = Ok {
        moves: 2,
        goalBucket: Two,
        otherBucket: 2,
    }
    result == expected

# Not possible to reach the goal
expect
    result = measure {
        bucketOne: 6,
        bucketTwo: 15,
        goal: 5,
        startBucket: One,
    }
    result |> Result.isErr

# With the same buckets but a different goal, then it is possible
expect
    result = measure {
        bucketOne: 6,
        bucketTwo: 15,
        goal: 9,
        startBucket: One,
    }
    expected = Ok {
        moves: 10,
        goalBucket: Two,
        otherBucket: 0,
    }
    result == expected

# Goal larger than both buckets is impossible
expect
    result = measure {
        bucketOne: 5,
        bucketTwo: 7,
        goal: 8,
        startBucket: One,
    }
    result |> Result.isErr

