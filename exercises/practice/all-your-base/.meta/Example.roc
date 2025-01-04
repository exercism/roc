module [rebase]

rebase : { input_base : U64, output_base : U64, digits : List U64 } -> Result (List U64) _
rebase = \{ input_base, output_base, digits } ->
    if input_base <= 1 then
        Err InputBaseMustBeGreaterThanOne
    else if output_base <= 1 then
        Err OutputBaseMustBeGreaterThanOne
    else if List.any digits \digit -> digit >= input_base then
        Err DigitsMustBeLessThanInputBase
    else
        number_in_base_10 =
            List.reverse digits
            |> List.mapWithIndex \digit, index ->
                digit * (Num.powInt input_base index)
            |> List.sum

        to_digits number_in_base_10 output_base |> Ok

to_digits : U64, U64 -> List U64
to_digits = \number, base ->
    help = \digits, remaining, exponent ->
        if exponent == 0 then
            digits |> List.append remaining
        else
            power_of_base = Num.powInt base exponent
            digit = remaining // power_of_base
            List.append digits digit
            |> help (Num.rem remaining power_of_base) (exponent - 1)

    leading_exponent = int_log number base
    help [] number leading_exponent

# Right now the builtins only have natural log so we have to implement this behaviour ourselves. https://github.com/roc-lang/roc/issues/5107
int_log : U64, U64 -> U64
int_log = \number, base ->
    help = \remaining, exponent ->
        if remaining < base then
            exponent
        else
            help (remaining // base) (exponent + 1)
    help number 0