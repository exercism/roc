module [get, post]

import json.Json

User : {
    name : Str,
    owes : Dict Str Dec,
    owedBy : Dict Str Dec,
    balance : Dec,
}

Database : { users : List User }

Loan : { lender : Str, borrower : Str, amount : Dec }

get : Database, { url : Str, payload ? Str } -> Result Str _
get = \database, { url, payload ? "" } ->
    when url is
        "/users" -> database |> getUsers payload
        _ -> Err (Http404 url)

compareStrings : Str, Str -> [LT, EQ, GT]
compareStrings = \string1, string2 ->
    b1 = string1 |> Str.toUtf8
    b2 = string2 |> Str.toUtf8
    result =
        List.map2 b1 b2 \c1, c2 -> Num.compare c1 c2
        |> List.walkTry (Ok EQ) \_, cmp ->
            when cmp is
                EQ -> Ok EQ
                res -> Err res
    when result is
        Ok _ -> Num.compare (List.len b1) (List.len b2)
        Err res -> res

usersToJson : List User -> Result Str _
usersToJson = \users ->
    sortedUsers = users |> List.sortWith \u1, u2 -> compareStrings u1.name u2.name
    Encode.toBytes { users: sortedUsers } Json.utf8 |> Str.fromUtf8

getUsers : Database, Str -> Result Str _
getUsers = \database, payload ->
    requestedUsers =
        if payload == "" then
            database.users
        else
            names =
                if payload |> Str.contains "\"user\"" then
                    [parseJsonUser? payload]
                else
                    parseJsonUsers? payload

            database.users |> List.keepIf \user -> names |> List.contains user.name

    requestedUsers |> usersToJson

parseJsonUser = \payload ->
    bytes = payload |> Str.toUtf8
    maybeUser : Decode.DecodeResult { user : Str }
    maybeUser = Decode.fromBytesPartial bytes Json.utf8
    maybeUser.result

parseJsonUsers = \payload ->
    bytes = payload |> Str.toUtf8
    maybeUserList : Decode.DecodeResult { users : List Str }
    maybeUserList = Decode.fromBytesPartial bytes Json.utf8
    maybeUserList.result

parseJsonLoan = \payload ->
    bytes = payload |> Str.toUtf8
    maybeLoan : Decode.DecodeResult Loan
    maybeLoan = Decode.fromBytesPartial bytes Json.utf8
    maybeLoan.result

post : Database, { url : Str, payload ? Str } -> Result Str _
post = \database, { url, payload ? "" } ->
    when url is
        "/add" -> database |> addUser payload
        "/iou" -> database |> addLoad payload
        _ -> Err (Http404 url)

addUser : Database, Str -> Result Str _
addUser = \database, payload ->
    userPayload = parseJsonUser? payload
    newUser = {
        name: userPayload.user,
        owes: Dict.empty {},
        owedBy: Dict.empty {},
        balance: 0.0,
    }
    Encode.toBytes newUser Json.utf8 |> Str.fromUtf8

popAmount : Dict a b, a -> (Dict a b, b)
popAmount = \dict, key ->
    when dict |> Dict.get key is
        Ok value ->
            newDict = dict |> Dict.remove key
            (newDict, value)

        Err KeyNotFound -> (dict, 0.0)

updateLender = \lender, borrowerName, amount ->
    (newOwesDict, owesAmount) = lender.owes |> popAmount borrowerName
    (newOwedByDict, owedByAmount) = lender.owedBy |> popAmount borrowerName
    total = owesAmount - owedByAmount + amount
    finalOwesDict =
        if total > 0.0 then
            newOwesDict |> Dict.insert borrowerName total
        else
            newOwesDict
    finalOwesDict =
        if total < 0.0 then
            newOwedByDict |> Dict.insert borrowerName -total
        else
            newOwedByDict
    { lender & owes: finalOwesDict, owedBy: finalOwesDict }

addLoan : Database, Str -> Result Str _
addLoan = \database, payload ->
    loan = parseJsonLoan? payload
    getUser = \name ->
        database |> List.findFirst \user -> user.name == name
    lender = getUser? loan.lender
    borrower = getUser? loan.borrower
    updatedLender = lender |> updateLender borrower.name loan.amount
    updatedBorrower = borrower |> updateLender lender.name -loan.amount
    [updatedLender, updatedBorrower] |> usersToJson
