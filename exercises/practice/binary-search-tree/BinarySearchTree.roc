module [from_list, to_list]

BinaryTree : [Nil, Node { value : U64, left : BinaryTree, right : BinaryTree }]

from_list : List U64 -> BinaryTree
from_list = |data|
    crash("Please implement the 'from_list' function")

to_list : BinaryTree -> List U64
to_list = |tree|
    crash("Please implement the 'to_list' function")
