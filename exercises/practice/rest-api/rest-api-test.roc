# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/rest-api/canonical-data.json
# File last updated on 2024-09-09
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
    json: "https://github.com/lukewilliamboswell/roc-json/releases/download/0.10.2/FH4N0Sw-JSFXJfG3j54VEDPtXOoN-6I9v_IA8S18IGk.tar.br",
}

main =
    Task.ok {}

import RestApi exposing [get, post]

standardizeResult = \result ->
    result
    |> Result.try \string ->
        string
        |> Str.replaceEach ".0," ","
        |> Str.replaceEach ".0}" "}"
        |> Str.toUtf8
        |> List.dropIf \c -> [' ', '\t', '\n'] |> List.contains c
        |> Str.fromUtf8

##
## user management
##

# no users
expect
    database = {
        users: [
        ],
    }
    result =
        database
        |> get {
            url: "/users",
        }
        |> standardizeResult
    expected = Ok "{\"users\":[]}"
    result == expected

# add user
expect
    database = {
        users: [
        ],
    }
    result =
        database
        |> post {
            url: "/add",
            payload: "{\"user\": \"Adam\"}",
        }
        |> standardizeResult
    expected = Ok "{\"balance\":0,\"name\":\"Adam\",\"owed_by\":{},\"owes\":{}}"
    result == expected

# get single user
expect
    database = {
        users: [
            {
                name: "Adam",
                owes: Dict.fromList [],
                owedBy: Dict.fromList [],
                balance: 0.0,
            },
            {
                name: "Bob",
                owes: Dict.fromList [],
                owedBy: Dict.fromList [],
                balance: 0.0,
            },
        ],
    }
    result =
        database
        |> get {
            url: "/users",
            payload: "{\"users\": [\"Bob\"]}",
        }
        |> standardizeResult
    expected = Ok "{\"users\":[{\"balance\":0,\"name\":\"Bob\",\"owed_by\":{},\"owes\":{}}]}"
    result == expected

##
## iou
##

# both users have 0 balance
expect
    database = {
        users: [
            {
                name: "Adam",
                owes: Dict.fromList [],
                owedBy: Dict.fromList [],
                balance: 0.0,
            },
            {
                name: "Bob",
                owes: Dict.fromList [],
                owedBy: Dict.fromList [],
                balance: 0.0,
            },
        ],
    }
    result =
        database
        |> post {
            url: "/iou",
            payload: "{\"amount\": 3.0, \"borrower\": \"Bob\", \"lender\": \"Adam\"}",
        }
        |> standardizeResult
    expected = Ok "{\"users\":[{\"balance\":3,\"name\":\"Adam\",\"owed_by\":{\"Bob\":3},\"owes\":{}},{\"balance\":-3,\"name\":\"Bob\",\"owed_by\":{},\"owes\":{\"Adam\":3}}]}"
    result == expected

# borrower has negative balance
expect
    database = {
        users: [
            {
                name: "Adam",
                owes: Dict.fromList [],
                owedBy: Dict.fromList [],
                balance: 0.0,
            },
            {
                name: "Bob",
                owes: Dict.fromList [
                    ("Chuck", 3.0),
                ],
                owedBy: Dict.fromList [],
                balance: -3.0,
            },
            {
                name: "Chuck",
                owes: Dict.fromList [],
                owedBy: Dict.fromList [
                    ("Bob", 3.0),
                ],
                balance: 3.0,
            },
        ],
    }
    result =
        database
        |> post {
            url: "/iou",
            payload: "{\"amount\": 3.0, \"borrower\": \"Bob\", \"lender\": \"Adam\"}",
        }
        |> standardizeResult
    expected = Ok "{\"users\":[{\"balance\":3,\"name\":\"Adam\",\"owed_by\":{\"Bob\":3},\"owes\":{}},{\"balance\":-6,\"name\":\"Bob\",\"owed_by\":{},\"owes\":{\"Adam\":3,\"Chuck\":3}}]}"
    result == expected

