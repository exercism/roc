module [getUser, parseUserId, getPage, errorMessage]

User : { name : Str }

users : Dict U64 User
users =
    Dict.fromList [
        (123, { name: "Alice" }),
        (456, { name: "Bob" }),
        (789, { name: "Charlie" }),
    ]

getUser : U64 -> Result User [UserNotFound Str]
getUser = \userId ->
    crash "Please implement the 'getUser' function"

parseUserId : Str -> Result U64 [InvalidUserId Str]
parseUserId = \path ->
    crash "Please implement the 'parseUserId' function"

getPage : Str -> Result Str _
getPage = \url ->
    crash "Please implement the 'getPage' function"

errorMessage : _, [English] -> Str
errorMessage = \err, language ->
    crash "Please implement the 'errorMessage' function"
