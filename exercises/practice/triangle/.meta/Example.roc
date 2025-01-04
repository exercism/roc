module [is_equilateral, is_isosceles, is_scalene]

approx_eq = \x, y ->
    Num.isApproxEq x y {}

is_valid_triangle = \(a, b, c) ->
    a > 0 && b > 0 && c > 0 && a + b >= c && a + c >= b && b + c >= a

is_equilateral : (F64, F64, F64) -> Bool
is_equilateral = \(a, b, c) ->
    is_valid_triangle (a, b, c) && approx_eq a b && approx_eq b c

is_isosceles : (F64, F64, F64) -> Bool
is_isosceles = \(a, b, c) ->
    is_valid_triangle (a, b, c) && (approx_eq a b || approx_eq b c || approx_eq a c)

is_scalene : (F64, F64, F64) -> Bool
is_scalene = \(a, b, c) ->
    is_valid_triangle (a, b, c) && !(is_isosceles (a, b, c))