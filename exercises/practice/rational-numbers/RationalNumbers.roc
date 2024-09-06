module [add, sub, mul, div, abs, exp, expReal, reduce]

add : [Rational (Int a) (Int a)], [Rational (Int a) (Int a)] -> [Rational (Int a) (Int a)]
add = \r1, r2 ->
    crash "Please implement the 'add' function"

sub : [Rational (Int a) (Int a)], [Rational (Int a) (Int a)] -> [Rational (Int a) (Int a)]
sub = \r1, r2 ->
    crash "Please implement the 'sub' function"

mul : [Rational (Int a) (Int a)], [Rational (Int a) (Int a)] -> [Rational (Int a) (Int a)]
mul = \r1, r2 ->
    crash "Please implement the 'mul' function"

div : [Rational (Int a) (Int a)], [Rational (Int a) (Int a)] -> [Rational (Int a) (Int a)]
div = \r1, r2 ->
    crash "Please implement the 'div' function"

abs : [Rational (Int a) (Int a)] -> [Rational (Int a) (Int a)]
abs = \r ->
    crash "Please implement the 'abs' function"

exp : [Rational (Int a) (Int a)], Int a -> [Rational (Int a) (Int a)]
exp = \r, n ->
    crash "Please implement the 'exp' function"

expReal : Frac a, [Rational (Int b) (Int b)] -> Frac a
expReal = \x, r ->
    crash "Please implement the 'expReal' function"

## Reduce a rational number to its lowest terms, e.g., 6 / 8 --> 3 / 4
reduce : [Rational (Int b) (Int b)] -> [Rational (Int b) (Int b)]
reduce = \r ->
    crash "Please implement the 'reduce' function"

