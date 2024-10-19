module [territory, territories]

Intersection : { x : U64, y : U64 }

Stone : [White, Black, None]

Territory : {
    owner : Stone,
    territory : Set Intersection,
}

Territories : {
    black : Set Intersection,
    white : Set Intersection,
    none : Set Intersection,
}

territory : Str, Intersection -> Result Territory _
territory = \boardStr, { x, y } ->
    crash "Please implement the 'territory' function"

territories : Str -> Result Territories _
territories = \boardStr ->
    crash "Please implement the 'territories' function"
