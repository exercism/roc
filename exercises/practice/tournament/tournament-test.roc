# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/tournament/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Tournament exposing [tally]

# just the header if no input
expect
    table = ""
    result = tally(table)
    expected = Ok("Team                           | MP |  W |  D |  L |  P")
    result == expected

# a win is three points, a loss is zero points
expect
    table = "Allegoric Alaskans;Blithering Badgers;win"
    result = tally(table)
    expected = Ok(
        """
        Team                           | MP |  W |  D |  L |  P
        Allegoric Alaskans             |  1 |  1 |  0 |  0 |  3
        Blithering Badgers             |  1 |  0 |  0 |  1 |  0
        """,
    )
    result == expected

# a win can also be expressed as a loss
expect
    table = "Blithering Badgers;Allegoric Alaskans;loss"
    result = tally(table)
    expected = Ok(
        """
        Team                           | MP |  W |  D |  L |  P
        Allegoric Alaskans             |  1 |  1 |  0 |  0 |  3
        Blithering Badgers             |  1 |  0 |  0 |  1 |  0
        """,
    )
    result == expected

# a different team can win
expect
    table = "Blithering Badgers;Allegoric Alaskans;win"
    result = tally(table)
    expected = Ok(
        """
        Team                           | MP |  W |  D |  L |  P
        Blithering Badgers             |  1 |  1 |  0 |  0 |  3
        Allegoric Alaskans             |  1 |  0 |  0 |  1 |  0
        """,
    )
    result == expected

# a draw is one point each
expect
    table = "Allegoric Alaskans;Blithering Badgers;draw"
    result = tally(table)
    expected = Ok(
        """
        Team                           | MP |  W |  D |  L |  P
        Allegoric Alaskans             |  1 |  0 |  1 |  0 |  1
        Blithering Badgers             |  1 |  0 |  1 |  0 |  1
        """,
    )
    result == expected

# There can be more than one match
expect
    table =
        """
        Allegoric Alaskans;Blithering Badgers;win
        Allegoric Alaskans;Blithering Badgers;win
        """
    result = tally(table)
    expected = Ok(
        """
        Team                           | MP |  W |  D |  L |  P
        Allegoric Alaskans             |  2 |  2 |  0 |  0 |  6
        Blithering Badgers             |  2 |  0 |  0 |  2 |  0
        """,
    )
    result == expected

# There can be more than one winner
expect
    table =
        """
        Allegoric Alaskans;Blithering Badgers;loss
        Allegoric Alaskans;Blithering Badgers;win
        """
    result = tally(table)
    expected = Ok(
        """
        Team                           | MP |  W |  D |  L |  P
        Allegoric Alaskans             |  2 |  1 |  0 |  1 |  3
        Blithering Badgers             |  2 |  1 |  0 |  1 |  3
        """,
    )
    result == expected

# There can be more than two teams
expect
    table =
        """
        Allegoric Alaskans;Blithering Badgers;win
        Blithering Badgers;Courageous Californians;win
        Courageous Californians;Allegoric Alaskans;loss
        """
    result = tally(table)
    expected = Ok(
        """
        Team                           | MP |  W |  D |  L |  P
        Allegoric Alaskans             |  2 |  2 |  0 |  0 |  6
        Blithering Badgers             |  2 |  1 |  0 |  1 |  3
        Courageous Californians        |  2 |  0 |  0 |  2 |  0
        """,
    )
    result == expected

# typical input
expect
    table =
        """
        Allegoric Alaskans;Blithering Badgers;win
        Devastating Donkeys;Courageous Californians;draw
        Devastating Donkeys;Allegoric Alaskans;win
        Courageous Californians;Blithering Badgers;loss
        Blithering Badgers;Devastating Donkeys;loss
        Allegoric Alaskans;Courageous Californians;win
        """
    result = tally(table)
    expected = Ok(
        """
        Team                           | MP |  W |  D |  L |  P
        Devastating Donkeys            |  3 |  2 |  1 |  0 |  7
        Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6
        Blithering Badgers             |  3 |  1 |  0 |  2 |  3
        Courageous Californians        |  3 |  0 |  1 |  2 |  1
        """,
    )
    result == expected

# incomplete competition (not all pairs have played)
expect
    table =
        """
        Allegoric Alaskans;Blithering Badgers;loss
        Devastating Donkeys;Allegoric Alaskans;loss
        Courageous Californians;Blithering Badgers;draw
        Allegoric Alaskans;Courageous Californians;win
        """
    result = tally(table)
    expected = Ok(
        """
        Team                           | MP |  W |  D |  L |  P
        Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6
        Blithering Badgers             |  2 |  1 |  1 |  0 |  4
        Courageous Californians        |  2 |  0 |  1 |  1 |  1
        Devastating Donkeys            |  1 |  0 |  0 |  1 |  0
        """,
    )
    result == expected

# ties broken alphabetically
expect
    table =
        """
        Courageous Californians;Devastating Donkeys;win
        Allegoric Alaskans;Blithering Badgers;win
        Devastating Donkeys;Allegoric Alaskans;loss
        Courageous Californians;Blithering Badgers;win
        Blithering Badgers;Devastating Donkeys;draw
        Allegoric Alaskans;Courageous Californians;draw
        """
    result = tally(table)
    expected = Ok(
        """
        Team                           | MP |  W |  D |  L |  P
        Allegoric Alaskans             |  3 |  2 |  1 |  0 |  7
        Courageous Californians        |  3 |  2 |  1 |  0 |  7
        Blithering Badgers             |  3 |  0 |  1 |  2 |  1
        Devastating Donkeys            |  3 |  0 |  1 |  2 |  1
        """,
    )
    result == expected

# ensure points sorted numerically
expect
    table =
        """
        Devastating Donkeys;Blithering Badgers;win
        Devastating Donkeys;Blithering Badgers;win
        Devastating Donkeys;Blithering Badgers;win
        Devastating Donkeys;Blithering Badgers;win
        Blithering Badgers;Devastating Donkeys;win
        """
    result = tally(table)
    expected = Ok(
        """
        Team                           | MP |  W |  D |  L |  P
        Devastating Donkeys            |  5 |  4 |  0 |  1 | 12
        Blithering Badgers             |  5 |  1 |  0 |  4 |  3
        """,
    )
    result == expected

