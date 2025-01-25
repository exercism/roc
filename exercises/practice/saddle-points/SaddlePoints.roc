module [saddle_points]

Forest : List (List U8)
Position : { row : U64, column : U64 }

saddle_points : Forest -> Set Position
saddle_points = |tree_heights|
    crash("Please implement the 'saddle_points' function")