# lender has negative balance
expect
    database = {
        users: [
            {
                name: "Adam",
                owes: Dict.fromList [],
                owedBy: Dict.fromList [],
                balance: 0.0,
            },
            {
                name: "Bob",
                owes: Dict.fromList [
                    ("Chuck", 3.0),
                ],
                owedBy: Dict.fromList [],
                balance: -3.0,
            },
            {
                name: "Chuck",
                owes: Dict.fromList [],
                owedBy: Dict.fromList [
                    ("Bob", 3.0),
                ],
                balance: 3.0,
            },
        ],
    }
    result =
        database
        |> post {
            url: "/iou",
            payload: "{\"amount\": 3.0, \"borrower\": \"Adam\", \"lender\": \"Bob\"}",
        }
        |> standardizeResult
    expected = Ok "{\"users\":[{\"balance\":-3,\"name\":\"Adam\",\"owed_by\":{},\"owes\":{\"Bob\":3}},{\"balance\":0,\"name\":\"Bob\",\"owed_by\":{\"Adam\":3},\"owes\":{\"Chuck\":3}}]}"
    result == expected

# lender owes borrower
expect
    database = {
        users: [
            {
                name: "Adam",
                owes: Dict.fromList [
                    ("Bob", 3.0),
                ],
                owedBy: Dict.fromList [],
                balance: -3.0,
            },
            {
                name: "Bob",
                owes: Dict.fromList [],
                owedBy: Dict.fromList [
                    ("Adam", 3.0),
                ],
                balance: 3.0,
            },
        ],
    }
    result =
        database
        |> post {
            url: "/iou",
            payload: "{\"amount\": 2.0, \"borrower\": \"Bob\", \"lender\": \"Adam\"}",
        }
        |> standardizeResult
    expected = Ok "{\"users\":[{\"balance\":-1,\"name\":\"Adam\",\"owed_by\":{},\"owes\":{\"Bob\":1}},{\"balance\":1,\"name\":\"Bob\",\"owed_by\":{\"Adam\":1},\"owes\":{}}]}"
    result == expected

# lender owes borrower less than new loan
expect
    database = {
        users: [
            {
                name: "Adam",
                owes: Dict.fromList [
                    ("Bob", 3.0),
                ],
                owedBy: Dict.fromList [],
                balance: -3.0,
            },
            {
                name: "Bob",
                owes: Dict.fromList [],
                owedBy: Dict.fromList [
                    ("Adam", 3.0),
                ],
                balance: 3.0,
            },
        ],
    }
    result =
        database
        |> post {
            url: "/iou",
            payload: "{\"amount\": 4.0, \"borrower\": \"Bob\", \"lender\": \"Adam\"}",
        }
        |> standardizeResult
    expected = Ok "{\"users\":[{\"balance\":1,\"name\":\"Adam\",\"owed_by\":{\"Bob\":1},\"owes\":{}},{\"balance\":-1,\"name\":\"Bob\",\"owed_by\":{},\"owes\":{\"Adam\":1}}]}"
    result == expected

# lender owes borrower same as new loan
expect
    database = {
        users: [
            {
                name: "Adam",
                owes: Dict.fromList [
                    ("Bob", 3.0),
                ],
                owedBy: Dict.fromList [],
                balance: -3.0,
            },
            {
                name: "Bob",
                owes: Dict.fromList [],
                owedBy: Dict.fromList [
                    ("Adam", 3.0),
                ],
                balance: 3.0,
            },
        ],
    }
    result =
        database
        |> post {
            url: "/iou",
            payload: "{\"amount\": 3.0, \"borrower\": \"Bob\", \"lender\": \"Adam\"}",
        }
        |> standardizeResult
    expected = Ok "{\"users\":[{\"balance\":0,\"name\":\"Adam\",\"owed_by\":{},\"owes\":{}},{\"balance\":0,\"name\":\"Bob\",\"owed_by\":{},\"owes\":{}}]}"
    result == expected

