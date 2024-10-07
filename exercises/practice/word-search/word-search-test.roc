# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/word-search/canonical-data.json
# File last updated on 2024-10-07
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import WordSearch exposing [search]

# Should accept an initial game grid and a target search word
expect
    grid = "jefblpepre"
    wordsToSearchFor = ["clojure"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        # "clojure" is not in the grid
    ]
    result == expected

# Should locate one word written left to right
expect
    grid = "clojurermt"
    wordsToSearchFor = ["clojure"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("clojure", { start: { column: 1, row: 1 }, end: { column: 7, row: 1 } }),
    ]
    result == expected

# Should locate the same word written left to right in a different position
expect
    grid = "mtclojurer"
    wordsToSearchFor = ["clojure"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("clojure", { start: { column: 3, row: 1 }, end: { column: 9, row: 1 } }),
    ]
    result == expected

# Should locate a different left to right word
expect
    grid = "coffeelplx"
    wordsToSearchFor = ["coffee"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("coffee", { start: { column: 1, row: 1 }, end: { column: 6, row: 1 } }),
    ]
    result == expected

# Should locate that different left to right word in a different position
expect
    grid = "xcoffeezlp"
    wordsToSearchFor = ["coffee"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("coffee", { start: { column: 2, row: 1 }, end: { column: 7, row: 1 } }),
    ]
    result == expected

# Should locate a left to right word in two line grid
expect
    grid =
        """
        jefblpepre
        tclojurerm
        """
    wordsToSearchFor = ["clojure"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("clojure", { start: { column: 2, row: 2 }, end: { column: 8, row: 2 } }),
    ]
    result == expected

# Should locate a left to right word in three line grid
expect
    grid =
        """
        camdcimgtc
        jefblpepre
        clojurermt
        """
    wordsToSearchFor = ["clojure"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("clojure", { start: { column: 1, row: 3 }, end: { column: 7, row: 3 } }),
    ]
    result == expected

# Should locate a left to right word in ten line grid
expect
    grid =
        """
        jefblpepre
        camdcimgtc
        oivokprjsm
        pbwasqroua
        rixilelhrs
        wolcqlirpc
        screeaumgr
        alxhpburyi
        jalaycalmp
        clojurermt
        """
    wordsToSearchFor = ["clojure"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("clojure", { start: { column: 1, row: 10 }, end: { column: 7, row: 10 } }),
    ]
    result == expected

# Should locate that left to right word in a different position in a ten line grid
expect
    grid =
        """
        jefblpepre
        camdcimgtc
        oivokprjsm
        pbwasqroua
        rixilelhrs
        wolcqlirpc
        screeaumgr
        alxhpburyi
        clojurermt
        jalaycalmp
        """
    wordsToSearchFor = ["clojure"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("clojure", { start: { column: 1, row: 9 }, end: { column: 7, row: 9 } }),
    ]
    result == expected

# Should locate a different left to right word in a ten line grid
expect
    grid =
        """
        jefblpepre
        camdcimgtc
        oivokprjsm
        pbwasqroua
        rixilelhrs
        wolcqlirpc
        fortranftw
        alxhpburyi
        clojurermt
        jalaycalmp
        """
    wordsToSearchFor = ["fortran"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("fortran", { start: { column: 1, row: 7 }, end: { column: 7, row: 7 } }),
    ]
    result == expected

# Should locate multiple words
expect
    grid =
        """
        jefblpepre
        camdcimgtc
        oivokprjsm
        pbwasqroua
        rixilelhrs
        wolcqlirpc
        fortranftw
        alxhpburyi
        jalaycalmp
        clojurermt
        """
    wordsToSearchFor = ["fortran", "clojure"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("clojure", { start: { column: 1, row: 10 }, end: { column: 7, row: 10 } }),
        ("fortran", { start: { column: 1, row: 7 }, end: { column: 7, row: 7 } }),
    ]
    result == expected

# Should locate a single word written right to left
expect
    grid = "rixilelhrs"
    wordsToSearchFor = ["elixir"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("elixir", { start: { column: 6, row: 1 }, end: { column: 1, row: 1 } }),
    ]
    result == expected

