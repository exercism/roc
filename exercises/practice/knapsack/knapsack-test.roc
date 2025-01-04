# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/knapsack/canonical-data.json
# File last updated on 2024-10-06
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.18.0/0APbwVN1_p1mJ96tXjaoiUCr8NBGamr8G8Ac_DrXR-o.tar.br",
}

main! = \_args ->
    Ok {}

import Knapsack exposing [maxium_value]

# no items
expect
    items = []
    result = maxium_value { items, maximum_weight: 100 }
    result == 0

# one item, too heavy
expect
    items = [
        { weight: 100, value: 1 },
    ]
    result = maxium_value { items, maximum_weight: 10 }
    result == 0

# five items (cannot be greedy by weight)
expect
    items = [
        { weight: 2, value: 5 },
        { weight: 2, value: 5 },
        { weight: 2, value: 5 },
        { weight: 2, value: 5 },
        { weight: 10, value: 21 },
    ]
    result = maxium_value { items, maximum_weight: 10 }
    result == 21

# five items (cannot be greedy by value)
expect
    items = [
        { weight: 2, value: 20 },
        { weight: 2, value: 20 },
        { weight: 2, value: 20 },
        { weight: 2, value: 20 },
        { weight: 10, value: 50 },
    ]
    result = maxium_value { items, maximum_weight: 10 }
    result == 80

# example knapsack
expect
    items = [
        { weight: 5, value: 10 },
        { weight: 4, value: 40 },
        { weight: 6, value: 30 },
        { weight: 4, value: 50 },
    ]
    result = maxium_value { items, maximum_weight: 10 }
    result == 90

# 8 items
expect
    items = [
        { weight: 25, value: 350 },
        { weight: 35, value: 400 },
        { weight: 45, value: 450 },
        { weight: 5, value: 20 },
        { weight: 25, value: 70 },
        { weight: 3, value: 8 },
        { weight: 2, value: 5 },
        { weight: 2, value: 5 },
    ]
    result = maxium_value { items, maximum_weight: 104 }
    result == 900

# 15 items
expect
    items = [
        { weight: 70, value: 135 },
        { weight: 73, value: 139 },
        { weight: 77, value: 149 },
        { weight: 80, value: 150 },
        { weight: 82, value: 156 },
        { weight: 87, value: 163 },
        { weight: 90, value: 173 },
        { weight: 94, value: 184 },
        { weight: 98, value: 192 },
        { weight: 106, value: 201 },
        { weight: 110, value: 210 },
        { weight: 113, value: 214 },
        { weight: 115, value: 221 },
        { weight: 118, value: 229 },
        { weight: 120, value: 240 },
    ]
    result = maxium_value { items, maximum_weight: 750 }
    result == 1458

