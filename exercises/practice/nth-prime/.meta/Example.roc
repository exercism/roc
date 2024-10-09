module [prime]

prime : U64 -> Result U64 [NoPrime0]
prime = \number ->
    if number == 0 then
        Err NoPrime0
    else if number == 1 then
        Ok 2
    else if number == 2 then
        Ok 3
    else
        help = \primes, index ->
            if List.len primes == number then
                primes
            else
                nextIndex = index + 2
                newPrimes =
                    if primes |> List.any \p -> nextIndex % p == 0 then
                        primes
                    else
                        primes |> List.append nextIndex
                help newPrimes nextIndex
        help [2, 3, 5] 5
        |> List.last
        |> Result.mapErr \_ ->
            crash "Unreachable: list cannot be empty"
