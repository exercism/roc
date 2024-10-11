module [
    contains,
    difference,
    fromList,
    insert,
    intersection,
    isDisjointWith,
    isEmpty,
    isEq,
    isSubsetOf,
    toList,
    union,
]

Element : U64

CustomSet := {
    # TODO: change this opaque type however you need
    todo : U64,
    todo2 : U64,
    todo3 : U64,
    # etc.
}
    implements [Eq]

contains : CustomSet, Element -> Bool
contains = \set, element ->
    crash "Please implement the 'contains' function"

difference : CustomSet, CustomSet -> CustomSet
difference = \set1, set2 ->
    crash "Please implement the 'difference' function"

fromList : List Element -> CustomSet
fromList = \list ->
    crash "Please implement the 'fromList' function"

insert : CustomSet, Element -> CustomSet
insert = \set, element ->
    crash "Please implement the 'insert' function"

intersection : CustomSet, CustomSet -> CustomSet
intersection = \set1, set2 ->
    crash "Please implement the 'intersection' function"

isDisjointWith : CustomSet, CustomSet -> Bool
isDisjointWith = \set1, set2 ->
    crash "Please implement the 'isDisjointWith' function"

isEmpty : CustomSet -> Bool
isEmpty = \set ->
    crash "Please implement the 'isEmpty' function"

isEq : CustomSet, CustomSet -> Bool
isEq = \set1, set2 ->
    crash "Please implement the 'isEq' function"

isSubsetOf : CustomSet, CustomSet -> Bool
isSubsetOf = \set1, set2 ->
    crash "Please implement the 'isSubsetOf' function"

toList : CustomSet -> List Element
toList = \set ->
    crash "Please implement the 'toList' function"

union : CustomSet, CustomSet -> CustomSet
union = \set1, set2 ->
    crash "Please implement the 'union' function"
