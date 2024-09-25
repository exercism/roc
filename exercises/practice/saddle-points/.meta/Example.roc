module [saddlePoints]

Forest : List (List U8)
Position : { row : U64, column : U64 }

saddlePoints : Forest -> Set Position
saddlePoints = \treeHeights ->
    tallestTreesEastWest =
        treeHeights
        |> List.mapWithIndex \row, rowIndex ->
            maxInRow = row |> List.max |> Result.withDefault 0
            row
            |> List.mapWithIndex \height, columnIndex ->
                if height == maxInRow then [{ row: rowIndex + 1, column: columnIndex + 1 }] else []
            |> List.joinMap \id -> id
        |> List.joinMap \id -> id
        |> Set.fromList

    numColumns = treeHeights |> List.map List.len |> List.max |> Result.withDefault 0
    smallestTreeNorthSouth =
        List.range { start: At 0, end: Before numColumns }
            |> List.map \columnIndex ->
                column =
                    treeHeights
                        |> List.mapWithIndex \row, rowIndex ->
                            row
                                |> List.get? columnIndex
                                |> \height -> Ok { height, rowIndex }
                        |> List.keepOks \id -> id

                minInColumn = column |> List.map .height |> List.min |> Result.withDefault 0
                column
                |> List.keepIf \{ height } -> height == minInColumn
                |> List.map \{ rowIndex } -> { row: rowIndex + 1, column: columnIndex + 1 }
            |> List.joinMap \id -> id
            |> Set.fromList

    tallestTreesEastWest |> Set.intersection smallestTreeNorthSouth