# Should locate multiple words written in different horizontal directions
expect
    grid =
        """
        jefblpepre
        camdcimgtc
        oivokprjsm
        pbwasqroua
        rixilelhrs
        wolcqlirpc
        screeaumgr
        alxhpburyi
        jalaycalmp
        clojurermt
        """
    wordsToSearchFor = ["elixir", "clojure"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("clojure", { start: { column: 1, row: 10 }, end: { column: 7, row: 10 } }),
        ("elixir", { start: { column: 6, row: 5 }, end: { column: 1, row: 5 } }),
    ]
    result == expected

# Should locate words written top to bottom
expect
    grid =
        """
        jefblpepre
        camdcimgtc
        oivokprjsm
        pbwasqroua
        rixilelhrs
        wolcqlirpc
        screeaumgr
        alxhpburyi
        jalaycalmp
        clojurermt
        """
    wordsToSearchFor = ["clojure", "elixir", "ecmascript"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("clojure", { start: { column: 1, row: 10 }, end: { column: 7, row: 10 } }),
        ("elixir", { start: { column: 6, row: 5 }, end: { column: 1, row: 5 } }),
        ("ecmascript", { start: { column: 10, row: 1 }, end: { column: 10, row: 10 } }),
    ]
    result == expected

# Should locate words written bottom to top
expect
    grid =
        """
        jefblpepre
        camdcimgtc
        oivokprjsm
        pbwasqroua
        rixilelhrs
        wolcqlirpc
        screeaumgr
        alxhpburyi
        jalaycalmp
        clojurermt
        """
    wordsToSearchFor = ["clojure", "elixir", "ecmascript", "rust"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("clojure", { start: { column: 1, row: 10 }, end: { column: 7, row: 10 } }),
        ("elixir", { start: { column: 6, row: 5 }, end: { column: 1, row: 5 } }),
        ("ecmascript", { start: { column: 10, row: 1 }, end: { column: 10, row: 10 } }),
        ("rust", { start: { column: 9, row: 5 }, end: { column: 9, row: 2 } }),
    ]
    result == expected

# Should locate words written top left to bottom right
expect
    grid =
        """
        jefblpepre
        camdcimgtc
        oivokprjsm
        pbwasqroua
        rixilelhrs
        wolcqlirpc
        screeaumgr
        alxhpburyi
        jalaycalmp
        clojurermt
        """
    wordsToSearchFor = ["clojure", "elixir", "ecmascript", "rust", "java"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("clojure", { start: { column: 1, row: 10 }, end: { column: 7, row: 10 } }),
        ("elixir", { start: { column: 6, row: 5 }, end: { column: 1, row: 5 } }),
        ("ecmascript", { start: { column: 10, row: 1 }, end: { column: 10, row: 10 } }),
        ("rust", { start: { column: 9, row: 5 }, end: { column: 9, row: 2 } }),
        ("java", { start: { column: 1, row: 1 }, end: { column: 4, row: 4 } }),
    ]
    result == expected

# Should locate words written bottom right to top left
expect
    grid =
        """
        jefblpepre
        camdcimgtc
        oivokprjsm
        pbwasqroua
        rixilelhrs
        wolcqlirpc
        screeaumgr
        alxhpburyi
        jalaycalmp
        clojurermt
        """
    wordsToSearchFor = ["clojure", "elixir", "ecmascript", "rust", "java", "lua"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("clojure", { start: { column: 1, row: 10 }, end: { column: 7, row: 10 } }),
        ("elixir", { start: { column: 6, row: 5 }, end: { column: 1, row: 5 } }),
        ("ecmascript", { start: { column: 10, row: 1 }, end: { column: 10, row: 10 } }),
        ("rust", { start: { column: 9, row: 5 }, end: { column: 9, row: 2 } }),
        ("java", { start: { column: 1, row: 1 }, end: { column: 4, row: 4 } }),
        ("lua", { start: { column: 8, row: 9 }, end: { column: 6, row: 7 } }),
    ]
    result == expected

