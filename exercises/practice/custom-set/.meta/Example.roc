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
    to_list,
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

from_list : List Element -> CustomSet
from_list = \list ->
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
    if items |> List.contains element then
        @CustomSet { items }
    else
        @CustomSet { items: items |> List.append element }

intersection : CustomSet, CustomSet -> CustomSet
intersection = \@CustomSet { items: items1 }, @CustomSet { items: items2 } ->
    items = items1 |> List.keepIf \item -> items2 |> List.contains item
    @CustomSet { items }

is_disjoint_with : CustomSet, CustomSet -> Bool
is_disjoint_with = \set1, set2 ->
    set1 |> intersection set2 |> is_empty

is_empty : CustomSet -> Bool
is_empty = \@CustomSet { items } ->
    items |> List.isEmpty

is_eq : CustomSet, CustomSet -> Bool
is_eq = \@CustomSet { items: items1 }, @CustomSet { items: items2 } ->
    items1 |> List.sortAsc == items2 |> List.sortAsc

is_subset_of : CustomSet, CustomSet -> Bool
is_subset_of = \@CustomSet { items: items1 }, @CustomSet { items: items2 } ->
    items1 |> List.all \item -> items2 |> List.contains item

to_list : CustomSet -> List Element
to_list = \@CustomSet { items } ->
    items

union : CustomSet, CustomSet -> CustomSet
union = \set1, set2 ->
    set1 |> to_list |> List.concat (set2 |> to_list) |> from_list