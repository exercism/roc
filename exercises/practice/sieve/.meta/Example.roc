module [primes]

primes : U64 -> List U64
primes = \limit ->
    if limit < 2 then
        []
        else

    help_sieve = \candidates, found_primes ->
        when candidates is
            [] -> found_primes
            [0, .. as rest] -> rest |> help_sieve found_primes
            [prime, .. as rest] ->
                List.range { start: After prime, end: At limit, step: prime }
                |> List.walk rest \filtered_candidates, multiple_of_prime ->
                    filtered_candidates |> List.replace (multiple_of_prime - prime - 1) 0 |> .list
                |> help_sieve (found_primes |> List.append prime)
    help_sieve (List.range { start: At 2, end: At limit }) []
