module [fromPov, pathTo]

Tree : [Empty, Node { label : Str, children : Set Tree }]

## Return all nodes on the path from the target node up to the root.
## If the node is not found, Err NotFound is returned.
nodesToRoot : Tree, Str -> Result (List Tree) [NotFound]
nodesToRoot = \tree, label ->
    when tree is
        Empty -> Err NotFound
        Node node ->
            if node.label == label then
                Ok [Node node]
            else
                node.children
                |> Set.walkUntil (Err NotFound) \state, child ->
                    when child |> nodesToRoot label is
                        Ok subPath -> subPath |> List.append (Node node) |> Ok |> Break
                        Err NotFound -> state |> Continue

## Drop the node with the given label, if it exists
drop : Tree, Str -> Tree
drop = \tree, label ->
    when tree is
        Empty -> Empty
        Node node ->
            if node.label == label then
                Empty
            else
                filteredChildren =
                    node.children
                    |> Set.map \child -> drop child label
                    |> Set.dropIf \child -> child == Empty
                Node { label: node.label, children: filteredChildren }

## Return the tree from the point of view of the node with the given label.
## Return Err NotFound if no such node is found.
fromPov : Tree, Str -> Result Tree [NotFound]
fromPov = \tree, from ->
    rootPath : List Tree
    rootPath = tree |> nodesToRoot? from
    when rootPath |> List.first is
        Err ListWasEmpty -> crash "Unreachable: nodesToRoot cannot return Ok []"
        Ok Empty -> crash "Unreachable: target cannot be Empty"
        Ok (Node target) ->
            parent = rootPath |> List.get 1 |> Result.withDefault Empty
            when parent is
                Empty -> Ok tree # the target node is already the root of the tree
                Node parentNode ->
                    treeWithoutTarget = tree |> drop from
                    fromParentPov = treeWithoutTarget |> fromPov? parentNode.label
                    newChildren = target.children |> Set.insert fromParentPov
                    Node { label: from, children: newChildren } |> Ok

## Find the list of nodes between the two given nodes and return their labels
## If either of these nodes don't exist, return Err NotFound
pathTo : Tree, Str, Str -> Result (List Str) [NotFound]
pathTo = \tree, from, to ->
    fromTree = tree |> fromPov? from
    fromTree
        |> nodesToRoot? to
        |> List.map \child ->
            when child is
                Empty -> crash "Unreachable: trees must never contain Empty children"
                Node node -> node.label
        |> Ok

