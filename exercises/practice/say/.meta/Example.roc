module [say]

zero_to_nineteen = [
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

tens_after_ten = [
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
say = |number|
    if number < 20 then
        zero_to_nineteen |> List.get(number)? |> Ok
    else if number < 100 then
        tens_word = tens_after_ten |> List.get(number // 10 - 2)?
        digit = number % 10
        if digit > 0 then
            digit_word = say(digit)?
            Ok("${tens_word}-${digit_word}")
        else
            Ok(tens_word)
    else if number < 1_000_000_000_000 then
        [
            (1_000_000_000_000, 1_000_000_000, "billion"),
            (1_000_000_000, 1_000_000, "million"),
            (1_000_000, 1000, "thousand"),
            (1000, 100, "hundred"),
            (100, 1, ""),
        ]
        |> List.keep_oks(
            |(modulo, divisor, name)|
                how_many = (number % modulo) // divisor
                if how_many == 0 then
                    Err(NothingToSay)
                else
                    say_how_many = say(how_many)?
                    Ok("${say_how_many} ${name}"),
        )
        |> Str.join_with(" ")
        |> Str.trim_end
        |> Ok
    else
        Err(OutOfBounds)
