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
    toList,
    union,
]

Element : U64

CustomSet := { items : List Element } implements [Eq]

contains : CustomSet, Element -> Bool
contains = \@CustomSet { items }, element ->
    items |> List.contains element

difference : CustomSet, CustomSet -> CustomSet
difference = \@CustomSet { items: items1 }, @CustomSet { items: items2 } ->
    items = items1 |> List.dropIf \item -> items2 |> List.contains item
    @CustomSet { items }

fromList : List Element -> CustomSet
fromList = \list ->
    when list |> List.sortAsc is
        [] -> @CustomSet { items: [] }
        [first, .. as rest] ->
            items =
                rest
                |> List.walk { items: [first], previous: first } \state, item ->
                    if item == state.previous then
                        state
                    else
                        { items: state.items |> List.append item, previous: item }
                |> .items
            @CustomSet { items }

insert : CustomSet, Element -> CustomSet
insert = \@CustomSet { items }, element ->
    items |> List.append element |> List.sortAsc |> fromList

intersection : CustomSet, CustomSet -> CustomSet
intersection = \@CustomSet { items: items1 }, @CustomSet { items: items2 } ->
    items = items1 |> List.keepIf \item -> items2 |> List.contains item
    @CustomSet { items }

isDisjointWith : CustomSet, CustomSet -> Bool
isDisjointWith = \set1, set2 ->
    set1 |> intersection set2 |> isEmpty

isEmpty : CustomSet -> Bool
isEmpty = \@CustomSet { items } ->
    items |> List.isEmpty

isEq : CustomSet, CustomSet -> Bool
isEq = \@CustomSet { items: items1 }, @CustomSet { items: items2 } ->
    items1 == items2 # items list is always sorted

isSubsetOf : CustomSet, CustomSet -> Bool
isSubsetOf = \@CustomSet { items: items1 }, @CustomSet { items: items2 } ->
    items1 |> List.all \item -> items2 |> List.contains item

toList : CustomSet -> List Element
toList = \@CustomSet { items } ->
    items

union : CustomSet, CustomSet -> CustomSet
union = \set1, set2 ->
    set1 |> toList |> List.concat (set2 |> toList) |> fromList
