module [findChain]

Domino : (U8, U8)

findChain : List Domino -> Result (List Domino) [NoChainExists]
findChain = \dominoes ->
    help = \used, available ->
        when available is
            [] ->
                when used is
                    [] -> Ok []
                    [single] ->
                        if single.0 == single.1 then Ok used else Err NoChainExists

                    [first, .., last] -> if first.0 == last.1 then Ok used else Err NoChainExists

            [firstAvailable, .. as restAvailable] ->
                when used is
                    [] -> help [firstAvailable] restAvailable
                    [.., lastUsed] ->
                        available
                        |> List.walkWithIndexUntil (Err NoChainExists) \_, domino, index ->
                            maybeChain =
                                if lastUsed.1 == domino.0 then
                                    help (used |> List.append domino) (available |> List.dropAt index)
                                else if lastUsed.1 == domino.1 then
                                    help (used |> List.append (domino.1, domino.0)) (available |> List.dropAt index)
                                else
                                    Err NoChainExists
                            when maybeChain is
                                Ok chain -> Break (Ok chain)
                                Err NoChainExists -> Continue (Err NoChainExists)
    help [] dominoes
