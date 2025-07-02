module [annotate]

is_flower : List (List U8), I64, I64 -> Result Bool [OutOfBounds]
is_flower = |rows, nx, ny|
    x = Num.to_u64_checked(nx)?
    y = Num.to_u64_checked(ny)?
    rows
    |> List.get(y)?
    |> List.get(x)?
    |> Bool.is_eq('*')
    |> Ok

count_neighbors : List (List U8), U64, U64 -> Num *
count_neighbors = |rows, x, y|
    [-1, 0, 1]
    |> List.map(
        |dy|
            [-1, 0, 1]
            |> List.map(
                |dx|
                    when is_flower(rows, (Num.to_i64(x) + dx), (Num.to_i64(y) + dy)) is
                        Ok(flower) -> if flower then 1 else 0
                        Err(OutOfBounds) -> 0,
            )
            |> List.sum,
    )
    |> List.sum

annotate : Str -> Str
annotate = |garden|
    rows = garden |> Str.to_utf8 |> List.split_on('\n')
    annotated =
        rows
        |> List.map_with_index(
            |row, y|
                row
                |> List.map_with_index(
                    |cell, x|
                        if cell == '*' then
                            '*'
                        else
                            when count_neighbors(rows, x, y) is
                                0 -> ' '
                                n -> '0' + n,
                )
                |> Str.from_utf8,
        )

    annotated
    |> List.map(
        |maybe_row|
            when maybe_row is
                Ok(row) -> row
                Err(_) -> crash("Unreachable"),
    ) # fromUtf8 cannot fail in the code above
    |> Str.join_with("\n")
