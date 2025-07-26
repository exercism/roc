# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/alphametics/canonical-data.json
# File last updated on 2025-07-26
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Alphametics exposing [solve]

# puzzle with three letters
expect
    result = solve("I + BB == ILL")
    Result.with_default(result, [])
    |> Set.from_list
    == Set.from_list(
        [
            ('I', 1),
            ('B', 9),
            ('L', 0),
        ],
    )

# solution must have unique value for each letter
expect
    result = solve("A == B")
    Result.is_err(result)

# leading zero solution is invalid
expect
    result = solve("ACA + DD == BD")
    Result.is_err(result)

# puzzle with two digits final carry
expect
    result = solve("A + A + A + A + A + A + A + A + A + A + A + B == BCC")
    Result.with_default(result, [])
    |> Set.from_list
    == Set.from_list(
        [
            ('A', 9),
            ('B', 1),
            ('C', 0),
        ],
    )

# puzzle with four letters
expect
    result = solve("AS + A == MOM")
    Result.with_default(result, [])
    |> Set.from_list
    == Set.from_list(
        [
            ('A', 9),
            ('S', 2),
            ('M', 1),
            ('O', 0),
        ],
    )

# puzzle with six letters
expect
    result = solve("NO + NO + TOO == LATE")
    Result.with_default(result, [])
    |> Set.from_list
    == Set.from_list(
        [
            ('N', 7),
            ('O', 4),
            ('T', 9),
            ('L', 1),
            ('A', 0),
            ('E', 2),
        ],
    )

# puzzle with seven letters
expect
    result = solve("HE + SEES + THE == LIGHT")
    Result.with_default(result, [])
    |> Set.from_list
    == Set.from_list(
        [
            ('E', 4),
            ('G', 2),
            ('H', 5),
            ('I', 0),
            ('L', 1),
            ('S', 9),
            ('T', 7),
        ],
    )

# puzzle with eight letters
expect
    result = solve("SEND + MORE == MONEY")
    Result.with_default(result, [])
    |> Set.from_list
    == Set.from_list(
        [
            ('S', 9),
            ('E', 5),
            ('N', 6),
            ('D', 7),
            ('M', 1),
            ('O', 0),
            ('R', 8),
            ('Y', 2),
        ],
    )

# puzzle with ten letters
expect
    result = solve("AND + A + STRONG + OFFENSE + AS + A + GOOD == DEFENSE")
    Result.with_default(result, [])
    |> Set.from_list
    == Set.from_list(
        [
            ('A', 5),
            ('D', 3),
            ('E', 4),
            ('F', 7),
            ('G', 8),
            ('N', 0),
            ('O', 2),
            ('R', 1),
            ('S', 6),
            ('T', 9),
        ],
    )

# puzzle with ten letters and 199 addends
expect
    result = solve("THIS + A + FIRE + THEREFORE + FOR + ALL + HISTORIES + I + TELL + A + TALE + THAT + FALSIFIES + ITS + TITLE + TIS + A + LIE + THE + TALE + OF + THE + LAST + FIRE + HORSES + LATE + AFTER + THE + FIRST + FATHERS + FORESEE + THE + HORRORS + THE + LAST + FREE + TROLL + TERRIFIES + THE + HORSES + OF + FIRE + THE + TROLL + RESTS + AT + THE + HOLE + OF + LOSSES + IT + IS + THERE + THAT + SHE + STORES + ROLES + OF + LEATHERS + AFTER + SHE + SATISFIES + HER + HATE + OFF + THOSE + FEARS + A + TASTE + RISES + AS + SHE + HEARS + THE + LEAST + FAR + HORSE + THOSE + FAST + HORSES + THAT + FIRST + HEAR + THE + TROLL + FLEE + OFF + TO + THE + FOREST + THE + HORSES + THAT + ALERTS + RAISE + THE + STARES + OF + THE + OTHERS + AS + THE + TROLL + ASSAILS + AT + THE + TOTAL + SHIFT + HER + TEETH + TEAR + HOOF + OFF + TORSO + AS + THE + LAST + HORSE + FORFEITS + ITS + LIFE + THE + FIRST + FATHERS + HEAR + OF + THE + HORRORS + THEIR + FEARS + THAT + THE + FIRES + FOR + THEIR + FEASTS + ARREST + AS + THE + FIRST + FATHERS + RESETTLE + THE + LAST + OF + THE + FIRE + HORSES + THE + LAST + TROLL + HARASSES + THE + FOREST + HEART + FREE + AT + LAST + OF + THE + LAST + TROLL + ALL + OFFER + THEIR + FIRE + HEAT + TO + THE + ASSISTERS + FAR + OFF + THE + TROLL + FASTS + ITS + LIFE + SHORTER + AS + STARS + RISE + THE + HORSES + REST + SAFE + AFTER + ALL + SHARE + HOT + FISH + AS + THEIR + AFFILIATES + TAILOR + A + ROOFS + FOR + THEIR + SAFE == FORTRESSES")
    Result.with_default(result, [])
    |> Set.from_list
    == Set.from_list(
        [
            ('A', 1),
            ('E', 0),
            ('F', 5),
            ('H', 8),
            ('I', 7),
            ('L', 2),
            ('O', 6),
            ('R', 3),
            ('S', 4),
            ('T', 9),
        ],
    )

