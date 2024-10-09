# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/phone-number/canonical-data.json
# File last updated on 2024-10-09
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import PhoneNumber exposing [clean]

# cleans the number
expect
    result = clean "(223) 456-7890"
    expected = Ok "2234567890"
    result == expected

# cleans numbers with dots
expect
    result = clean "223.456.7890"
    expected = Ok "2234567890"
    result == expected

# cleans numbers with multiple spaces
expect
    result = clean "223 456   7890   "
    expected = Ok "2234567890"
    result == expected

# invalid when 9 digits
expect
    result = clean "123456789"
    result |> Result.isErr

# invalid when 11 digits does not start with a 1
expect
    result = clean "22234567890"
    result |> Result.isErr

# valid when 11 digits and starting with 1
expect
    result = clean "12234567890"
    expected = Ok "2234567890"
    result == expected

# valid when 11 digits and starting with 1 even with punctuation
expect
    result = clean "+1 (223) 456-7890"
    expected = Ok "2234567890"
    result == expected

# invalid when more than 11 digits
expect
    result = clean "321234567890"
    result |> Result.isErr

# invalid with letters
expect
    result = clean "523-abc-7890"
    result |> Result.isErr

# invalid with punctuations
expect
    result = clean "523-@:!-7890"
    result |> Result.isErr

# invalid if area code starts with 0
expect
    result = clean "(023) 456-7890"
    result |> Result.isErr

# invalid if area code starts with 1
expect
    result = clean "(123) 456-7890"
    result |> Result.isErr

# invalid if exchange code starts with 0
expect
    result = clean "(223) 056-7890"
    result |> Result.isErr

# invalid if exchange code starts with 1
expect
    result = clean "(223) 156-7890"
    result |> Result.isErr

# invalid if area code starts with 0 on valid 11-digit number
expect
    result = clean "1 (023) 456-7890"
    result |> Result.isErr

# invalid if area code starts with 1 on valid 11-digit number
expect
    result = clean "1 (123) 456-7890"
    result |> Result.isErr

# invalid if exchange code starts with 0 on valid 11-digit number
expect
    result = clean "1 (223) 056-7890"
    result |> Result.isErr

# invalid if exchange code starts with 1 on valid 11-digit number
expect
    result = clean "1 (223) 156-7890"
    result |> Result.isErr

