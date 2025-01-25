module [distance]

distance : Str, Str -> Result (Num *) [StrandArgsWereNotOfEqualLength Str Str]
distance = |strand1, strand2|
    nucleotides1 = strand1 |> Str.to_utf8
    nucleotides2 = strand2 |> Str.to_utf8
    if List.len(nucleotides1) == List.len(nucleotides2) then
        List.map2(
            nucleotides1,
            nucleotides2,
            |n1, n2|
                if n1 == n2 then 0 else 1,
        )
        |> List.sum
        |> Ok
    else
        Err(StrandArgsWereNotOfEqualLength(strand1, strand2))
