app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
    rand: "https://github.com/lukewilliamboswell/roc-random/releases/download/0.2.1/mJSD8-uN-biRqa6CiqdN4-VJsKXxY8b1eFf6mFTe93A.tar.br",
}

main =
    Task.ok {}

import RobotName exposing [createFactory, createRobot, boot, reset, getName, getFactory]

### Let's start by testing the basic robot workflow

# A new robot must not have a name
expect
    factory = createFactory { seed: 0 }
    robot = factory |> createRobot
    result = robot |> getName
    result |> Result.isErr

# After the first boot, a robot must have a name
expect
    factory = createFactory { seed: 0 }
    robot = factory |> createRobot |> boot
    result = robot |> getName
    result |> Result.isOk

# Rebooting a robot should leave its name unchanged
expect
    factory = createFactory { seed: 0 }
    robot = factory |> createRobot |> boot
    name1 = robot |> getName
    name2 = robot |> boot |> getName
    name1 == name2

# After it is factory reset (which also reboots), a robot must have a  name
expect
    factory = createFactory { seed: 0 }
    robot = factory |> createRobot |> boot |> reset
    result = robot |> getName
    result |> Result.isOk

# After it is factory reset, a robot must have a new name. If by chance it
# is the same (you should buy a lottery ticket today), we can try again to get
# a new name. If it's the same again we can be pretty confident that there's a
# problem.
expect
    factory = createFactory { seed: 0 }
    robot = factory |> createRobot |> boot
    name1 = robot |> getName
    name2 = robot |> reset |> getName
    name3 = robot |> reset |> reset |> getName
    name1 != name2 || name1 != name3

# If you factory reset a new robot, since this includes a boot, the robot
# should have a name
expect
    factory = createFactory { seed: 0 }
    robot = factory |> createRobot |> reset
    result = robot |> getName
    result |> Result.isOk

# Once created, a robot's name must be 5 characters long
expect
    factory = createFactory { seed: 0 }
    robot = factory |> createRobot |> boot
    result = robot |> getName |> Result.try \n -> n |> Str.toUtf8 |> List.len |> Ok
    result == Ok 5

### Next we will try to ensure that the random names are sufficiently diverse.
### For this, we will first create many robot names.

## Create many robots using a given random seed, and return their names
## encoded using Str.toUtf8.
## The default quantity is 1,000, which is enough to offer strong statistical
## guarantees in the tests below, for example the probability that any letter
## or digit is absent from all names is negligible.
generateRobotNames : { seed : U32, quantity ? U64 } -> List (List U8)
generateRobotNames = \{ seed, quantity ? 1000 } ->
    factory = createFactory { seed }
    List.range { start: At 0, end: Before quantity }
    |> List.walk { names: [], factory } \state, _ ->
        robot = state.factory |> createRobot |> boot
        nameUtf8 =
            when robot |> getName is
                Ok name -> name |> Str.toUtf8
                Err NoName -> crash "A robot must have a name after the first boot"
        {
            names: state.names |> List.append nameUtf8,
            factory: robot |> getFactory,
        }
    |> .names

## many random robot names based on seed 0
manyNames0 : List (List U8)
manyNames0 = generateRobotNames { seed: 0 }

## many random robot names based on seed 1
manyNames1 : List (List U8)
manyNames1 = generateRobotNames { seed: 1 }

## The set of letters from 'A' to 'Z'
capitalLetters : Set U8
capitalLetters = List.range { start: At 'A', end: At 'Z' } |> Set.fromList

# The first character of a robot's name must range from 'A' to 'Z'
expect
    result = manyNames0 |> List.mapTry \names -> names |> List.get 0
    when result is
        Ok chars -> Set.fromList chars == capitalLetters
        Err OutOfBounds -> Bool.false

# The second character must also range from 'A' to 'Z'
expect
    result = manyNames0 |> List.mapTry \names -> names |> List.get 1
    when result is
        Ok chars -> Set.fromList chars == capitalLetters
        Err OutOfBounds -> Bool.false

