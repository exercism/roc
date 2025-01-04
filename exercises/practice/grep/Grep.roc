module [grep]

import "iliad.txt" as iliad : Str
import "midsummer-night.txt" as midsummer_night : Str
import "paradise-lost.txt" as paradise_lost : Str

grep : Str, List Str, List Str -> Result Str _
grep = \pattern, flags, files ->
    crash "Please implement 'grep'"
