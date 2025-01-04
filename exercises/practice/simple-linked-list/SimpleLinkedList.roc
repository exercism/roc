module [from_list, to_list, push, pop, reverse, len]

SimpleLinkedList : {
    # TODO: change this type however you need
    todo : U64,
    todo2 : U64,
    todo3 : U64,
    # etc.
}

from_list : List U64 -> SimpleLinkedList
from_list = \list ->
    crash "Please implement the 'from_list' function"

to_list : SimpleLinkedList -> List U64
to_list = \linked_list ->
    crash "Please implement the 'to_list' function"

push : SimpleLinkedList, U64 -> SimpleLinkedList
push = \linked_list, item ->
    crash "Please implement the 'push' function"

pop : SimpleLinkedList -> Result { value : U64, linked_list : SimpleLinkedList } _
pop = \linked_list ->
    crash "Please implement the 'pop' function"

reverse : SimpleLinkedList -> SimpleLinkedList
reverse = \linked_list ->
    crash "Please implement the 'reverse' function"

len : SimpleLinkedList -> U64
len = \linked_list ->
    crash "Please implement the 'len' function"
