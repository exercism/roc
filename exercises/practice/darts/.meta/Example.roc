module [score]

distanceSquared = \x, y ->
    x * x + y * y

score = \x, y ->
    d2 = distanceSquared x y
    if d2 > 100 then
        0
    else if d2 > 25 then
        1
    else if d2 > 1 then
        5
    else
        10
