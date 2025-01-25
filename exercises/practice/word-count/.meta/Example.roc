module [count_words]

count_words : Str -> Dict Str U64
count_words = |sentence|
    sentence
    |> Str.to_utf8
    |> List.append(' ') # to ensure the last word is added
    |> List.walk(
        { words: [], word: [], contraction_started: Bool.false },
        |state, char|
            { words, word, contraction_started } = state
            when char is
                c if c >= 'A' and c <= 'Z' ->
                    { words, word: word |> List.append((c - 'A' + 'a')), contraction_started: Bool.false }

                c if c >= 'a' and c <= 'z' or c >= '0' and c <= '9' ->
                    { words, word: word |> List.append(c), contraction_started: Bool.false }

                c ->
                    if List.is_empty(word) then
                        state
                    else if c != '\'' or contraction_started then
                        if contraction_started then
                            { words: words |> List.append((word |> List.drop_last(1))), word: [], contraction_started: Bool.false }
                        else
                            { words: words |> List.append(word), word: [], contraction_started: Bool.false }
                    else
                        { words, word: word |> List.append(c), contraction_started: Bool.true },
    )
    |> .words
    |> List.drop_if(List.is_empty)
    |> List.walk(
        Dict.empty({}),
        |result, chars|
            word =
                when chars |> Str.from_utf8 is
                    Ok(parsed_word) -> parsed_word
                    Err(BadUtf8(_)) -> crash("Unreachable: we only use ASCII characters")
            result
            |> Dict.update(
                word,
                |maybe_count|
                    when maybe_count is
                        Ok(count) -> Ok((count + 1))
                        Err(Missing) -> Ok(1),
            ),
    )
