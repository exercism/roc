module [latest, personalBest, personalTopThree]

Score : U64

latest : List Score -> Result Score _
latest = \scores ->
    crash "Please implement the 'latest' function"

personalBest : List Score -> Result Score _
personalBest = \scores ->
    crash "Please implement the 'personalBest' function"

personalTopThree : List Score -> List Score
personalTopThree = \scores ->
    crash "Please implement the 'personalTopThree' function"
