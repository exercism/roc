module [createFactory, createRobot, name]

import rand.Random

## A factory is used to create robots, and hold state such as the
## existing robot names and the current random state
Factory := {
    # TODO: change this opaque type however you need
    todo1 : U64,
    todo2 : U64,
    todo3 : U64,
    # etc.
}

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

createRobot : Factory -> { robot : Robot, updatedFactory : Factory }
createRobot = \factory ->
    crash "Please implement the 'createRobot' function"

name : Robot -> Str
name = \robot ->
    crash "Please implement the 'name' function"
