module [add, sub, mul, div, abs, exp, exp_real, reduce]

add : [Rational (Int a) (Int a)], [Rational (Int a) (Int a)] -> [Rational (Int a) (Int a)]
add = \r1, r2 ->
    (Rational a1 b1) = r1
    (Rational a2 b2) = r2
    Rational (a1 * b2 + a2 * b1) (b1 * b2) |> reduce

sub : [Rational (Int a) (Int a)], [Rational (Int a) (Int a)] -> [Rational (Int a) (Int a)]
sub = \r1, r2 ->
    (Rational a1 b1) = r1
    (Rational a2 b2) = r2
    Rational (a1 * b2 - a2 * b1) (b1 * b2) |> reduce

mul : [Rational (Int a) (Int a)], [Rational (Int a) (Int a)] -> [Rational (Int a) (Int a)]
mul = \r1, r2 ->
    (Rational a1 b1) = r1
    (Rational a2 b2) = r2
    Rational (a1 * a2) (b1 * b2) |> reduce

div : [Rational (Int a) (Int a)], [Rational (Int a) (Int a)] -> [Rational (Int a) (Int a)]
div = \r1, r2 ->
    (Rational a1 b1) = r1
    (Rational a2 b2) = r2
    Rational (a1 * b2) (a2 * b1) |> reduce

abs : [Rational (Int a) (Int a)] -> [Rational (Int a) (Int a)]
abs = \r ->
    (Rational a b) = r
    Rational (Num.abs a) (Num.abs b) |> reduce

exp : [Rational (Int a) (Int a)], Int a -> [Rational (Int a) (Int a)]
exp = \r, n ->
    (Rational a b) = r
    when n is
        0 -> Rational 1 1
        pos if pos > 0 -> Rational (a |> Num.powInt pos) (b |> Num.powInt pos) |> reduce
        neg ->
            m = Num.abs neg
            Rational (b |> Num.powInt m) (a |> Num.powInt m) |> reduce

exp_real : Frac a, [Rational (Int b) (Int b)] -> Frac a
exp_real = \x, r ->
    (Rational a b) = r
    x |> Num.pow (Num.toFrac a / Num.toFrac b)

reduce : [Rational (Int b) (Int b)] -> [Rational (Int b) (Int b)]
reduce = \r ->
    (Rational a b) = r
    gcd = \m, n -> if n == 0 then m else gcd n (m % n)
    sign = \n -> if n < 0 then -1 else 1
    abs_a = Num.abs a
    abs_b = Num.abs b
    d = gcd abs_a abs_b
    Rational (sign a * sign b * abs_a // d) (abs_b // d)
