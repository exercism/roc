module [squareRoot, squareRootTheSimpleWay]

squareRoot : U64 -> U64
squareRoot = \radicand ->
    binarySearch = \min, max ->
        val = (min + max) // 2
        square = val * val
        if square == radicand || min >= max then
            val
        else if square > radicand then
            binarySearch min (val - 1)
        else
            binarySearch (val + 1) max

    binarySearch 0 radicand

squareRootTheSimpleWay = \radicand ->
    # This works too... but it's cheating, right?
    radicand |> Num.toF64 |> Num.sqrt |> Num.round
