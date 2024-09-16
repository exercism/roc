module [getUser, parseUserId, getPage, errorMessage]

User : { name : Str }
UserId : U64

users : Dict UserId User
users =
    Dict.fromList [
        (123, { name: "Alice" }),
        (456, { name: "Bob" }),
        (789, { name: "Charlie" }),
    ]

getUser : UserId -> Result User [UserNotFound Str]
getUser = \userId ->
    crash "Please implement the 'getUser' function"

parseUserId : Str -> Result UserId [InvalidUserId Str]
parseUserId = \path ->
    crash "Please implement the 'parseUserId' function"

getPage : Str -> Result Str _
getPage = \url ->
    crash "Please implement the 'getPage' function"

errorMessage : _, [English] -> Str
errorMessage = \err, language ->
    crash "Please implement the 'errorMessage' function"