## The set of digits from '0' to '9'
digits : Set U8
digits = List.range { start: At '0', end: At '9' } |> Set.fromList

# The third character must range from '0' to '9'
expect
    result = manyNames0 |> List.mapTry \names -> names |> List.get 2
    when result is
        Ok chars -> Set.fromList chars == digits
        Err OutOfBounds -> Bool.false

# The fourth character must range from '0' to '9'
expect
    result = manyNames0 |> List.mapTry \names -> names |> List.get 3
    when result is
        Ok chars -> Set.fromList chars == digits
        Err OutOfBounds -> Bool.false

# The fifth character must range from '0' to '9'
expect
    result = manyNames0 |> List.mapTry \names -> names |> List.get 4
    when result is
        Ok chars -> Set.fromList chars == digits
        Err OutOfBounds -> Bool.false

# The same seed must generate the same robot names
expect
    newNames0 = generateRobotNames { seed: 0 }
    manyNames0 == newNames0

# Different seeds must generate different robot names (to be precise, it's
# technically possible for the two lists to be identical, but the probability
# is negligible when the lists are long enough).
expect manyNames0 != manyNames1

# All robot names coming from the same factory must be unique
expect
    uniqueNames = manyNames0 |> Set.fromList
    numberOfNames = manyNames0 |> List.len
    numberOfUniqueNames = uniqueNames |> Set.len
    numberOfNames == numberOfUniqueNames

### Finally, we will try to ensure that the characters are not linearly
### correlated within each name or across consecutive names. This does not
### guarantee that the names are truly random, but at least it should rule out
### many types of non-random sequences (e.g., such as simply incrementing a
### counter).

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

# To speed up the correlation tests, we truncate the list of names
correlationSampleSize = 200

# It's not impossible for the random characters to be correlated by chance,
# but given 200 letters or digits, the probability that the correlation
# coefficient ends up greater than this threshold is negligible
r2Threshold = -0.25

seemsIndependentEnoughFrom = \maybeChars1, maybeChars2 ->
    when (maybeChars1, maybeChars2) is
        (Ok chars1, Ok chars2) ->
            r2Coeff (chars1 |> toFloats) (chars2 |> toFloats) < r2Threshold

        _ -> Bool.false # unreachable if names are 5 chars long

# Characters within a name should not be correlated
expect
    truncatedNames0 = manyNames0 |> List.takeFirst correlationSampleSize
    [0, 1, 2, 3, 4]
    |> List.joinMap \index1 -> [0, 1, 2, 3, 4] |> List.map \index2 -> (index1, index2)
    |> List.dropIf \(index1, index2) -> index1 == index2
    |> List.all \(index1, index2) ->
        maybeChars = truncatedNames0 |> List.dropLast 1 |> List.mapTry \chars -> chars |> List.get index1
        maybeCharsNext = truncatedNames0 |> List.dropFirst 1 |> List.mapTry \chars -> chars |> List.get index2
        maybeChars |> seemsIndependentEnoughFrom maybeCharsNext

# Characters in consecutive names should not be correlated
expect
    # we truncate the list to speed up the tests
    truncatedNames0 = manyNames0 |> List.takeFirst correlationSampleSize
    truncatedNames1 = manyNames0 |> List.dropFirst 1 |> List.takeFirst correlationSampleSize
    [0, 1, 2, 3, 4]
    |> List.joinMap \index1 -> [0, 1, 2, 3, 4] |> List.map \index2 -> (index1, index2)
    |> List.all \(index1, index2) ->
        maybeChars = truncatedNames0 |> List.mapTry \chars -> chars |> List.get index1
        maybeCharsNext = truncatedNames1 |> List.mapTry \chars -> chars |> List.get index2
        maybeChars |> seemsIndependentEnoughFrom maybeCharsNext
