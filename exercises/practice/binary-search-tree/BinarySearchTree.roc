module [fromList, toList]

BinaryTree : [Nil, Node { value : U64, left : BinaryTree, right : BinaryTree }]

fromList : List U64 -> BinaryTree
fromList = \data ->
    crash "Please implement the 'fromList' function"

toList : BinaryTree -> List U64
toList = \tree ->
    crash "Please implement the 'toList' function"
