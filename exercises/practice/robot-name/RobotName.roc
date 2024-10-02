module [createFactory, createRobot, boot, reset, getName, getFactory]

import rand.Random

## A factory is used to create robots, and hold state such as the existing robot
## names and the current random state
Factory := {
    # TODO: change this opaque type however you need
    todo1 : U64,
    todo2 : U64,
    todo3 : U64,
    # etc.
}

## A robot must either have no name or a name composed of two letters followed
## by three digits
Robot := {
    # TODO: change this opaque type however you need
    todo4 : U64,
    todo5 : U64,
    todo6 : U64,
    # etc.
}

createFactory : { seed : U32 } -> Factory
createFactory = \{ seed } ->
    crash "Please implement the 'createFactory' function"

createRobot : Factory -> Robot
createRobot = \factory ->
    crash "Please implement the 'createRobot' function"

boot : Robot -> Robot
boot = \robot ->
    crash "Please implement the 'boot' function"

reset : Robot -> Robot
reset = \robot ->
    crash "Please implement the 'reset' function"

getName : Robot -> Result Str _
getName = \robot ->
    crash "Please implement the 'getName' function"

getFactory : Robot -> Factory
getFactory = \robot ->
    crash "Please implement the 'getFactory' function"
