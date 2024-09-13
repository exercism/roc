module [value]

Color : [
    Black,
    Brown,
    Red,
    Orange,
    Yellow,
    Green,
    Blue,
    Violet,
    Grey,
    White,
]

value : Color, Color -> U8
value = \first, second ->
    crash "Please implement the 'value' function"
