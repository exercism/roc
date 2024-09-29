module [plants]

Student : [Alice, Bob, Charlie, David, Eve, Fred, Ginny, Harriet, Ileana, Joseph, Kincaid, Larry]
Plant : [Grass, Clover, Radishes, Violets]

studentIndex : Student -> U64
studentIndex = \student ->
    when student is
        Alice -> 0
        Bob -> 1
        Charlie -> 2
        David -> 3
        Eve -> 4
        Fred -> 5
        Ginny -> 6
        Harriet -> 7
        Ileana -> 8
        Joseph -> 9
        Kincaid -> 10
        Larry -> 11

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
