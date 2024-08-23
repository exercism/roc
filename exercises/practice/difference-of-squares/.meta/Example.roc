module [squareOfSum, sumOfSquares, differenceOfSquares]

sum = \n ->
    n * (n + 1) / 2

squareOfSum = \n ->
    s = sum n
    s * s

sumOfSquares = \n ->
    s = sum n
    s * (2 * n + 1) / 3

differenceOfSquares = \n ->
    (squareOfSum n) - (sumOfSquares n)

