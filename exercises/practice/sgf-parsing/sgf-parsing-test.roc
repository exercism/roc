# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/sgf-parsing/canonical-data.json
# File last updated on 2025-09-15
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.20.0/X73hGh05nNTkDHU06FHC0YfFaQB1pimX7gncRcao5mU.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.10.0/6eZYaXkrakq9fJ4oUc0VfdxU1Fap2iTuAN18q9OgQss.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import SgfParsing exposing [parse]

# empty input
expect
    sgf = ""
    result = parse(sgf)
    result |> Result.is_err

# tree with no nodes
expect
    sgf = "()"
    result = parse(sgf)
    result |> Result.is_err

# node without tree
expect
    sgf = ";"
    result = parse(sgf)
    result |> Result.is_err

# node without properties
expect
    sgf = "(;)"
    result = parse(sgf)
    expected =
        GameNode(
            {
                properties: Dict.from_list([]),
                children: [],
            },
        )
    result == Ok(expected)

# single node tree
expect
    sgf = "(;A[B])"
    result = parse(sgf)
    expected =
        GameNode(
            {
                properties: Dict.from_list(
                    [
                        ("A", ["B"]),
                    ],
                ),
                children: [],
            },
        )
    result == Ok(expected)

# multiple properties
expect
    sgf = "(;A[b]C[d])"
    result = parse(sgf)
    expected =
        GameNode(
            {
                properties: Dict.from_list(
                    [
                        ("A", ["b"]),
                        ("C", ["d"]),
                    ],
                ),
                children: [],
            },
        )
    result == Ok(expected)

# properties without delimiter
expect
    sgf = "(;A)"
    result = parse(sgf)
    result |> Result.is_err

# all lowercase property
expect
    sgf = "(;a[b])"
    result = parse(sgf)
    result |> Result.is_err

# upper and lowercase property
expect
    sgf = "(;Aa[b])"
    result = parse(sgf)
    result |> Result.is_err

# two nodes
expect
    sgf = "(;A[B];B[C])"
    result = parse(sgf)
    expected =
        GameNode(
            {
                properties: Dict.from_list(
                    [
                        ("A", ["B"]),
                    ],
                ),
                children: [
                    GameNode(
                        {
                            properties: Dict.from_list(
                                [
                                    ("B", ["C"]),
                                ],
                            ),
                            children: [],
                        },
                    ),
                ],
            },
        )
    result == Ok(expected)

# two child trees
expect
    sgf = "(;A[B](;B[C])(;C[D]))"
    result = parse(sgf)
    expected =
        GameNode(
            {
                properties: Dict.from_list(
                    [
                        ("A", ["B"]),
                    ],
                ),
                children: [
                    GameNode(
                        {
                            properties: Dict.from_list(
                                [
                                    ("B", ["C"]),
                                ],
                            ),
                            children: [],
                        },
                    ),
                    GameNode(
                        {
                            properties: Dict.from_list(
                                [
                                    ("C", ["D"]),
                                ],
                            ),
                            children: [],
                        },
                    ),
                ],
            },
        )
    result == Ok(expected)

# multiple property values
expect
    sgf = "(;A[b][c][d])"
    result = parse(sgf)
    expected =
        GameNode(
            {
                properties: Dict.from_list(
                    [
                        ("A", ["b", "c", "d"]),
                    ],
                ),
                children: [],
            },
        )
    result == Ok(expected)

# within property values, whitespace characters such as tab are converted to spaces
expect
    sgf = "(;A[hello\t\tworld])"
    result = parse(sgf)
    expected =
        GameNode(
            {
                properties: Dict.from_list(
                    [
                        ("A", ["hello  world"]),
                    ],
                ),
                children: [],
            },
        )
    result == Ok(expected)

# within property values, newlines remain as newlines
expect
    sgf = "(;A[hello\n\nworld])"
    result = parse(sgf)
    expected =
        GameNode(
            {
                properties: Dict.from_list(
                    [
                        ("A", ["hello\n\nworld"]),
                    ],
                ),
                children: [],
            },
        )
    result == Ok(expected)

