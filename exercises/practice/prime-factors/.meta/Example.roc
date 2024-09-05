module [primeFactors]

primeFactors : U64 -> List U64
primeFactors = \value ->
    findPrimeFactors = \factors, n, p ->
        if n < 2 then
            factors
        else if n |> Num.isMultipleOf p then
            findPrimeFactors (List.append factors p) (n // p) p
        else if p * p < n then
            nextP = if p == 2 then 3 else p + 2
            findPrimeFactors factors n nextP
        else
            List.append factors n

    findPrimeFactors [] value 2
