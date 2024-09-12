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

value : List Color -> Result U64 _
value = \colors ->
    crash "Please implement the 'value' function"
