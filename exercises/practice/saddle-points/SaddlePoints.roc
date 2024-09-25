module [saddlePoints]

Forest : List (List U8)
Position : { row : U64, column : U64 }

saddlePoints : Forest -> Set Position
saddlePoints = \treeHeights ->
    crash "Please implement the 'saddlePoints' function"
