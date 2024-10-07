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
        nextPrime = \{ primes, index } ->
            nextIndex = index + 2
            if primes |> List.any \p -> nextIndex % p == 0 then
                nextPrime { primes, index: nextIndex }
            else
                nextIndex
        List.range { start: At 3, end: At number }
        |> List.walk { primes: [2, 3], index: 3 } \state, _ ->
            newPrime = nextPrime state
            { primes: state.primes |> List.append newPrime, index: newPrime }
        |> .index
        |> Ok
