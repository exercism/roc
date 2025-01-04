module [
    contains,
    difference,
    from_list,
    insert,
    intersection,
    is_disjoint_with,
    is_empty,
    is_eq,
    is_subset_of,
    to_list,
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

from_list : List Element -> CustomSet
from_list = \list ->
    crash "Please implement the 'from_list' function"

insert : CustomSet, Element -> CustomSet
insert = \set, element ->
    crash "Please implement the 'insert' function"

intersection : CustomSet, CustomSet -> CustomSet
intersection = \set1, set2 ->
    crash "Please implement the 'intersection' function"

is_disjoint_with : CustomSet, CustomSet -> Bool
is_disjoint_with = \set1, set2 ->
    crash "Please implement the 'is_disjoint_with' function"

is_empty : CustomSet -> Bool
is_empty = \set ->
    crash "Please implement the 'is_empty' function"

is_eq : CustomSet, CustomSet -> Bool
is_eq = \set1, set2 ->
    crash "Please implement the 'is_eq' function"

is_subset_of : CustomSet, CustomSet -> Bool
is_subset_of = \set1, set2 ->
    crash "Please implement the 'is_subset_of' function"

to_list : CustomSet -> List Element
to_list = \set ->
    crash "Please implement the 'to_list' function"

union : CustomSet, CustomSet -> CustomSet
union = \set1, set2 ->
    crash "Please implement the 'union' function"
