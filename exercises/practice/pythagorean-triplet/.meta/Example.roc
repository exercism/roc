module [tripletsWithSum]

Triplet : (U64, U64, U64)

tripletsWithSum : U64 -> List Triplet
tripletsWithSum = \sum ->
    help = \triplets, a, b ->
        if a + b + b + 1 > sum then
            # c would have to be too small (≤ b)
            if 3 * (a + 1) > sum then
                # we can't increment a so we're done
                triplets
            else
                help triplets (a + 1) (a + 2) # increment a
        else
            c = sum - a - b
            newTriplets =
                if a * a + b * b == c * c then
                    triplets |> List.append (a, b, c) # success!
                else
                    triplets
            help newTriplets a (b + 1) # increment b
    help [] 1 2
