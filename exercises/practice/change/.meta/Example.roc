module [findFewestCoins]

findFewestCoins : List U64, U64 -> Result (List U64) [NotFound]
findFewestCoins = \coins, target ->
    help = \sortedCoins, subTarget, maxLength ->
        if subTarget == 0 then
            Ok []
        else if maxLength == 0 then
            Err NotFound
            else

        when sortedCoins is
            [] -> Err NotFound
            [largestCoin, .. as otherCoins] ->
                if largestCoin == subTarget then
                    Ok [largestCoin]
                else if largestCoin < subTarget then
                    when help sortedCoins (subTarget - largestCoin) (maxLength - 1) is
                        Ok otherCoinsWith ->
                            coinsWith = otherCoinsWith |> List.append largestCoin
                            when help otherCoins subTarget (List.len coinsWith - 1) is
                                Ok coinsWithout -> Ok coinsWithout
                                Err NotFound -> Ok coinsWith

                        Err NotFound -> help otherCoins subTarget maxLength
                else
                    help otherCoins subTarget maxLength

    help? (coins |> List.sortDesc) target Num.maxU64
        |> List.sortAsc
        |> Ok

