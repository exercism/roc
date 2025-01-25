module [find_chain]

Domino : (U8, U8)

find_chain : List Domino -> Result (List Domino) [NoChainExists]
find_chain = |dominoes|
    find_chain_helper = |used, available|
        when available is
            [] ->
                when used is
                    [] -> Ok([])
                    [single] ->
                        if single.0 == single.1 then Ok(used) else Err(NoChainExists)

                    [first, .., last] -> if first.0 == last.1 then Ok(used) else Err(NoChainExists)

            [first_available, .. as rest_available] ->
                when used is
                    [] -> find_chain_helper([first_available], rest_available)
                    [.., last_used] ->
                        available
                        |> List.walk_with_index_until(
                            Err(NoChainExists),
                            |_, domino, index|
                                maybe_chain =
                                    if last_used.1 == domino.0 then
                                        find_chain_helper((used |> List.append(domino)), (available |> List.drop_at(index)))
                                    else if last_used.1 == domino.1 then
                                        find_chain_helper((used |> List.append((domino.1, domino.0))), (available |> List.drop_at(index)))
                                    else
                                        Err(NoChainExists)
                                when maybe_chain is
                                    Ok(chain) -> Break(Ok(chain))
                                    Err(NoChainExists) -> Continue(Err(NoChainExists)),
                        )
    find_chain_helper([], dominoes)
