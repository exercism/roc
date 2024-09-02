module [squareOfSum, sumOfSquares, differenceOfSquares]

sum : U64 -> U64
sum = \number ->
    number * (number + 1) // 2

squareOfSum : U64 -> U64
squareOfSum = \number ->
    s = sum number
    s * s

sumOfSquares : U64 -> U64
sumOfSquares = \number ->
    s = sum number
    s * (2 * number + 1) // 3

differenceOfSquares : U64 -> U64
differenceOfSquares = \number ->
    (squareOfSum number) - (sumOfSquares number)
