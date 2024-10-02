module [createFactory, createRobot, boot, reset, getName, getFactory]

import rand.Random

## A factory is used to create robots, and hold state such as the existing robot
## names and the current random state
Factory := {
    existingNames : Set Str,
    state : Random.State U32,
}

## A robot must either have no name or a name composed of two letters followed
## by three digits
Robot := {
    maybeName : Result Str [NoName],
    factory : Factory,
}

createFactory : { seed : U32 } -> Factory
createFactory = \{ seed } ->
    @Factory { state: Random.seed seed, existingNames: Set.empty {} }

createRobot : Factory -> Robot
createRobot = \factory ->
    @Robot { maybeName: Err NoName, factory }

boot : Robot -> Robot
boot = \robot ->
    when robot |> getName is
        Ok _ -> robot
        Err NoName -> robot |> generateRandomName

reset : Robot -> Robot
reset = \robot ->
    resetRobot =
        when robot |> getName is
            Err NoName -> robot
            Ok nameToRemove ->
                factory = robot |> getFactory |> removeName nameToRemove
                @Robot { maybeName: Err NoName, factory }

    resetRobot |> boot

getName : Robot -> Result Str [NoName]
getName = \@Robot { maybeName } ->
    maybeName

getFactory : Robot -> Factory
getFactory = \@Robot { factory } ->
    factory

generateRandomName : Robot -> Robot
generateRandomName = \@Robot { maybeName, factory } ->
    (@Factory { state, existingNames }) = factory
    { updatedState, string: twoLetters } = randomString { state, generator: Random.u32 'A' 'Z', length: 2 }
    { updatedState: updatedState2, string: threeDigits } = randomString { state: updatedState, generator: Random.u32 '0' '9', length: 3 }
    possibleName = "$(twoLetters)$(threeDigits)"

    if existingNames |> Set.contains possibleName then
        numberOfPossibleNames = 26 * 26 * 10 * 10 * 10
        if existingNames |> Set.len == numberOfPossibleNames then
            # better crash than run into an infinite loop
            crash "Too many robots, we have run out of possible names!"
        else
            updatedFactory = @Factory { existingNames, state: updatedState2 }
            generateRandomName (@Robot { maybeName, factory: updatedFactory })
    else
        updatedFactory = @Factory {
            existingNames: existingNames |> Set.insert possibleName,
            state: updatedState2,
        }
        @Robot { maybeName: Ok possibleName, factory: updatedFactory }

removeName : Factory, Str -> Factory
removeName = \@Factory { state, existingNames }, robotName ->
    @Factory { state, existingNames: existingNames |> Set.remove robotName }

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
