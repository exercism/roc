module [fromList, toList]

BinaryTree : [Nil, Node { value : U64, left : BinaryTree, right : BinaryTree }]

fromList : List U64 -> BinaryTree
fromList = \data ->
    data |> List.walk Nil insert

insert : BinaryTree, U64 -> BinaryTree
insert = \tree, value ->
    when tree is
        Nil -> Node { value, left: Nil, right: Nil }
        Node node ->
            if value <= node.value then
                Node { node & left: (node.left |> insert value) }
            else
                Node { node & right: (node.right |> insert value) }

toList : BinaryTree -> List U64
toList = \tree ->
    when tree is
        Nil -> []
        Node node ->
            node.left |> toList |> List.append node.value |> List.concat (node.right |> toList)
