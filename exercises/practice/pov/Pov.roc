module [fromPov, pathTo, isEquivalentTo]

Tree : [Empty, Node { label : Str, children : List Tree }]

## Are tree1 and tree2 identical, ignoring the order of the children?
isEquivalentTo : Tree, Tree -> Bool
isEquivalentTo = \tree1, tree2 ->
    crash "Please implement the 'isEquivalentTo' function"

## Return the tree from the point of view of the node with the given label.
## Return Err NotFound if no such node is found.
fromPov : Tree, Str -> Result Tree [NotFound]
fromPov = \tree, from ->
    crash "Please implement the 'fromPov' function"

## Return the labels of the nodes between the two given nodes
## If either of these nodes don't exist, return Err NotFound
pathTo : Tree, Str, Str -> Result (List Str) [NotFound]
pathTo = \tree, from, to ->
    crash "Please implement the 'pathTo' function"
