module [square_root, square_rootTheSimpleWay]

square_root : U64 -> U64
square_root = |radicand|
    binary_search = |min, max|
        val = (min + max) // 2
        square = val * val
        if square == radicand or min >= max then
            val
        else if square > radicand then
            binary_search(min, (val - 1))
        else
            binary_search((val + 1), max)

    binary_search(0, radicand)

square_rootTheSimpleWay = |radicand|
    # This works too... but it's cheating, right?
    radicand |> Num.to_f64 |> Num.sqrt |> Num.round
