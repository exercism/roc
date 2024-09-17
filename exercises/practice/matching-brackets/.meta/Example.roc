module [isPaired]

isPaired : Str -> Bool
isPaired = \string ->
    isOpen = \c -> c == '[' || c == '(' || c == '{'
    isClose = \c -> c == ']' || c == ')' || c == '}'
    isMatch = \pair -> pair == ('[', ']') || pair == ('(', ')') || pair == ('{', '}')
    help = \openBrackets, remainingChars ->
        when remainingChars is
            [] -> List.isEmpty openBrackets # ok or missing closing bracket
            [nextChar, .. as restChars] ->
                if isOpen nextChar then
                    help (openBrackets |> List.append nextChar) restChars
                else if isClose nextChar then
                    when openBrackets is
                        [] -> Bool.false # missing opening bracket
                        [.. as previousOpens, lastOpen] ->
                            if isMatch (lastOpen, nextChar) then
                                help previousOpens restChars
                            else
                                Bool.false # mismatching brackets
                else
                    help openBrackets restChars

    help [] (string |> Str.toUtf8)
