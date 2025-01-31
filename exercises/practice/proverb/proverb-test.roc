# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/proverb/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Proverb exposing [recite]

# zero pieces
expect
    result = recite([])
    expected = ""
    result == expected

# one piece
expect
    result = recite(["nail"])
    expected = "And all for the want of a nail."
    result == expected

# two pieces
expect
    result = recite(["nail", "shoe"])
    expected =
        """
        For want of a nail the shoe was lost.
        And all for the want of a nail.
        """
    result == expected

# three pieces
expect
    result = recite(["nail", "shoe", "horse"])
    expected =
        """
        For want of a nail the shoe was lost.
        For want of a shoe the horse was lost.
        And all for the want of a nail.
        """
    result == expected

# full proverb
expect
    result = recite(["nail", "shoe", "horse", "rider", "message", "battle", "kingdom"])
    expected =
        """
        For want of a nail the shoe was lost.
        For want of a shoe the horse was lost.
        For want of a horse the rider was lost.
        For want of a rider the message was lost.
        For want of a message the battle was lost.
        For want of a battle the kingdom was lost.
        And all for the want of a nail.
        """
    result == expected

# four pieces modernized
expect
    result = recite(["pin", "gun", "soldier", "battle"])
    expected =
        """
        For want of a pin the gun was lost.
        For want of a gun the soldier was lost.
        For want of a soldier the battle was lost.
        And all for the want of a pin.
        """
    result == expected

