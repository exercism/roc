module [countWords]

countWords : Str -> Dict Str U64
countWords = \sentence ->
    sentence
    |> Str.toUtf8
    |> List.append ' ' # to ensure the last word is added
    |> List.walk { words: [], word: [], contractionStarted: Bool.false } \state, char ->
        { words, word, contractionStarted } = state
        when char is
            c if c >= 'A' && c <= 'Z' ->
                { words, word: word |> List.append (c - 'A' + 'a'), contractionStarted: Bool.false }

            c if c >= 'a' && c <= 'z' || c >= '0' && c <= '9' ->
                { words, word: word |> List.append c, contractionStarted: Bool.false }

            c ->
                if List.isEmpty word then
                    state
                else if c != '\'' || contractionStarted then
                    if contractionStarted then
                        { words: words |> List.append (word |> List.dropLast 1), word: [], contractionStarted: Bool.false }
                    else
                        { words: words |> List.append word, word: [], contractionStarted: Bool.false }
                    else

                { words, word: word |> List.append c, contractionStarted: Bool.true }
    |> .words
    |> List.dropIf List.isEmpty
    |> List.walk (Dict.empty {}) \result, chars ->
        word =
            when chars |> Str.fromUtf8 is
                Ok parsedWord -> parsedWord
                Err (BadUtf8 _ _) -> crash "Unreachable: we only use ASCII characters"
        result
        |> Dict.update word \maybeCount ->
            when maybeCount is
                Ok count -> Ok (count + 1)
                Err Missing -> Ok 1
