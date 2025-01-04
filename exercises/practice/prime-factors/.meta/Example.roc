module [prime_factors]

prime_factors : U64 -> List U64
prime_factors = \value ->
    find_prime_factors = \factors, n, p ->
        if n < 2 then
            factors
        else if n |> Num.isMultipleOf p then
            find_prime_factors (List.append factors p) (n // p) p
        else if p * p < n then
            next_p = if p == 2 then 3 else p + 2
            find_prime_factors factors n next_p
        else
            List.append factors n

    find_prime_factors [] value 2
