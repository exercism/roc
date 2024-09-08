# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/rest-api/canonical-data.json
# File last updated on 2024-09-08
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
    json: "https://github.com/lukewilliamboswell/roc-json/releases/download/0.10.2/FH4N0Sw-JSFXJfG3j54VEDPtXOoN-6I9v_IA8S18IGk.tar.br",
}

main =
    Task.ok {}

import RestApi exposing [get, post]

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
    expected = Ok "{\"balance\":0.0,\"name\":\"Adam\",\"owed_by\":{},\"owes\":{}}"
    result == expected

# get single user
expect
    database = {
        users: [
            {
                name: "Adam",
                owes: [],
                owedBy: [],
                balance: 0.0,
            },
            {
                name: "Bob",
                owes: [],
                owedBy: [],
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
    expected = Ok "{\"users\":[{\"balance\":0.0,\"name\":\"Bob\",\"owed_by\":{},\"owes\":{}}]}"
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
                owes: [],
                owedBy: [],
                balance: 0.0,
            },
            {
                name: "Bob",
                owes: [],
                owedBy: [],
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
    expected = Ok "{\"users\":[{\"balance\":3.0,\"name\":\"Adam\",\"owed_by\":{\"Bob\":3.0},\"owes\":{}},{\"balance\":-3.0,\"name\":\"Bob\",\"owed_by\":{},\"owes\":{\"Adam\":3.0}}]}"
    result == expected

# borrower has negative balance
expect
    database = {
        users: [
            {
                name: "Adam",
                owes: [],
                owedBy: [],
                balance: 0.0,
            },
            {
                name: "Bob",
                owes: [
                    { name: "Chuck", amount: 3.0 },
                ],
                owedBy: [],
                balance: -3.0,
            },
            {
                name: "Chuck",
                owes: [],
                owedBy: [
                    { name: "Bob", amount: 3.0 },
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
    expected = Ok "{\"users\":[{\"balance\":3.0,\"name\":\"Adam\",\"owed_by\":{\"Bob\":3.0},\"owes\":{}},{\"balance\":-6.0,\"name\":\"Bob\",\"owed_by\":{},\"owes\":{\"Adam\":3.0,\"Chuck\":3.0}}]}"
    result == expected

# lender has negative balance
expect
    database = {
        users: [
            {
                name: "Adam",
                owes: [],
                owedBy: [],
                balance: 0.0,
            },
            {
                name: "Bob",
                owes: [
                    { name: "Chuck", amount: 3.0 },
                ],
                owedBy: [],
                balance: -3.0,
            },
            {
                name: "Chuck",
                owes: [],
                owedBy: [
                    { name: "Bob", amount: 3.0 },
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
    expected = Ok "{\"users\":[{\"balance\":-3.0,\"name\":\"Adam\",\"owed_by\":{},\"owes\":{\"Bob\":3.0}},{\"balance\":0.0,\"name\":\"Bob\",\"owed_by\":{\"Adam\":3.0},\"owes\":{\"Chuck\":3.0}}]}"
    result == expected

# lender owes borrower
expect
    database = {
        users: [
            {
                name: "Adam",
                owes: [
                    { name: "Bob", amount: 3.0 },
                ],
                owedBy: [],
                balance: -3.0,
            },
            {
                name: "Bob",
                owes: [],
                owedBy: [
                    { name: "Adam", amount: 3.0 },
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
    expected = Ok "{\"users\":[{\"balance\":-1.0,\"name\":\"Adam\",\"owed_by\":{},\"owes\":{\"Bob\":1.0}},{\"balance\":1.0,\"name\":\"Bob\",\"owed_by\":{\"Adam\":1.0},\"owes\":{}}]}"
    result == expected

# lender owes borrower less than new loan
expect
    database = {
        users: [
            {
                name: "Adam",
                owes: [
                    { name: "Bob", amount: 3.0 },
                ],
                owedBy: [],
                balance: -3.0,
            },
            {
                name: "Bob",
                owes: [],
                owedBy: [
                    { name: "Adam", amount: 3.0 },
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
    expected = Ok "{\"users\":[{\"balance\":1.0,\"name\":\"Adam\",\"owed_by\":{\"Bob\":1.0},\"owes\":{}},{\"balance\":-1.0,\"name\":\"Bob\",\"owed_by\":{},\"owes\":{\"Adam\":1.0}}]}"
    result == expected

# lender owes borrower same as new loan
expect
    database = {
        users: [
            {
                name: "Adam",
                owes: [
                    { name: "Bob", amount: 3.0 },
                ],
                owedBy: [],
                balance: -3.0,
            },
            {
                name: "Bob",
                owes: [],
                owedBy: [
                    { name: "Adam", amount: 3.0 },
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
    expected = Ok "{\"users\":[{\"balance\":0.0,\"name\":\"Adam\",\"owed_by\":{},\"owes\":{}},{\"balance\":0.0,\"name\":\"Bob\",\"owed_by\":{},\"owes\":{}}]}"
    result == expected

