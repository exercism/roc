# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/connect/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Connect exposing [winner]

# an empty board has no winner
expect
    board =
        """
        . . . . .
         . . . . .
          . . . . .
           . . . . .
            . . . . .
        """
    result = board |> winner
    result == Err(NotFinished)

# X can win on a 1x1 board
expect
    board = "X"
    result = board |> winner
    result == Ok(PlayerX)

# O can win on a 1x1 board
expect
    board = "O"
    result = board |> winner
    result == Ok(PlayerO)

# only edges does not make a winner
expect
    board =
        """
        O O O X
         X . . X
          X . . X
           X O O O
        """
    result = board |> winner
    result == Err(NotFinished)

# illegal diagonal does not make a winner
expect
    board =
        """
        X O . .
         O X X X
          O X O .
           . O X .
            X X O O
        """
    result = board |> winner
    result == Err(NotFinished)

# nobody wins crossing adjacent angles
expect
    board =
        """
        X . . .
         . X O .
          O . X O
           . O . X
            . . O .
        """
    result = board |> winner
    result == Err(NotFinished)

# X wins crossing from left to right
expect
    board =
        """
        . O . .
         O X X X
          O X O .
           X X O X
            . O X .
        """
    result = board |> winner
    result == Ok(PlayerX)

# O wins crossing from top to bottom
expect
    board =
        """
        . O . .
         O X X X
          O O O .
           X X O X
            . O X .
        """
    result = board |> winner
    result == Ok(PlayerO)

# X wins using a convoluted path
expect
    board =
        """
        . X X . .
         X . X . X
          . X . X .
           . X X . .
            O O O O O
        """
    result = board |> winner
    result == Ok(PlayerX)

# X wins using a spiral path
expect
    board =
        """
        O X X X X X X X X
         O X O O O O O O O
          O X O X X X X X O
           O X O X O O O X O
            O X O X X X O X O
             O X O O O X O X O
              O X X X X X O X O
               O O O O O O O X O
                X X X X X X X X O
        """
    result = board |> winner
    result == Ok(PlayerX)

