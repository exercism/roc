module [reverse, reverseAscii]

import unicode.Grapheme

## This function reverses the input string, e.g., "café" -> "éfac".
## This implementation uses the `unicode` package from github.com/roc-lang/unicode
## to split the input string into separate "Extended Grapheme Clusters". This is a
## fancy Unicode name for characters that human beings recognize as such: each EGC
## may actually be composed of several Unicode codepoints, e.g., the character
## é is recognized as a single character, but it may actually be represented as two
## Unicode codepoints (e + ´).
## To use the `unicode` package, its URL must be added to the app's header.
## Luckily, we've added it for you in reverse-string-test.roc. Take a look!
reverse = \string ->
    if string == "" then
        ""
    else
        graphemes = string |> Grapheme.split
        when graphemes is
            Ok gs -> gs |> List.reverse |> Str.joinWith ""
            Err _ -> "Unexpected error: could not split the string into graphemes"

## This function reverses the input string, e.g., "hello" -> "olleh". It is
## faster and simpler than the implementation above, plus it does not require an
## external package, but it is only guaranteed to work on ASCII strings.
reverseAscii = \string ->
    when string |> Str.toUtf8 |> List.reverse |> Str.fromUtf8 is
        Ok reversed -> reversed
        Err _ -> "This implementation online works on ASCII strings"
