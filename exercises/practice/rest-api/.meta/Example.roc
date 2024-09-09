module [get, post]

import json.Json

User : {
    name : Str,
    owes : Dict Str F64,
    owedBy : Dict Str F64,
    balance : F64,
}

Database : { users : List User }

Loan : { lender : Str, borrower : Str, amount : F64 }

## Handle GET requests
get : Database, { url : Str, payload ? Str } -> Result Str [Http404 Str, Http422 Str]
get = \database, { url, payload ? "" } ->
    when url is
        "/users" ->
            database
            |> getUsers payload
            |> Result.mapErr \err ->
                when err is
                    InvalidJson -> Http422 payload

        badUrl -> Err (Http404 badUrl)

## Compare two strings, first by their UTF8 representations, then by length:
## "" < "ABC" < "abc" < "abcdef"
## This is used to sort the users in the JSON outputs
compareStrings : Str, Str -> [LT, EQ, GT]
compareStrings = \string1, string2 ->
    b1 = string1 |> Str.toUtf8
    b2 = string2 |> Str.toUtf8
    result =
        List.map2 b1 b2 \c1, c2 -> Num.compare c1 c2
        |> List.walkTry (Ok EQ) \_state, cmp ->
            when cmp is
                EQ -> Ok EQ
                res -> Err res
    when result is
        Ok _cmp -> Num.compare (List.len b1) (List.len b2)
        Err res -> res

## Convert the owes and owedBy dictionaries to JSON
## Note: this will be simpler once Roc supports Encoding & Decoding Dict
oweDictToJson : Dict Str F64 -> Str
oweDictToJson = \dict ->
    dictContent =
        dict
        |> Dict.toList
        |> List.sortWith \(name1, _amount1), (name2, _amount2) -> compareStrings name1 name2
        |> List.map \(name, amount) -> "$(name |> stringToJson): $(amount |> Num.toStr)"
        |> Str.joinWith ","
    "{$(dictContent)}"

stringToJson : Str -> Str
stringToJson = \string ->
    result =
        Encode.toBytes string Json.utf8
        |> Str.fromUtf8
    when result is
        Ok json -> json
        Err (BadUtf8 _ _) -> crash "Unreachable: encoding a string to JSON should never fail"

## Convert a user to a JSON representation
## Note: this will be simpler once Roc supports Encoding & Decoding Dict
userToJson : User -> Str
userToJson = \user ->
    """
    {
        \"balance\" : $(user.balance |> Num.toStr),
        \"name\" : $(user.name |> stringToJson),
        \"owed_by\" : $(user.owedBy |> oweDictToJson),
        \"owes\" : $(user.owes |> oweDictToJson)
    }
    """

## Convert a list of users to a JSON representation
## Note: this will be simpler once Roc supports Encoding & Decoding Dict
usersToJson : List User -> Str
usersToJson = \users ->
    sortedUsers = users |> List.sortWith \u1, u2 -> compareStrings u1.name u2.name
    # Encode.toBytes { users: sortedUsers } Json.utf8 |> Str.fromUtf8
    listContent =
        sortedUsers
        |> List.map \user -> userToJson user
        |> Str.joinWith ",\n"
    "{\"users\": [$(listContent)]}"

## Parse the requested user name or list of user names, and load them from
## the (mock) database
getUsers : Database, Str -> Result Str [InvalidJson]
getUsers = \database, payload ->
    if payload == "" then
        database.users |> usersToJson |> Ok
    else
        names = getUserNames? payload
        database.users
        |> List.keepIf \user ->
            names |> List.contains user.name
        |> usersToJson
        |> Ok

## Parse the requested user names from JSON
getUserNames : Str -> Result (List Str) [InvalidJson]
getUserNames = \payload ->
    when parseJsonUser payload is
        Ok userRecord -> Ok [userRecord.user]
        Err InvalidJson ->
            usersRecord = parseJsonUsers? payload
            Ok usersRecord.users

## Parse a JSON { user: name } object
parseJsonUser : Str -> Result { user : Str } [InvalidJson]
parseJsonUser = \payload ->
    bytes = payload |> Str.toUtf8
    maybeUser = Decode.fromBytesPartial bytes Json.utf8
    maybeUser.result |> Result.mapErr \_ -> InvalidJson

