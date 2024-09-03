module [rebase]

rebase : { inputBase : U64, outputBase : U64, digits : List U64 } -> Result (List U64) _
rebase = \{ inputBase, outputBase, digits } ->
    if inputBase <= 1 then
        Err InputBaseMustBeGreaterThanOne
    else if outputBase <= 1 then
        Err OutputBaseMustBeGreaterThanOne
    else if List.any digits \digit -> digit >= inputBase then
        Err DigitsMustBeLessThanInputBase
    else
        numberInBase10 =
            List.reverse digits
            |> List.mapWithIndex \digit, index ->
                digit * (Num.powInt inputBase index)
            |> List.sum

        toDigits numberInBase10 outputBase |> Ok

toDigits : U64, U64 -> List U64
toDigits = \number, base ->
    help = \digits, remaining, exponent ->
        if exponent == 0 then
            digits |> List.append remaining
        else
            powerOfBase = Num.powInt base exponent
            digit = remaining // powerOfBase
            List.append digits digit
            |> help (Num.rem remaining powerOfBase) (exponent - 1)

    leadingExponent = intLog number base
    help [] number leadingExponent

# Right now the builtins only have natural log so we have to implement this behaviour ourselves. https://github.com/roc-lang/roc/issues/5107
intLog : U64, U64 -> U64
intLog = \number, base ->
    help = \remaining, exponent ->
        if remaining < base then
            exponent
        else
            help (remaining // base) (exponent + 1)
    help number 0
