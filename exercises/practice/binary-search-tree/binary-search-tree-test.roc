# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/binary-search-tree/canonical-data.json
# File last updated on 2024-10-21
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import BinarySearchTree exposing [fromList, toList]

##
## data is retained
##

expect
    data = [4]
    result = data |> fromList
    expected = Node {
        value: 4,
        left: Nil,
        right: Nil,
    }
    result == expected

##
## insert data at proper node
##

# smaller number at left node
expect
    data = [4, 2]
    result = data |> fromList
    expected = Node {
        value: 4,
        left: Node {
            value: 2,
            left: Nil,
            right: Nil,
        },
        right: Nil,
    }
    result == expected

# same number at left node
expect
    data = [4, 4]
    result = data |> fromList
    expected = Node {
        value: 4,
        left: Node {
            value: 4,
            left: Nil,
            right: Nil,
        },
        right: Nil,
    }
    result == expected

# greater number at right node
expect
    data = [4, 5]
    result = data |> fromList
    expected = Node {
        value: 4,
        left: Nil,
        right: Node {
            value: 5,
            left: Nil,
            right: Nil,
        },
    }
    result == expected

##
## can create complex tree
##

expect
    data = [4, 2, 6, 1, 3, 5, 7]
    result = data |> fromList
    expected = Node {
        value: 4,
        left: Node {
            value: 2,
            left: Node {
                value: 1,
                left: Nil,
                right: Nil,
            },
            right: Node {
                value: 3,
                left: Nil,
                right: Nil,
            },
        },
        right: Node {
            value: 6,
            left: Node {
                value: 5,
                left: Nil,
                right: Nil,
            },
            right: Node {
                value: 7,
                left: Nil,
                right: Nil,
            },
        },
    }
    result == expected

##
## can sort data
##

# can sort single number
expect
    data = [2]
    tree = data |> fromList
    result = tree |> toList
    expected = [2]
    result == expected

# can sort if second number is smaller than first
expect
    data = [2, 1]
    tree = data |> fromList
    result = tree |> toList
    expected = [1, 2]
    result == expected

# can sort if second number is same as first
expect
    data = [2, 2]
    tree = data |> fromList
    result = tree |> toList
    expected = [2, 2]
    result == expected

# can sort if second number is greater than first
expect
    data = [2, 3]
    tree = data |> fromList
    result = tree |> toList
    expected = [2, 3]
    result == expected

# can sort complex tree
expect
    data = [2, 1, 3, 6, 7, 5]
    tree = data |> fromList
    result = tree |> toList
    expected = [1, 2, 3, 5, 6, 7]
    result == expected

