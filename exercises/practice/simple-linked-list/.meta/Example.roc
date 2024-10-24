module [fromList, toList, push, pop, reverse, len]

SimpleLinkedList : [Nil, Cons U64 SimpleLinkedList]

fromList : List U64 -> SimpleLinkedList
fromList = \list ->
    list |> List.walk Nil push

toList : SimpleLinkedList -> List U64
toList = \linkedList ->
    when linkedList is
        Nil -> []
        Cons head tail -> tail |> toList |> List.append head

push : SimpleLinkedList, U64 -> SimpleLinkedList
push = \linkedList, item ->
    Cons item linkedList

pop : SimpleLinkedList -> Result { value : U64, linkedList : SimpleLinkedList } [LinkedListWasEmpty]
pop = \linkedList ->
    when linkedList is
        Nil -> Err LinkedListWasEmpty
        Cons head tail -> Ok { value: head, linkedList: tail }

reverse : SimpleLinkedList -> SimpleLinkedList
reverse = \linkedList ->
    help = \result, rest ->
        when rest is
            Nil -> result
            Cons head tail -> help (result |> push head) tail
    help Nil linkedList

len : SimpleLinkedList -> U64
len = \linkedList ->
    when linkedList is
        Nil -> 0
        Cons _ tail -> 1 + len tail
