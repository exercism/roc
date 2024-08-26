module [isEquilateral, isIsosceles, isScalene]

approxEq = \x, y ->
    Num.isApproxEq x y {}

isValidTriangle = \(a, b, c) ->
    a > 0 && b > 0 && c > 0 && a + b >= c && a + c >= b && b + c >= a

isEquilateral = \(a, b, c) ->
    isValidTriangle (a, b, c) && approxEq a b && approxEq b c

isIsosceles = \(a, b, c) ->
    isValidTriangle (a, b, c) && (approxEq a b || approxEq b c || approxEq a c)

isScalene = \(a, b, c) ->
    isValidTriangle (a, b, c) && !(isIsosceles (a, b, c))
