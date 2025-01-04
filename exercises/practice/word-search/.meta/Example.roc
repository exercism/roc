module [search]

Position : { column : U64, row : U64 }
WordLocation : { start : Position, end : Position }

## Pad each row with spaces to ensure all rows have the same width
pad_right : List (List U8) -> { rows : List (List U8), width : U64 }
pad_right = \grid ->
    width = grid |> List.map List.len |> List.max |> Result.withDefault 0
    pad_spaces = \chars -> List.repeat ' ' (width - List.len chars)
    {
        rows: grid |> List.map \chars -> chars |> List.concat (pad_spaces chars),
        width,
    }

get_char : List (List U8), U64, U64 -> U8
get_char = \grid, column_index, row_index ->
    grid
    |> List.get row_index
    |> Result.withDefault []
    |> List.get column_index
    |> Result.withDefault ' '

search : Str, List Str -> Dict Str WordLocation
search = \grid, words_to_search_for ->
    { rows, width } = grid |> Str.toUtf8 |> List.splitOn '\n' |> pad_right
    height = List.len rows
    height_i64 = height |> Num.toI64
    width_i64 = width |> Num.toI64
    max_length = Num.max width height |> Num.toI64
    # for all possible starting positions:
    List.range { start: At 0, end: Before width }
    |> List.joinMap \column_index ->
        List.range { start: At 0, end: Before height }
        |> List.joinMap \row_index ->
            # for all possible directions:
            [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
            |> List.joinMap \(dir_column, dir_row) ->
                start = { column: column_index + 1, row: row_index + 1 }
                # for all possible lengths:
                List.range { start: At 0, end: Before max_length } # for all possible words starting at the given position and
                # going in the given direction, take note of the start and end
                # positions
                |> List.walkUntil { found_words: [], chars: [] } \state, index ->
                    end_column_index = Num.toI64 column_index + dir_column * index
                    end_row_index = Num.toI64 row_index + dir_row * index
                    if end_column_index < 0 || end_column_index >= width_i64 || end_row_index < 0 || end_row_index >= height_i64 then
                        Break state
                        else

                    end_column_index_u64 = end_column_index |> Num.toU64
                    end_row_index_u64 = end_row_index |> Num.toU64
                    char = rows |> get_char end_column_index_u64 end_row_index_u64
                    new_chars = state.chars |> List.append char
                    end = { column: end_column_index_u64 + 1, row: end_row_index_u64 + 1 }
                    maybe_word = words_to_search_for |> List.findFirst \word -> word |> Str.toUtf8 == new_chars
                    new_found_words =
                        when maybe_word is
                            Ok word -> state.found_words |> List.append (word, { start, end })
                            Err NotFound -> state.found_words
                    Continue { found_words: new_found_words, chars: new_chars }
                |> .found_words
    |> Dict.fromList