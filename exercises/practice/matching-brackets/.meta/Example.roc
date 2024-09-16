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
                when nextChar is
                    open if isOpen open ->
                        help (openBrackets |> List.append open) restChars

                    close if isClose close ->
                        when openBrackets is
                            [] -> Bool.false # missing opening bracket
                            [.. as restOpen, open] ->
                                if isMatch (open, close) then
                                    help restOpen restChars
                                else
                                    Bool.false # mismatching brackets

                    _otherChar -> help openBrackets restChars

    help [] (string |> Str.toUtf8)
