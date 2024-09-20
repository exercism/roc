module [real, imaginary, add, sub, mul, div, conjugate, abs, exp]

Complex : { re : F64, im : F64 }

real : Complex -> F64
real = \z ->
    crash "Please implement the 'real' function"

imaginary : Complex -> F64
imaginary = \z ->
    crash "Please implement the 'imaginary' function"

add : Complex, Complex -> Complex
add = \z1, z2 ->
    crash "Please implement the 'add' function"

sub : Complex, Complex -> Complex
sub = \z1, z2 ->
    crash "Please implement the 'sub' function"

mul : Complex, Complex -> Complex
mul = \z1, z2 ->
    crash "Please implement the 'mul' function"

div : Complex, Complex -> Complex
div = \z1, z2 ->
    crash "Please implement the 'div' function"

conjugate : Complex -> Complex
conjugate = \z ->
    crash "Please implement the 'conjugate' function"

abs : Complex -> F64
abs = \z ->
    crash "Please implement the 'abs' function"

exp : Complex -> Complex
exp = \z ->
    crash "Please implement the 'exp' function"
