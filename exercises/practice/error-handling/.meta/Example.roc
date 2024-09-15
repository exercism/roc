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

getUser : UserId -> Result User [UserNotFound UserId]
getUser = \userId ->
    users |> Dict.get userId |> Result.mapErr \KeyNotFound -> UserNotFound userId

parseUserId : Str -> Result UserId [InvalidUserId Str]
parseUserId = \path ->
    userIdStr = path |> Str.replaceFirst "/users/" ""
    userIdStr |> Str.toU64 |> Result.mapErr \InvalidNumStr -> InvalidUserId userIdStr

parsePath : Str -> Result Str [InvalidDomain Str, InsecureConnection Str]
parsePath = \url ->
    prefix = "https://example.com"
    if url |> Str.startsWith prefix then
        url |> Str.replaceFirst prefix "" |> Ok
    else if url |> Str.startsWith "https://" then
        Err (InvalidDomain url)
    else
        Err (InsecureConnection url)

getPage : Str -> Result Str [InsecureConnection Str, InvalidDomain Str, InvalidUserId Str, UserNotFound UserId, PageNotFound Str]
getPage = \url ->
    when parsePath? url is
        "/" -> Ok "Home page"
        "/users/" -> Ok "Users page"
        userPath if userPath |> Str.startsWith "/users/" ->
            userId = parseUserId? userPath
            user = getUser? userId
            Ok "$(user.name)'s page"

        unknownPath -> Err (PageNotFound unknownPath)

errorMessage : [InsecureConnection Str, InvalidDomain Str, InvalidUserId Str, UserNotFound UserId, PageNotFound Str], [English, French] -> Str
errorMessage = \err, language ->
    when language is
        English ->
            when err is
                InsecureConnection url -> "Insecure connection (non HTTPS): $(url)"
                InvalidDomain url -> "Invalid domain name: $(url)"
                InvalidUserId userIdStr -> "User ID is not a positive integer: $(userIdStr)"
                UserNotFound userId -> "User #$(userId |> Num.toStr) was not found"
                PageNotFound path -> "Page not found: $(path)"

        French ->
            when err is
                InsecureConnection url -> "Connexion non sécurisée (non HTTPS): $(url)"
                InvalidDomain url -> "Ce nom de domaine est incorrect: $(url)"
                InvalidUserId userIdStr -> "Cet identifiant utilisateur devrait être un entier positif: $(userIdStr)"
                UserNotFound userId -> "L'utilisateur #$(userId |> Num.toStr) est inconnu"
                PageNotFound path -> "Cette page est inconnue: $(path)"
