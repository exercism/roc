module [real, imaginary, add, sub, mul, div, conjugate, abs, exp]

Complex : { re : F64, im : F64 }

real : Complex -> F64
real = |z| z.re

imaginary : Complex -> F64
imaginary = |z| z.im

add : Complex, Complex -> Complex
add = |{ re: a, im: b }, { re: c, im: d }| {
    re: a + c,
    im: b + d,
}

sub : Complex, Complex -> Complex
sub = |{ re: a, im: b }, { re: c, im: d }| {
    re: a - c,
    im: b - d,
}

mul : Complex, Complex -> Complex
mul = |{ re: a, im: b }, { re: c, im: d }| {
    re: a * c - b * d,
    im: a * d + b * c,
}

div : Complex, Complex -> Complex
div = |{ re: a, im: b }, { re: c, im: d }|
    denominator = c * c + d * d
    {
        re: (a * c + b * d) / denominator,
        im: (b * c - a * d) / denominator,
    }

conjugate : Complex -> Complex
conjugate = |z| {
    re: z.re,
    im: -z.im,
}

abs : Complex -> F64
abs = |{ re: a, im: b }|
    a * a + b * b |> Num.sqrt

exp : Complex -> Complex
exp = |z|
    factor = Num.e |> Num.pow(z.re)
    {
        re: factor * Num.cos(z.im),
        im: factor * Num.sin(z.im),
    }
