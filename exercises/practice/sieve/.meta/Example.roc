module [primes]

primes : U64 -> List U64
primes = \limit ->
    if limit < 2 then
        []
        else

    help = \candidates, foundPrimes ->
        when candidates is
            [] -> foundPrimes
            [0, .. as rest] -> rest |> help foundPrimes
            [prime, .. as rest] ->
                List.range { start: After prime, end: At limit, step: prime }
                |> List.walk rest \filteredCandidates, multipleOfPrime ->
                    filteredCandidates |> List.replace (multipleOfPrime - prime - 1) 0 |> .list
                |> help (foundPrimes |> List.append prime)
    help (List.range { start: At 2, end: At limit }) []
