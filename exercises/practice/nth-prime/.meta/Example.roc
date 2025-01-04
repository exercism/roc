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
        find_prime = \primes, index ->
            if List.len primes == number then
                primes
            else
                next_index = index + 2
                new_primes =
                    if primes |> List.any \p -> next_index % p == 0 then
                        primes
                    else
                        primes |> List.append next_index
                find_prime new_primes next_index
        find_prime [2, 3, 5] 5
        |> List.last
        |> Result.mapErr \_ ->
            crash "Unreachable: list cannot be empty"