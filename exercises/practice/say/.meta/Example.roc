module [say]

zeroToNineteen = [
    "zero",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "eleven",
    "twelve",
    "thirteen",
    "fourteen",
    "fifteen",
    "sixteen",
    "seventeen",
    "eighteen",
    "nineteen",
]

tensAfterTen = [
    "twenty",
    "thirty",
    "forty",
    "fifty",
    "sixty",
    "seventy",
    "eighty",
    "ninety",
]

say : U64 -> Result Str [OutOfBounds]
say = \number ->
    if number < 20 then
        zeroToNineteen |> List.get? number |> Ok
    else if number < 100 then
        tensWord = tensAfterTen |> List.get? (number // 10 - 2)
        digit = number % 10
        if digit > 0 then
            digitWord = say? digit
            Ok "$(tensWord)-$(digitWord)"
        else
            Ok tensWord
    else if number < 1_000_000_000_000 then
        [
            (1_000_000_000_000, 1_000_000_000, "billion"),
            (1_000_000_000, 1_000_000, "million"),
            (1_000_000, 1000, "thousand"),
            (1000, 100, "hundred"),
            (100, 1, ""),
        ]
            |> List.keepOks \(modulo, divisor, name) ->
                howMany = (number % modulo) // divisor
                if howMany == 0 then
                    Err NothingToSay
                else
                    sayHowMany = say? howMany
                    Ok "$(sayHowMany) $(name)"
            |> Str.joinWith " "
            |> Str.trimEnd
            |> Ok
    else
        Err OutOfBounds
