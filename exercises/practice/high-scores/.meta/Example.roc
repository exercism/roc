module [latest, personal_best, personal_top_three]

Score : U64

latest : List Score -> Result Score [ListWasEmpty]
latest = List.last

personal_best : List Score -> Result Score [ListWasEmpty]
personal_best = List.max

personal_top_three : List Score -> List Score
personal_top_three = |scores|
    scores |> List.sort_desc |> List.take_first(3)
