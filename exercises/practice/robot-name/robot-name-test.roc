app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
    rand: "https://github.com/lukewilliamboswell/roc-random/releases/download/0.2.1/mJSD8-uN-biRqa6CiqdN4-VJsKXxY8b1eFf6mFTe93A.tar.br",
}

main =
    Task.ok {}

import RobotName exposing [createFactory, createRobot, name]

## Create many robots using a given random seed, and return their names
## encoded using Str.toUtf8.
## The default quantity is 1,000, which is enough to offer strong statistical
## guarantees in the tests below, for example the probability that any letter
## or digit is absent from all names is negligible.
robotNames : { seed : U32, quantity ? U64 } -> List (List U8)
robotNames = \{ seed, quantity ? 1000 } ->
    factory = createFactory { seed }
    List.range { start: At 0, end: Before quantity }
    |> List.walk { robots: [], updatedFactory: factory } \state, _ ->
        { robot, updatedFactory } = state.updatedFactory |> createRobot
        { robots: state.robots |> List.append robot, updatedFactory }
    |> .robots
    |> List.map \robot -> robot |> name |> Str.toUtf8

## many random robot names based on seed 0
names0 : List (List U8)
names0 = robotNames { seed: 0 }

## many random robot names based on seed 1
names1 : List (List U8)
names1 = robotNames { seed: 1 }

## The set of letters from 'A' to 'Z'
capitalLetters : Set U8
capitalLetters = List.range { start: At 'A', end: At 'Z' } |> Set.fromList

## The set of digits from '0' to '9'
digits : Set U8
digits = List.range { start: At '0', end: At '9' } |> Set.fromList

## Convert a list of integers to F64s
toFloats : List (Num *) -> List F64
toFloats = \numbers ->
    numbers |> List.map Num.toF64

## The R² correlation coefficient, also known as the coefficient of determination,
## measures the degree of linear correlation between two lists of numbers.
## It ranges from -∞ to +1.0.
## When both lists are strongly linearly correlated, R² approaches +1.0.
## When both lists are long and independently drawn from the same random
## distribution, R² approaches -1.0.
r2Coeff : List F64, List F64 -> F64
r2Coeff = \numbers1, numbers2 ->
    length = numbers1 |> List.len |> Num.toF64
    mean = numbers1 |> List.sum |> Num.div length
    subtractMean = \val -> val - mean
    square = \val -> val * val
    # Total sum of squares (TSS)
    tss = numbers1 |> List.map subtractMean |> List.map square |> List.sum
    # Residual sum of squares (RSS)
    rss = numbers1 |> List.map2 numbers2 Num.sub |> List.map square |> List.sum
    epsilon = 1e-10 # to avoid division by zero
    1.0 - rss / (tss + epsilon)

# A robot's name must always be 5 characters long
expect
    result = names0 |> List.map List.len |> Set.fromList
    result == Set.single 5

# The first characters must range from 'A' to 'Z'
expect
    result = names0 |> List.mapTry \names -> names |> List.get 0
    when result is
        Ok chars -> Set.fromList chars == capitalLetters
        Err OutOfBounds -> Bool.false

# The second characters must also range from 'A' to 'Z'
expect
    result = names0 |> List.mapTry \names -> names |> List.get 1
    when result is
        Ok chars -> Set.fromList chars == capitalLetters
        Err OutOfBounds -> Bool.false

# The third characters must range from '0' to '9'
expect
    result = names0 |> List.mapTry \names -> names |> List.get 2
    when result is
        Ok chars -> Set.fromList chars == digits
        Err OutOfBounds -> Bool.false

# The fourth characters must range from '0' to '9'
expect
    result = names0 |> List.mapTry \names -> names |> List.get 3
    when result is
        Ok chars -> Set.fromList chars == digits
        Err OutOfBounds -> Bool.false

# The fifth characters must range from '0' to '9'
expect
    result = names0 |> List.mapTry \names -> names |> List.get 4
    when result is
        Ok chars -> Set.fromList chars == digits
        Err OutOfBounds -> Bool.false

# The same seed must generate the same robot names
expect
    newNames0 = robotNames { seed: 0 }
    names0 == newNames0

# Different seeds must generate different robot names (to be precise, it's
# technically possible for the two lists to be identical, but the probability
# is negligible when the lists are long enough).
expect names0 != names1

# All robot names coming from the same factory must be unique
expect
    uniqueNames = names0 |> Set.fromList
    numberOfNames = names0 |> List.len
    numberOfUniqueNames = uniqueNames |> Set.len
    numberOfNames == numberOfUniqueNames

# to speed up the correlation tests, we truncate the list of names
correlationSampleSize = 200

# it's not impossible for the random characters to be correlated by chance,
# but given 200 letters or digits, the probability that the correlation
# coefficient ends up greater than this threshold is negligible
r2Threshold = -0.25

# Characters within a name should not be correlated
expect
    truncatedNames0 = names0 |> List.takeFirst correlationSampleSize
    [0, 1, 2, 3, 4]
    |> List.joinMap \index1 -> [0, 1, 2, 3, 4] |> List.map \index2 -> (index1, index2)
    |> List.dropIf \(index1, index2) -> index1 == index2
    |> List.all \(index1, index2) ->
        maybeChars = truncatedNames0 |> List.dropLast 1 |> List.mapTry \chars -> chars |> List.get index1
        maybeCharsNext = truncatedNames0 |> List.dropFirst 1 |> List.mapTry \chars -> chars |> List.get index2
        when (maybeChars, maybeCharsNext) is
            (Ok chars, Ok charsNext) ->
                r2 = r2Coeff (chars |> toFloats) (charsNext |> toFloats)
                r2 < r2Threshold

            _ -> Bool.false

# Characters in consecutive names should not be correlated
expect
    # we truncate the list to speed up the tests
    truncatedNames0 = names0 |> List.takeFirst correlationSampleSize
    truncatedNames1 = names0 |> List.dropFirst 1 |> List.takeFirst correlationSampleSize
    [0, 1, 2, 3, 4]
    |> List.joinMap \index1 -> [0, 1, 2, 3, 4] |> List.map \index2 -> (index1, index2)
    |> List.all \(index1, index2) ->
        maybeChars = truncatedNames0 |> List.mapTry \chars -> chars |> List.get index1
        maybeCharsNext = truncatedNames1 |> List.mapTry \chars -> chars |> List.get index2
        when (maybeChars, maybeCharsNext) is
            (Ok chars, Ok charsNext) ->
                r2 = r2Coeff (chars |> toFloats) (charsNext |> toFloats)
                r2 < r2Threshold

            _ -> Bool.false
