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

get_user : UserId -> Result User [UserNotFound UserId]
get_user = |user_id|
    users |> Dict.get(user_id) |> Result.map_err(|KeyNotFound| UserNotFound(user_id))

parse_user_id : Str -> Result UserId [InvalidUserId Str]
parse_user_id = |path|
    user_id_str = path |> Str.replace_first("/users/", "")
    user_id_str |> Str.to_u64 |> Result.map_err(|InvalidNumStr| InvalidUserId(user_id_str))

parse_path : Str -> Result Str [InvalidDomain Str, InsecureConnection Str]
parse_path = |url|
    prefix = "https://example.com"
    if url |> Str.starts_with(prefix) then
        url |> Str.replace_first(prefix, "") |> Ok
    else if url |> Str.starts_with("https://") then
        Err(InvalidDomain(url))
    else
        Err(InsecureConnection(url))

get_page : Str -> Result Str [InsecureConnection Str, InvalidDomain Str, InvalidUserId Str, UserNotFound UserId, PageNotFound Str]
get_page = |url|
    when parse_path(url)? is
        "/" -> Ok("Home page")
        "/users/" -> Ok("Users page")
        user_path if user_path |> Str.starts_with("/users/") ->
            user_id = parse_user_id(user_path)?
            user = get_user(user_id)?
            Ok("${user.name}'s page")

        unknown_path -> Err(PageNotFound(unknown_path))

error_message : [InsecureConnection Str, InvalidDomain Str, InvalidUserId Str, UserNotFound UserId, PageNotFound Str], [English, French] -> Str
error_message = |err, language|
    when language is
        English ->
            when err is
                InsecureConnection(url) -> "Insecure connection (non HTTPS): ${url}"
                InvalidDomain(url) -> "Invalid domain name: ${url}"
                InvalidUserId(user_id_str) -> "User ID is not a positive integer: ${user_id_str}"
                UserNotFound(user_id) -> "User #${user_id |> Num.to_str} was not found"
                PageNotFound(path) -> "Page not found: ${path}"

        French ->
            when err is
                InsecureConnection(url) -> "Connexion non sécurisée (non HTTPS): ${url}"
                InvalidDomain(url) -> "Ce nom de domaine est incorrect: ${url}"
                InvalidUserId(user_id_str) -> "Cet identifiant utilisateur devrait être un entier positif: ${user_id_str}"
                UserNotFound(user_id) -> "L'utilisateur #${user_id |> Num.to_str} est inconnu"
                PageNotFound(path) -> "Cette page est inconnue: ${path}"
