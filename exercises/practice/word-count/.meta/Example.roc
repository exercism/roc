module [count_words]

count_words : Str -> Dict Str U64
count_words = \sentence ->
    sentence
    |> Str.toUtf8
    |> List.append ' ' # to ensure the last word is added
    |> List.walk { words: [], word: [], contraction_started: Bool.false } \state, char ->
        { words, word, contraction_started } = state
        when char is
            c if c >= 'A' && c <= 'Z' ->
                { words, word: word |> List.append (c - 'A' + 'a'), contraction_started: Bool.false }

            c if c >= 'a' && c <= 'z' || c >= '0' && c <= '9' ->
                { words, word: word |> List.append c, contraction_started: Bool.false }

            c ->
                if List.isEmpty word then
                    state
                else if c != '\'' || contraction_started then
                    if contraction_started then
                        { words: words |> List.append (word |> List.dropLast 1), word: [], contraction_started: Bool.false }
                    else
                        { words: words |> List.append word, word: [], contraction_started: Bool.false }
                    else

                { words, word: word |> List.append c, contraction_started: Bool.true }
    |> .words
    |> List.dropIf List.isEmpty
    |> List.walk (Dict.empty {}) \result, chars ->
        word =
            when chars |> Str.fromUtf8 is
                Ok parsed_word -> parsed_word
                Err (BadUtf8 _ _) -> crash "Unreachable: we only use ASCII characters"
        result
        |> Dict.update word \maybe_count ->
            when maybe_count is
                Ok count -> Ok (count + 1)
                Err Missing -> Ok 1