## Parse a JSON { users: [name1, name2,...] } object
parseJsonUsers : Str -> Result { users : List Str } [InvalidJson]
parseJsonUsers = \payload ->
    bytes = payload |> Str.toUtf8
    maybeUserList : Decode.DecodeResult { users : List Str }
    maybeUserList = Decode.fromBytesPartial bytes Json.utf8
    maybeUserList.result |> Result.mapErr \_ -> InvalidJson

## Parse a JSON Loan object
parseJsonLoan : Str -> Result Loan [InvalidJson]
parseJsonLoan = \payload ->
    bytes = payload |> Str.toUtf8
    maybeLoan : Decode.DecodeResult Loan
    maybeLoan = Decode.fromBytesPartial bytes Json.utf8
    maybeLoan.result |> Result.mapErr \_ -> InvalidJson

## Handle POST requests
post : Database, { url : Str, payload ? Str } -> Result Str [Http404 Str, Http422 Str]
post = \database, { url, payload ? "" } ->
    handleError = \err ->
        when err is
            InvalidJson -> Http422 payload
            NotFound -> Http404 payload
    when url is
        "/add" -> database |> addUser payload |> Result.mapErr handleError
        "/iou" -> database |> addLoan payload |> Result.mapErr handleError
        badUrl -> Err (Http404 badUrl)

## Add a new user to the (mock) database
addUser : Database, Str -> Result Str [InvalidJson]
addUser = \_database, payload ->
    userPayload = parseJsonUser? payload
    newUser = {
        name: userPayload.user,
        owes: Dict.empty {},
        owedBy: Dict.empty {},
        balance: 0.0,
    }
    userToJson newUser |> Ok

## Pop a key/value from a dictionary and return the updated Dict along with
## the popped value. If not found, return the original Dict and value 0.0
popAmount : Dict Str F64, Str -> (Dict Str F64, F64)
popAmount = \dict, key ->
    when dict |> Dict.get key is
        Ok value ->
            newDict = dict |> Dict.remove key
            (newDict, value)

        Err KeyNotFound -> (dict, 0.0)

## Return the updated User record for the lender, assuming they lent the given
## amount to the borrower.
## Note: the amount may be negative, in which case the loan is in the
## other direction, i.e., borrower to lender, but the function still returns
## the updated "lender" record.
updateLender : User, Str, F64 -> User
updateLender = \lender, borrowerName, amount ->
    (newOwesDict, owesAmount) = lender.owes |> popAmount borrowerName
    (newOwedByDict, owedByAmount) = lender.owedBy |> popAmount borrowerName
    totalLenderOwesToBorrower = owesAmount - owedByAmount - amount
    finalOwesDict =
        if totalLenderOwesToBorrower > 0.0 then
            newOwesDict |> Dict.insert borrowerName totalLenderOwesToBorrower
        else
            newOwesDict
    finalOwedByDict =
        if totalLenderOwesToBorrower < 0.0 then
            newOwedByDict |> Dict.insert borrowerName -totalLenderOwesToBorrower
        else
            newOwedByDict
    finalBalance = lender.balance + amount
    { lender & owes: finalOwesDict, owedBy: finalOwedByDict, balance: finalBalance }

## Find a user by name in the (mock) database. Return Err NotFound if not found.
getUser : Database, Str -> Result User [NotFound]
getUser = \database, name ->
    database.users
    |> List.findFirst \user -> user.name == name

## Parse a new loan JSON request and process the loan, returning the
## updated lender and borrower User records.
## If either the lender or the borrower does not exist, the function
## returns Err NotFound. If the JSON payload is invalid, return Err InvalidJson.
addLoan : Database, Str -> Result Str [NotFound, InvalidJson]
addLoan = \database, payload ->
    loan = parseJsonLoan? payload
    lender = database |> getUser? loan.lender
    borrower = database |> getUser? loan.borrower
    updatedLender = lender |> updateLender borrower.name loan.amount
    updatedBorrower = borrower |> updateLender lender.name -loan.amount
    [updatedLender, updatedBorrower] |> usersToJson |> Ok
