module [get, post]

import json.Json

User : {
    name : Str,
    owes : Dict Str Dec,
    owedBy : Dict Str Dec,
    balance : Dec,
}

Database : { users : List User }

get : Database, { url : Str, payload ? Str } -> Result Str _
get = \database, { url, payload ? "" } ->
    crash "Please implement the 'get' function"

post : Database, { url : Str, payload ? Str } -> Result Str _
post = \database, { url, payload ? "" } ->
    crash "Please implement the 'post' function"
