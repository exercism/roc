module [is_equilateral, is_isosceles, is_scalene]

approx_eq = |x, y|
    Num.is_approx_eq(x, y, {})

is_valid_triangle = |(a, b, c)|
    a > 0 and b > 0 and c > 0 and a + b >= c and a + c >= b and b + c >= a

is_equilateral : (F64, F64, F64) -> Bool
is_equilateral = |(a, b, c)|
    is_valid_triangle((a, b, c)) and approx_eq(a, b) and approx_eq(b, c)

is_isosceles : (F64, F64, F64) -> Bool
is_isosceles = |(a, b, c)|
    is_valid_triangle((a, b, c)) and (approx_eq(a, b) or approx_eq(b, c) or approx_eq(a, c))

is_scalene : (F64, F64, F64) -> Bool
is_scalene = |(a, b, c)|
    is_valid_triangle((a, b, c)) and !(is_isosceles((a, b, c)))
