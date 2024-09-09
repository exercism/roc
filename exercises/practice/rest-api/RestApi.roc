module [get, post]

import json.Json

User : {
    name : Str,
    owes : Dict Str F64,
    owedBy : Dict Str F64,
    balance : F64,
}

Database : { users : List User }

get : Database, { url : Str, payload ? Str } -> Result Str _
get = \database, { url, payload ? "" } ->
    crash "Please implement the 'get' function"

post : Database, { url : Str, payload ? Str } -> Result Str _
post = \database, { url, payload ? "" } ->
    crash "Please implement the 'post' function"
