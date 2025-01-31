# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/kindergarten-garden/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import KindergartenGarden exposing [plants]

###
### partial garden
###

# garden with single student
expect
    diagram =
        """
        RC
        GG
        """
    result = diagram |> plants(Alice)
    result == Ok([Radishes, Clover, Grass, Grass])

# different garden with single student
expect
    diagram =
        """
        VC
        RC
        """
    result = diagram |> plants(Alice)
    result == Ok([Violets, Clover, Radishes, Clover])

# garden with two students
expect
    diagram =
        """
        VVCG
        VVRC
        """
    result = diagram |> plants(Bob)
    result == Ok([Clover, Grass, Radishes, Clover])

## multiple students for the same garden with three students

# second student's garden
expect
    diagram =
        """
        VVCCGG
        VVCCGG
        """
    result = diagram |> plants(Bob)
    result == Ok([Clover, Clover, Clover, Clover])

# third student's garden
expect
    diagram =
        """
        VVCCGG
        VVCCGG
        """
    result = diagram |> plants(Charlie)
    result == Ok([Grass, Grass, Grass, Grass])

###
### full garden
###

# for Alice, first student's garden
expect
    diagram =
        """
        VRCGVVRVCGGCCGVRGCVCGCGV
        VRCCCGCRRGVCGCRVVCVGCGCV
        """
    result = diagram |> plants(Alice)
    result == Ok([Violets, Radishes, Violets, Radishes])

# for Bob, second student's garden
expect
    diagram =
        """
        VRCGVVRVCGGCCGVRGCVCGCGV
        VRCCCGCRRGVCGCRVVCVGCGCV
        """
    result = diagram |> plants(Bob)
    result == Ok([Clover, Grass, Clover, Clover])

# for Charlie
expect
    diagram =
        """
        VRCGVVRVCGGCCGVRGCVCGCGV
        VRCCCGCRRGVCGCRVVCVGCGCV
        """
    result = diagram |> plants(Charlie)
    result == Ok([Violets, Violets, Clover, Grass])

# for David
expect
    diagram =
        """
        VRCGVVRVCGGCCGVRGCVCGCGV
        VRCCCGCRRGVCGCRVVCVGCGCV
        """
    result = diagram |> plants(David)
    result == Ok([Radishes, Violets, Clover, Radishes])

# for Eve
expect
    diagram =
        """
        VRCGVVRVCGGCCGVRGCVCGCGV
        VRCCCGCRRGVCGCRVVCVGCGCV
        """
    result = diagram |> plants(Eve)
    result == Ok([Clover, Grass, Radishes, Grass])

# for Fred
expect
    diagram =
        """
        VRCGVVRVCGGCCGVRGCVCGCGV
        VRCCCGCRRGVCGCRVVCVGCGCV
        """
    result = diagram |> plants(Fred)
    result == Ok([Grass, Clover, Violets, Clover])

# for Ginny
expect
    diagram =
        """
        VRCGVVRVCGGCCGVRGCVCGCGV
        VRCCCGCRRGVCGCRVVCVGCGCV
        """
    result = diagram |> plants(Ginny)
    result == Ok([Clover, Grass, Grass, Clover])

# for Harriet
expect
    diagram =
        """
        VRCGVVRVCGGCCGVRGCVCGCGV
        VRCCCGCRRGVCGCRVVCVGCGCV
        """
    result = diagram |> plants(Harriet)
    result == Ok([Violets, Radishes, Radishes, Violets])

# for Ileana
expect
    diagram =
        """
        VRCGVVRVCGGCCGVRGCVCGCGV
        VRCCCGCRRGVCGCRVVCVGCGCV
        """
    result = diagram |> plants(Ileana)
    result == Ok([Grass, Clover, Violets, Clover])

# for Joseph
expect
    diagram =
        """
        VRCGVVRVCGGCCGVRGCVCGCGV
        VRCCCGCRRGVCGCRVVCVGCGCV
        """
    result = diagram |> plants(Joseph)
    result == Ok([Violets, Clover, Violets, Grass])

# for Kincaid, second to last student's garden
expect
    diagram =
        """
        VRCGVVRVCGGCCGVRGCVCGCGV
        VRCCCGCRRGVCGCRVVCVGCGCV
        """
    result = diagram |> plants(Kincaid)
    result == Ok([Grass, Clover, Clover, Grass])

# for Larry, last student's garden
expect
    diagram =
        """
        VRCGVVRVCGGCCGVRGCVCGCGV
        VRCCCGCRRGVCGCRVVCVGCGCV
        """
    result = diagram |> plants(Larry)
    result == Ok([Grass, Violets, Clover, Violets])

