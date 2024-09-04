module [primeFactors]

primeFactors : U64 -> List U64
primeFactors = \value ->
    findPrimeFactors = \n, p ->
        if n < 2 then
            []
        else if n % p == 0 then
            findPrimeFactors (n // p) p |> List.prepend p
        else if p * p < n then
            nextP = if p == 2 then 3 else p + 2
            findPrimeFactors n nextP
        else
            [n]

    when findPrimeFactors value 2 is
        [] -> if value < 2 then [] else [value]
        result -> result
