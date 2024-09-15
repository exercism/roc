module [grep]

import "iliad.txt" as iliad : Str
import "midsummer-night.txt" as midsummerNight : Str
import "paradise-lost.txt" as paradiseLost : Str

grep : Str, List Str, List Str -> Result Str _
grep = \pattern, flags, files ->
    crash "Please implement 'grep'"
