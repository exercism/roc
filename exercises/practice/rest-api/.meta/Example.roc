module [get, post]

import json.Json

User : {
    name : Str,
    owes : Dict Str F64,
    owed_by : Dict Str F64,
    balance : F64,
}

Database : { users : List User }

Loan : { lender : Str, borrower : Str, amount : F64 }

get : Database, { url : Str, payload ?? Str } -> Result Str [Http404 Str, Http422 Str]
get = |database, { url, payload ?? "" }|
    when url is
        "/users" ->
            database
            |> get_users(payload)
            |> Result.map_err(|InvalidJson| Http422(payload))

        bad_url -> Err(Http404(bad_url))

compare_strings : Str, Str -> [LT, EQ, GT]
compare_strings = |string1, string2|
    b1 = string1 |> Str.to_utf8
    b2 = string2 |> Str.to_utf8
    result =
        List.map2(b1, b2, |c1, c2| Num.compare(c1, c2))
        |> List.walk_try(
            Ok(EQ),
            |_state, cmp|
                when cmp is
                    EQ -> Ok(EQ)
                    res -> Err(res),
        )
    when result is
        Ok(_cmp) -> Num.compare(List.len(b1), List.len(b2))
        Err(res) -> res

owe_dict_to_json : Dict Str F64 -> Str
owe_dict_to_json = |dict|
    dict_content =
        dict
        |> Dict.to_list
        |> List.sort_with(|(name1, _amount1), (name2, _amount2)| compare_strings(name1, name2))
        |> List.map(|(name, amount)| "${name |> string_to_json}: ${amount |> Num.to_str}")
        |> Str.join_with(",")
    "{${dict_content}}"

string_to_json : Str -> Str
string_to_json = |string|
    result =
        Encode.to_bytes(string, Json.utf8)
        |> Str.from_utf8
    when result is
        Ok(json) -> json
        Err(BadUtf8(_)) -> crash("Unreachable: encoding a string to JSON should never fail")

user_to_json : User -> Str
user_to_json = |user|
    """
    {
        "balance" : ${user.balance |> Num.to_str},
        "name" : ${user.name |> string_to_json},
        "owed_by" : ${user.owed_by |> owe_dict_to_json},
        "owes" : ${user.owes |> owe_dict_to_json}
    }
    """

users_to_json : List User -> Str
users_to_json = |users|
    sorted_users = users |> List.sort_with(|u1, u2| compare_strings(u1.name, u2.name))
    list_content =
        sorted_users
        |> List.map(|user| user_to_json(user))
        |> Str.join_with(",\n")
    "{\"users\": [${list_content}]}"

get_users : Database, Str -> Result Str [InvalidJson]
get_users = |database, payload|
    if payload == "" then
        database.users |> users_to_json |> Ok
    else
        names = get_user_names(payload)?
        database.users
        |> List.keep_if(
            |user|
                names |> List.contains(user.name),
        )
        |> users_to_json
        |> Ok

get_user_names : Str -> Result (List Str) [InvalidJson]
get_user_names = |payload|
    when parse_json_user(payload) is
        Ok(user_record) -> Ok([user_record.user])
        Err(InvalidJson) ->
            users_record = parse_json_users(payload)?
            Ok(users_record.users)

parse_json_user : Str -> Result { user : Str } [InvalidJson]
parse_json_user = |payload|
    bytes = payload |> Str.to_utf8
    maybe_user = Decode.from_bytes_partial(bytes, Json.utf8)
    maybe_user.result |> Result.map_err(|_| InvalidJson)

parse_json_users : Str -> Result { users : List Str } [InvalidJson]
parse_json_users = |payload|
    bytes = payload |> Str.to_utf8
    maybe_user_list = Decode.from_bytes_partial(bytes, Json.utf8)
    maybe_user_list.result |> Result.map_err(|_| InvalidJson)

parse_json_loan : Str -> Result Loan [InvalidJson]
parse_json_loan = |payload|
    bytes = payload |> Str.to_utf8
    maybe_loan = Decode.from_bytes_partial(bytes, Json.utf8)
    maybe_loan.result |> Result.map_err(|_| InvalidJson)

post : Database, { url : Str, payload ?? Str } -> Result Str [Http404 Str, Http422 Str]
post = |database, { url, payload ?? "" }|
    handle_error = |err|
        when err is
            InvalidJson -> Http422(payload)
            NotFound -> Http404(payload)
    when url is
        "/add" -> database |> add_user(payload) |> Result.map_err(handle_error)
        "/iou" -> database |> add_loan(payload) |> Result.map_err(handle_error)
        bad_url -> Err(Http404(bad_url))

add_user : Database, Str -> Result Str [InvalidJson]
add_user = |_database, payload|
    user_payload = parse_json_user(payload)?
    new_user = {
        name: user_payload.user,
        owes: Dict.empty({}),
        owed_by: Dict.empty({}),
        balance: 0.0,
    }
    user_to_json(new_user) |> Ok

pop_amount : Dict Str F64, Str -> (Dict Str F64, F64)
pop_amount = |dict, key|
    when dict |> Dict.get(key) is
        Ok(value) ->
            new_dict = dict |> Dict.remove(key)
            (new_dict, value)

        Err(KeyNotFound) -> (dict, 0.0)

update_lender : User, Str, F64 -> User
update_lender = |lender, borrower_name, amount|
    (new_owes_dict, owes_amount) = lender.owes |> pop_amount(borrower_name)
    (new_owed_by_dict, owed_by_amount) = lender.owed_by |> pop_amount(borrower_name)
    total_lender_owes_to_borrower = owes_amount - owed_by_amount - amount
    final_owes_dict =
        if total_lender_owes_to_borrower > 0.0 then
            new_owes_dict |> Dict.insert(borrower_name, total_lender_owes_to_borrower)
        else
            new_owes_dict
    final_owed_by_dict =
        if total_lender_owes_to_borrower < 0.0 then
            new_owed_by_dict |> Dict.insert(borrower_name, -total_lender_owes_to_borrower)
        else
            new_owed_by_dict
    final_balance = lender.balance + amount
    { lender & owes: final_owes_dict, owed_by: final_owed_by_dict, balance: final_balance }

get_user : Database, Str -> Result User [NotFound]
get_user = |database, name|
    database.users
    |> List.find_first(|user| user.name == name)

add_loan : Database, Str -> Result Str [NotFound, InvalidJson]
add_loan = |database, payload|
    loan = parse_json_loan(payload)?
    lender = database |> get_user(loan.lender)?
    borrower = database |> get_user(loan.borrower)?
    updated_lender = lender |> update_lender(borrower.name, loan.amount)
    updated_borrower = borrower |> update_lender(lender.name, -loan.amount)
    [updated_lender, updated_borrower] |> users_to_json |> Ok
