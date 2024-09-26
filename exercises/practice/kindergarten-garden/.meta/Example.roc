module [plants]

Student : [Alice, Bob, Charlie, David, Eve, Fred, Ginny, Harriet, Ileana, Joseph, Kincaid, Larry]
Plant : [Grass, Clover, Radishes, Violets]

students : List Student
students = [Alice, Bob, Charlie, David, Eve, Fred, Ginny, Harriet, Ileana, Joseph, Kincaid, Larry]

studentIndex : Student -> U64
studentIndex = \student ->
    when students |> List.findFirstIndex \s -> s == student is
        Ok index -> index
        Err NotFound -> crash "Unreachable: all possible students are present in the students list"

plants : Str, Student -> Result (List Plant) _
plants = \diagram, student ->
    startIndex = 2 * studentIndex student
    grid =
        diagram
        |> Str.trim
        |> Str.split "\n"
        |> List.map \row ->
            row |> Str.trim |> Str.toUtf8
    [(0, 0), (0, 1), (1, 0), (1, 1)]
        |> List.mapTry \(row, column) ->
            plant = grid |> List.get? row |> List.get? (startIndex + column)
            when plant is
                'G' -> Ok Grass
                'C' -> Ok Clover
                'R' -> Ok Radishes
                'V' -> Ok Violets
                _ -> Err (UnknownPlant plant)
