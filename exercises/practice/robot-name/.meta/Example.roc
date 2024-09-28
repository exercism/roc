module [createFactory, createRobot, name]

import rand.Random

## A factory is used to create robots, and hold state such as the
## existing robot names and the current random state
Factory := {
    existingNames : Set Str,
    state : Random.State U32,
}

## A robot with a name composed of two letters followed by three digits
Robot := {
    name : Str,
}

createFactory : { seed : U32 } -> Factory
createFactory = \{ seed } ->
    existingNames = Set.empty {}
    @Factory { state: Random.seed seed, existingNames }

createRobot : Factory -> { robot : Robot, updatedFactory : Factory }
createRobot = \@Factory { state, existingNames } ->
    { updatedState, string: twoLetters } =
        randomString {
            state,
            generator: Random.u32 'A' 'Z',
            length: 2,
        }
    { updatedState: updatedState2, string: threeDigits } =
        randomString {
            state: updatedState,
            generator: Random.u32 '0' '9',
            length: 3,
        }
    possibleName = "$(twoLetters)$(threeDigits)"

    if existingNames |> Set.contains possibleName then
        @Factory { existingNames, state: updatedState2 } |> createRobot
    else
        updatedFactory = @Factory {
            existingNames: existingNames |> Set.insert possibleName,
            state: updatedState2,
        }
        robot = @Robot { name: possibleName }
        { robot, updatedFactory }

name : Robot -> Str
name = \@Robot { name: uniqueName } ->
    uniqueName

randomString : { state : Random.State U32, generator : Random.Generator U32 U32, length : U64 } -> { updatedState : Random.State U32, string : Str }
randomString = \{ state, generator, length } ->
    List.range { start: At 0, end: Before length }
    |> List.walk { state, characters: [] } \walk, _ ->
        random = generator walk.state
        updatedState = random.state
        characters = walk.characters |> List.append (random.value |> Num.toU8)
        { state: updatedState, characters }
    |> \{ state: updatedState, characters } ->
        when characters |> Str.fromUtf8 is
            Ok string -> { updatedState, string }
            Err (BadUtf8 _ _) -> crash "Unreachable: characters are all ASCII"
