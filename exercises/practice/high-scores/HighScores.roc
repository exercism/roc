module [latest, personal_best, personal_top_three]

Score : U64

latest : List Score -> Result Score _
latest = |scores|
    crash("Please implement the 'latest' function")

personal_best : List Score -> Result Score _
personal_best = |scores|
    crash("Please implement the 'personal_best' function")

personal_top_three : List Score -> List Score
personal_top_three = |scores|
    crash("Please implement the 'personal_top_three' function")
