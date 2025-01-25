module [saddle_points]

Forest : List (List U8)
Position : { row : U64, column : U64 }

saddle_points : Forest -> Set Position
saddle_points = |tree_heights|
    tallest_trees_east_west =
        tree_heights
        |> List.map_with_index(
            |row, row_index|
                max_in_row = row |> List.max |> Result.with_default(0)
                row
                |> List.map_with_index(
                    |height, column_index|
                        if height == max_in_row then [{ row: row_index + 1, column: column_index + 1 }] else [],
                )
                |> List.join,
        )
        |> List.join
        |> Set.from_list

    num_columns = tree_heights |> List.map(List.len) |> List.max |> Result.with_default(0)
    smallest_trees_north_south =
        List.range({ start: At(0), end: Before(num_columns) })
        |> List.map(
            |column_index|
                column =
                    tree_heights
                    |> List.map_with_index(
                        |row, row_index|
                            row
                            |> List.get(column_index)?
                            |> |height| Ok({ height, row_index }),
                    )
                    |> List.keep_oks(|id| id)

                min_in_column = column |> List.map(.height) |> List.min |> Result.with_default(0)
                column
                |> List.keep_if(|{ height }| height == min_in_column)
                |> List.map(|{ row_index }| { row: row_index + 1, column: column_index + 1 }),
        )
        |> List.join_map(|id| id)
        |> Set.from_list

    tallest_trees_east_west |> Set.intersection(smallest_trees_north_south)
