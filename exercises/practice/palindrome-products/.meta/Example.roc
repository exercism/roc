module [smallest, largest]

smallest : { min : U64, max : U64 } -> Result { value : U64, factors : Set (U64, U64) } [MinWasLargerThanMax]
smallest = \{ min, max } ->
    if min > max then
        Err MinWasLargerThanMax
        else

    help = \factor1, factor2, bestValue, factors ->
        if factor1 > max then
            finalValue = if factors == [] then 0 else bestValue
            Ok { value: finalValue, factors: Set.fromList factors }
        else if factor2 == max + 1 then
            help (factor1 + 1) (factor1 + 1) bestValue factors
            else

        value = factor1 * factor2
        if value > bestValue then
            help (factor1 + 1) (factor1 + 1) bestValue factors
        else
            nextFactor2 = factor2 + 1
            if value == bestValue then
                newFactors = factors |> List.append (factor1, factor2)
                help factor1 nextFactor2 bestValue newFactors
            else if value |> isPalindrome then
                help factor1 nextFactor2 value [(factor1, factor2)]
            else
                help factor1 nextFactor2 bestValue factors

    help min min Num.maxU64 []

largest : { min : U64, max : U64 } -> Result { value : U64, factors : Set (U64, U64) } [MinWasLargerThanMax]
largest = \{ min, max } ->
    if min > max then
        Err MinWasLargerThanMax
        else

    help = \factor1, factor2, bestValue, factors ->
        if factor1 < min then
            finalValue = if factors == [] then 0 else bestValue
            Ok { value: finalValue, factors: Set.fromList factors }
        else if factor2 < factor1 then
            help (factor1 - 1) max bestValue factors
            else

        value = factor1 * factor2
        if value < bestValue then
            help (factor1 - 1) max bestValue factors
        else
            nextFactor2 = factor2 - 1
            if value == bestValue then
                newFactors = factors |> List.append (factor1, factor2)
                help factor1 nextFactor2 bestValue newFactors
            else if value |> isPalindrome then
                help factor1 nextFactor2 value [(factor1, factor2)]
            else
                help factor1 nextFactor2 bestValue factors

    help max max 0 []

isPalindrome : U64 -> Bool
isPalindrome = \number ->
    digits = number |> Num.toStr |> Str.toUtf8
    digits == digits |> List.reverse