# Should locate words written bottom left to top right
expect
    grid =
        """
        jefblpepre
        camdcimgtc
        oivokprjsm
        pbwasqroua
        rixilelhrs
        wolcqlirpc
        screeaumgr
        alxhpburyi
        jalaycalmp
        clojurermt
        """
    wordsToSearchFor = ["clojure", "elixir", "ecmascript", "rust", "java", "lua", "lisp"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("clojure", { start: { column: 1, row: 10 }, end: { column: 7, row: 10 } }),
        ("elixir", { start: { column: 6, row: 5 }, end: { column: 1, row: 5 } }),
        ("ecmascript", { start: { column: 10, row: 1 }, end: { column: 10, row: 10 } }),
        ("rust", { start: { column: 9, row: 5 }, end: { column: 9, row: 2 } }),
        ("java", { start: { column: 1, row: 1 }, end: { column: 4, row: 4 } }),
        ("lua", { start: { column: 8, row: 9 }, end: { column: 6, row: 7 } }),
        ("lisp", { start: { column: 3, row: 6 }, end: { column: 6, row: 3 } }),
    ]
    result == expected

# Should locate words written top right to bottom left
expect
    grid =
        """
        jefblpepre
        camdcimgtc
        oivokprjsm
        pbwasqroua
        rixilelhrs
        wolcqlirpc
        screeaumgr
        alxhpburyi
        jalaycalmp
        clojurermt
        """
    wordsToSearchFor = ["clojure", "elixir", "ecmascript", "rust", "java", "lua", "lisp", "ruby"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("clojure", { start: { column: 1, row: 10 }, end: { column: 7, row: 10 } }),
        ("elixir", { start: { column: 6, row: 5 }, end: { column: 1, row: 5 } }),
        ("ecmascript", { start: { column: 10, row: 1 }, end: { column: 10, row: 10 } }),
        ("rust", { start: { column: 9, row: 5 }, end: { column: 9, row: 2 } }),
        ("java", { start: { column: 1, row: 1 }, end: { column: 4, row: 4 } }),
        ("lua", { start: { column: 8, row: 9 }, end: { column: 6, row: 7 } }),
        ("lisp", { start: { column: 3, row: 6 }, end: { column: 6, row: 3 } }),
        ("ruby", { start: { column: 8, row: 6 }, end: { column: 5, row: 9 } }),
    ]
    result == expected

# Should fail to locate a word that is not in the puzzle
expect
    grid =
        """
        jefblpepre
        camdcimgtc
        oivokprjsm
        pbwasqroua
        rixilelhrs
        wolcqlirpc
        screeaumgr
        alxhpburyi
        jalaycalmp
        clojurermt
        """
    wordsToSearchFor = ["clojure", "elixir", "ecmascript", "rust", "java", "lua", "lisp", "ruby", "haskell"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        ("clojure", { start: { column: 1, row: 10 }, end: { column: 7, row: 10 } }),
        ("elixir", { start: { column: 6, row: 5 }, end: { column: 1, row: 5 } }),
        ("ecmascript", { start: { column: 10, row: 1 }, end: { column: 10, row: 10 } }),
        ("rust", { start: { column: 9, row: 5 }, end: { column: 9, row: 2 } }),
        ("java", { start: { column: 1, row: 1 }, end: { column: 4, row: 4 } }),
        ("lua", { start: { column: 8, row: 9 }, end: { column: 6, row: 7 } }),
        ("lisp", { start: { column: 3, row: 6 }, end: { column: 6, row: 3 } }),
        ("ruby", { start: { column: 8, row: 6 }, end: { column: 5, row: 9 } }),
        # "haskell" is not in the grid
    ]
    result == expected

# Should fail to locate words that are not on horizontal, vertical, or diagonal lines
expect
    grid =
        """
        abc
        def
        """
    wordsToSearchFor = ["aef", "ced", "abf", "cbd"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        # "aef" is not in the grid
        # "ced" is not in the grid
        # "abf" is not in the grid
        # "cbd" is not in the grid
    ]
    result == expected

# Should not concatenate different lines to find a horizontal word
expect
    grid =
        """
        abceli
        xirdfg
        """
    wordsToSearchFor = ["elixir"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        # "elixir" is not in the grid
    ]
    result == expected

# Should not wrap around horizontally to find a word
expect
    grid = "silabcdefp"
    wordsToSearchFor = ["lisp"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        # "lisp" is not in the grid
    ]
    result == expected

# Should not wrap around vertically to find a word
expect
    grid =
        """
        s
        u
        r
        a
        b
        c
        t
        """
    wordsToSearchFor = ["rust"]
    result = grid |> search wordsToSearchFor
    expected = Dict.fromList [
        # "rust" is not in the grid
    ]
    result == expected

