module [real, imaginary, add, sub, mul, div, conjugate, abs, exp]

Complex : { re : F64, im : F64 }

real : Complex -> F64
real = \z -> z.re

imaginary : Complex -> F64
imaginary = \z -> z.im

add : Complex, Complex -> Complex
add = \z1, z2 -> {
    re: z1.re + z2.re,
    im: z1.im + z2.im,
}

sub : Complex, Complex -> Complex
sub = \z1, z2 -> {
    re: z1.re - z2.re,
    im: z1.im - z2.im,
}

mul : Complex, Complex -> Complex
mul = \z1, z2 -> {
    re: z1.re * z2.re - z1.im * z2.im,
    im: z1.re * z2.im + z1.im * z2.re,
}

div : Complex, Complex -> Complex
div = \z1, z2 ->
    denominator = z2.re * z2.re + z2.im * z2.im
    {
        re: (z1.re * z2.re + z1.im * z2.im) / denominator,
        im: (z1.im * z2.re - z1.re * z2.im) / denominator,
    }

conjugate : Complex -> Complex
conjugate = \z -> {
    re: z.re,
    im: -z.im,
}

abs : Complex -> F64
abs = \z ->
    z.re * z.re + z.im * z.im |> Num.sqrt

exp : Complex -> Complex
exp = \z ->
    factor = Num.e |> Num.pow z.re
    {
        re: factor * Num.cos z.im,
        im: factor * Num.sin z.im,
    }