# escaped closing bracket within property value becomes just a closing bracket
expect
    sgf = "(;A[\\]])"
    result = parse(sgf)
    expected =
        GameNode(
            {
                properties: Dict.from_list(
                    [
                        ("A", ["]"]),
                    ],
                ),
                children: [],
            },
        )
    result == Ok(expected)

# escaped backslash in property value becomes just a backslash
expect
    sgf = "(;A[\\\\])"
    result = parse(sgf)
    expected =
        GameNode(
            {
                properties: Dict.from_list(
                    [
                        ("A", ["\\"]),
                    ],
                ),
                children: [],
            },
        )
    result == Ok(expected)

# opening bracket within property value doesn't need to be escaped
expect
    sgf = "(;A[x[y\\]z][foo]B[bar];C[baz])"
    result = parse(sgf)
    expected =
        GameNode(
            {
                properties: Dict.from_list(
                    [
                        ("A", ["x[y]z", "foo"]),
                        ("B", ["bar"]),
                    ],
                ),
                children: [
                    GameNode(
                        {
                            properties: Dict.from_list(
                                [
                                    ("C", ["baz"]),
                                ],
                            ),
                            children: [],
                        },
                    ),
                ],
            },
        )
    result == Ok(expected)

# semicolon in property value doesn't need to be escaped
expect
    sgf = "(;A[a;b][foo]B[bar];C[baz])"
    result = parse(sgf)
    expected =
        GameNode(
            {
                properties: Dict.from_list(
                    [
                        ("A", ["a;b", "foo"]),
                        ("B", ["bar"]),
                    ],
                ),
                children: [
                    GameNode(
                        {
                            properties: Dict.from_list(
                                [
                                    ("C", ["baz"]),
                                ],
                            ),
                            children: [],
                        },
                    ),
                ],
            },
        )
    result == Ok(expected)

# parentheses in property value don't need to be escaped
expect
    sgf = "(;A[x(y)z][foo]B[bar];C[baz])"
    result = parse(sgf)
    expected =
        GameNode(
            {
                properties: Dict.from_list(
                    [
                        ("A", ["x(y)z", "foo"]),
                        ("B", ["bar"]),
                    ],
                ),
                children: [
                    GameNode(
                        {
                            properties: Dict.from_list(
                                [
                                    ("C", ["baz"]),
                                ],
                            ),
                            children: [],
                        },
                    ),
                ],
            },
        )
    result == Ok(expected)

# escaped tab in property value is converted to space
expect
    sgf = "(;A[hello\\\tworld])"
    result = parse(sgf)
    expected =
        GameNode(
            {
                properties: Dict.from_list(
                    [
                        ("A", ["hello world"]),
                    ],
                ),
                children: [],
            },
        )
    result == Ok(expected)

# escaped newline in property value is converted to nothing at all
expect
    sgf = "(;A[hello\\\nworld])"
    result = parse(sgf)
    expected =
        GameNode(
            {
                properties: Dict.from_list(
                    [
                        ("A", ["helloworld"]),
                    ],
                ),
                children: [],
            },
        )
    result == Ok(expected)

# escaped t and n in property value are just letters, not whitespace
expect
    sgf = "(;A[\\t = t and \\n = n])"
    result = parse(sgf)
    expected =
        GameNode(
            {
                properties: Dict.from_list(
                    [
                        ("A", ["t = t and n = n"]),
                    ],
                ),
                children: [],
            },
        )
    result == Ok(expected)

# mixing various kinds of whitespace and escaped characters in property value
expect
    sgf = "(;A[\\]b\nc\\\nd\t\te\\\\ \\\n\\]])"
    result = parse(sgf)
    expected =
        GameNode(
            {
                properties: Dict.from_list(
                    [
                        ("A", ["]b\ncd  e\\ ]"]),
                    ],
                ),
                children: [],
            },
        )
    result == Ok(expected)

