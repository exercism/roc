module [square_of_sum, sum_of_squares, difference_of_squares]

sum : U64 -> U64
sum = \number ->
    number * (number + 1) // 2

square_of_sum : U64 -> U64
square_of_sum = \number ->
    s = sum number
    s * s

sum_of_squares : U64 -> U64
sum_of_squares = \number ->
    s = sum number
    s * (2 * number + 1) // 3

difference_of_squares : U64 -> U64
difference_of_squares = \number ->
    (square_of_sum number) - (sum_of_squares number)
