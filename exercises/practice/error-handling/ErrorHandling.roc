module [get_user, parse_user_id, get_page, error_message]

User : { name : Str }
UserId : U64

users : Dict UserId User
users =
    Dict.from_list(
        [
            (123, { name: "Alice" }),
            (456, { name: "Bob" }),
            (789, { name: "Charlie" }),
        ],
    )

get_user : UserId -> Result User [UserNotFound Str]
get_user = |user_id|
    crash("Please implement the 'get_user' function")

parse_user_id : Str -> Result UserId [InvalidUserId Str]
parse_user_id = |path|
    crash("Please implement the 'parse_user_id' function")

get_page : Str -> Result Str _
get_page = |url|
    crash("Please implement the 'get_page' function")

error_message : _, [English] -> Str
error_message = |err, language|
    crash("Please implement the 'error_message' function")
