module [from_list, to_list]

BinaryTree : [Nil, Node { value : U64, left : BinaryTree, right : BinaryTree }]

from_list : List U64 -> BinaryTree
from_list = |data|
    data |> List.walk(Nil, insert)

insert : BinaryTree, U64 -> BinaryTree
insert = |tree, value|
    when tree is
        Nil -> Node({ value, left: Nil, right: Nil })
        Node(node) ->
            if value <= node.value then
                Node({ node & left: (node.left |> insert(value)) })
            else
                Node({ node & right: (node.right |> insert(value)) })

to_list : BinaryTree -> List U64
to_list = |tree|
    when tree is
        Nil -> []
        Node(node) ->
            node.left |> to_list |> List.append(node.value) |> List.concat((node.right |> to_list))
