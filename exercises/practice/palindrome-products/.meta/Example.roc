module [smallest, largest]

smallest : { min : U64, max : U64 } -> Result { value : U64, factors : Set (U64, U64) } [MinWasLargerThanMax]
smallest = |{ min, max }|
    if min > max then
        Err(MinWasLargerThanMax)
    else
        help = |factor1, factor2, best_value, factors|
            if factor1 > max then
                final_value = if factors == [] then 0 else best_value
                Ok({ value: final_value, factors: Set.from_list(factors) })
            else if factor2 == max + 1 then
                help((factor1 + 1), (factor1 + 1), best_value, factors)
            else
                value = factor1 * factor2
                if value > best_value then
                    help((factor1 + 1), (factor1 + 1), best_value, factors)
                else
                    next_factor2 = factor2 + 1
                    if value == best_value then
                        new_factors = factors |> List.append((factor1, factor2))
                        help(factor1, next_factor2, best_value, new_factors)
                    else if value |> is_palindrome then
                        help(factor1, next_factor2, value, [(factor1, factor2)])
                    else
                        help(factor1, next_factor2, best_value, factors)

        help(min, min, Num.max_u64, [])

largest : { min : U64, max : U64 } -> Result { value : U64, factors : Set (U64, U64) } [MinWasLargerThanMax]
largest = |{ min, max }|
    if min > max then
        Err(MinWasLargerThanMax)
    else
        help = |factor1, factor2, best_value, factors|
            if factor1 < min then
                final_value = if factors == [] then 0 else best_value
                Ok({ value: final_value, factors: Set.from_list(factors) })
            else if factor2 < factor1 then
                help((factor1 - 1), max, best_value, factors)
            else
                value = factor1 * factor2
                if value < best_value then
                    help((factor1 - 1), max, best_value, factors)
                else
                    next_factor2 = factor2 - 1
                    if value == best_value then
                        new_factors = factors |> List.append((factor1, factor2))
                        help(factor1, next_factor2, best_value, new_factors)
                    else if value |> is_palindrome then
                        help(factor1, next_factor2, value, [(factor1, factor2)])
                    else
                        help(factor1, next_factor2, best_value, factors)

        help(max, max, 0, [])

is_palindrome : U64 -> Bool
is_palindrome = |number|
    digits = number |> Num.to_str |> Str.to_utf8
    digits == digits |> List.reverse
