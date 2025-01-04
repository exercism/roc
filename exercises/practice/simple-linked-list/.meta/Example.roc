module [from_list, to_list, push, pop, reverse, len]

SimpleLinkedList : [Nil, Cons U64 SimpleLinkedList]

from_list : List U64 -> SimpleLinkedList
from_list = \list ->
    list |> List.walk Nil push

to_list : SimpleLinkedList -> List U64
to_list = \linked_list ->
    when linked_list is
        Nil -> []
        Cons head tail -> tail |> to_list |> List.append head

push : SimpleLinkedList, U64 -> SimpleLinkedList
push = \linked_list, item ->
    Cons item linked_list

pop : SimpleLinkedList -> Result { value : U64, linked_list : SimpleLinkedList } [LinkedListWasEmpty]
pop = \linked_list ->
    when linked_list is
        Nil -> Err LinkedListWasEmpty
        Cons head tail -> Ok { value: head, linked_list: tail }

reverse : SimpleLinkedList -> SimpleLinkedList
reverse = \linked_list ->
    help = \result, rest ->
        when rest is
            Nil -> result
            Cons head tail -> help (result |> push head) tail
    help Nil linked_list

len : SimpleLinkedList -> U64
len = \linked_list ->
    when linked_list is
        Nil -> 0
        Cons _ tail -> 1 + len tail
