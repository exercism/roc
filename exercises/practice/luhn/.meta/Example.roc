module [valid]

valid : Str -> Bool
valid = \number ->
    dbg "Input: $(number)"

    digits =
        Str.toUtf8 number
        |> List.keepIf \byte ->
            '0' <= byte && byte <= '9'
        |> List.map \byte ->
            byte - '0' |> Num.toU16

    if List.len digits < 2 then
        Bool.false
    else
        sum =
            mapEveryOther digits \digit ->
                product = digit * 9
                if product < 10 then product else product - 9
            |> List.sum
        dbg sum

        Num.isMultipleOf sum 10

mapEveryOther : List a, (a -> a) -> List a
mapEveryOther = \list, func ->
    help = \input, acc ->
        when input is
            [x, y, .. as rest] ->
                newAcc =
                    List.append acc (func x)
                    |> List.append y
                help rest newAcc

            [x] -> List.append acc (func x)
            [] -> acc

    help list []

# single digit strings can not be valid
expect
    result = valid "1"
    result == Bool.false

# a single zero is invalid
expect
    result = valid "0"
    result == Bool.false

# a simple valid SIN that remains valid if reversed
expect
    result = valid "059"
    result == Bool.true

# a simple valid SIN that becomes invalid if reversed
expect
    result = valid "59"
    result == Bool.true

# a valid Canadian SIN
expect
    result = valid "055 444 285"
    result == Bool.true

# invalid Canadian SIN
expect
    result = valid "055 444 286"
    result == Bool.false

# invalid credit card
expect
    result = valid "8273 1232 7352 0569"
    result == Bool.false

# invalid long number with an even remainder
expect
    result = valid "1 2345 6789 1234 5678 9012"
    result == Bool.false

# invalid long number with a remainder divisible by 5
expect
    result = valid "1 2345 6789 1234 5678 9013"
    result == Bool.false

# valid number with an even number of digits
expect
    result = valid "095 245 88"
    result == Bool.true

# valid number with an odd number of spaces
expect
    result = valid "234 567 891 234"
    result == Bool.true

# valid strings with a non-digit added at the end become invalid
expect
    result = valid "059a"
    result == Bool.false

# valid strings with punctuation included become invalid
expect
    result = valid "055-444-285"
    result == Bool.false

# valid strings with symbols included become invalid
expect
    result = valid "055# 444$ 285"
    result == Bool.false

# single zero with space is invalid
expect
    result = valid " 0"
    result == Bool.false

# more than a single zero is valid
expect
    result = valid "0000 0"
    result == Bool.true

# input digit 9 is correctly converted to output digit 9
expect
    result = valid "091"
    result == Bool.true

# very long input is valid
expect
    result = valid "9999999999 9999999999 9999999999 9999999999"
    result == Bool.true

# valid luhn with an odd number of digits and non zero first digit
expect
    result = valid "109"
    result == Bool.true

# using ascii value for non-doubled non-digit isn't allowed
expect
    result = valid "055b 444 285"
    result == Bool.false

# using ascii value for doubled non-digit isn't allowed
expect
    result = valid ":9"
    result == Bool.false

# non-numeric, non-space char in the middle with a sum that's divisible by 10 isn't allowed
expect
    result = valid "59%59"
    result == Bool.false
