module [fromList, toList, push, pop, reverse, len]

SimpleLinkedList : {
    # TODO: change this type however you need
    todo : U64,
    todo2 : U64,
    todo3 : U64,
    # etc.
}

fromList : List U64 -> SimpleLinkedList
fromList = \list ->
    crash "Please implement the 'fromList' function"

toList : SimpleLinkedList -> List U64
toList = \linkedList ->
    crash "Please implement the 'toList' function"

push : SimpleLinkedList, U64 -> SimpleLinkedList
push = \linkedList, item ->
    crash "Please implement the 'push' function"

pop : SimpleLinkedList -> Result { value : U64, linkedList : SimpleLinkedList } _
pop = \linkedList ->
    crash "Please implement the 'pop' function"

reverse : SimpleLinkedList -> SimpleLinkedList
reverse = \linkedList ->
    crash "Please implement the 'reverse' function"

len : SimpleLinkedList -> U64
len = \linkedList ->
    crash "Please implement the 'len' function"
