module [find_fewest_coins]

find_fewest_coins : List U64, U64 -> Result (List U64) [NotFound]
find_fewest_coins = |coins, target|
    help = |sorted_coins, sub_target, max_length|
        if sub_target == 0 then
            Ok([])
        else if max_length == 0 then
            Err(NotFound)
        else
            when sorted_coins is
                [] -> Err(NotFound)
                [largest_coin, .. as other_coins] ->
                    if largest_coin == sub_target then
                        Ok([largest_coin])
                    else if largest_coin < sub_target then
                        when help(sorted_coins, (sub_target - largest_coin), (max_length - 1)) is
                            Ok(other_coins_with) ->
                                coins_with = other_coins_with |> List.append(largest_coin)
                                when help(other_coins, sub_target, (List.len(coins_with) - 1)) is
                                    Ok(coins_without) -> Ok(coins_without)
                                    Err(NotFound) -> Ok(coins_with)

                            Err(NotFound) -> help(other_coins, sub_target, max_length)
                    else
                        help(other_coins, sub_target, max_length)

    help((coins |> List.sort_desc), target, Num.max_u64)?
    |> List.sort_asc
    |> Ok
