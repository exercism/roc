module [plants]

Student : [Alice, Bob, Charlie, David, Eve, Fred, Ginny, Harriet, Ileana, Joseph, Kincaid, Larry]
Plant : [Grass, Clover, Radishes, Violets]

student_index : Student -> U64
student_index = |student|
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
plants = |diagram, student|
    start_index = 2 * student_index(student)
    grid = diagram |> Str.to_utf8 |> List.split_on('\n')
    [(0, 0), (0, 1), (1, 0), (1, 1)]
    |> List.map_try(
        |(row, column)|
            plant = grid |> List.get(row)? |> List.get(start_index + column)?
            when plant is
                'G' -> Ok(Grass)
                'C' -> Ok(Clover)
                'R' -> Ok(Radishes)
                'V' -> Ok(Violets)
                _ -> Err(UnknownPlant(plant)),
    )
