module [is_paired]

is_paired : Str -> Bool
is_paired = \string ->
    is_open = \c -> c == '[' || c == '(' || c == '{'
    is_close = \c -> c == ']' || c == ')' || c == '}'
    is_match = \pair -> pair == ('[', ']') || pair == ('(', ')') || pair == ('{', '}')
    help = \open_brackets, remaining_chars ->
        when remaining_chars is
            [] -> List.isEmpty open_brackets # ok or missing closing bracket
            [next_char, .. as rest_chars] ->
                if is_open next_char then
                    help (open_brackets |> List.append next_char) rest_chars
                else if is_close next_char then
                    when open_brackets is
                        [] -> Bool.false # missing opening bracket
                        [.. as previous_opens, last_open] ->
                            if is_match (last_open, next_char) then
                                help previous_opens rest_chars
                            else
                                Bool.false # mismatching brackets
                else
                    help open_brackets rest_chars

    help [] (string |> Str.toUtf8)