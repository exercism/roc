module [measure]

## Breadth-First Search finds the shortest path from the `start` node to any successful
## node (i.e., such that `success node == Bool.true`). The `neighbors` function must
## return the list of direct neighbors of a given node.
bfs : { start : a, neighbors : a -> List a, success : a -> Bool }
    ->
    Result (List a) [NoPathExists] where a implements Hash & Eq
bfs = \{ start, neighbors, success } ->
    help = \toVisit, visited, from ->
        when toVisit is
            [] -> Err NoPathExists
            [node, .. as restToVisit] ->
                if visited |> Set.contains node then
                    help restToVisit visited from
                else if success node then
                    pathBackToStart = \path, step ->
                        updatedPath = path |> List.append step
                        when from |> Dict.get step is
                            Ok previous -> pathBackToStart updatedPath previous
                            Err KeyNotFound -> updatedPath
                    pathBackToStart [] node |> List.reverse |> Ok
                    else

                neighorNodes = neighbors node
                newFrom =
                    neighorNodes
                    |> List.dropIf \neighbor -> visited |> Set.contains neighbor
                    |> List.map \neighbor -> (neighbor, node)
                    |> Dict.fromList
                updatedFrom = from |> Dict.insertAll newFrom
                updatedVisited = visited |> Set.insert node
                updatedToVisit = restToVisit |> List.concat neighorNodes
                help updatedToVisit updatedVisited updatedFrom
    help [start] (Set.empty {}) (Dict.empty {})

measure :
    { bucketOne : U64, bucketTwo : U64, goal : U64, startBucket : [One, Two] }
    ->
    Result { moves : U64, goalBucket : [One, Two], otherBucket : U64 } [NoSolutionExists]
measure = \{ bucketOne, bucketTwo, goal, startBucket } ->
    if goal == 0 then
        Ok { moves: 0, goalBucket: One, otherBucket: 0 }
        else

    start =
        when startBucket is
            One -> { volumeOne: bucketOne, volumeTwo: 0 }
            Two -> { volumeOne: 0, volumeTwo: bucketTwo }

    neighbors = \{ volumeOne, volumeTwo } ->
        volumeOneToTwo = Num.min volumeOne (bucketTwo - volumeTwo)
        volumeTwoToOne = Num.min volumeTwo (bucketOne - volumeOne)
        [
            { volumeOne: 0, volumeTwo }, # empty bucket one
            { volumeOne, volumeTwo: 0 }, # empty bucket two
            { volumeOne: bucketOne, volumeTwo }, # fill bucket one
            { volumeOne, volumeTwo: bucketTwo }, # fill bucket two
            {
                # pour bucket one into bucket two
                volumeOne: volumeOne - volumeOneToTwo,
                volumeTwo: volumeTwo + volumeOneToTwo,
            },
            {
                # pour bucket two into bucket one
                volumeOne: volumeOne + volumeTwoToOne,
                volumeTwo: volumeTwo - volumeTwoToOne,
            },
        ]
        |> List.dropIf \{ volumeOne: v1, volumeTwo: v2 } ->
            (v1 == volumeOne && v2 == volumeTwo) # no change
            ||
            # forbidden move: cannot end up with the starting bucket empty and
            # the other bucket full
            when startBucket is
                One -> v1 == 0 && v2 == bucketTwo
                Two -> v1 == bucketOne && v2 == 0

    success = \{ volumeOne, volumeTwo } -> volumeOne == goal || volumeTwo == goal

    when bfs { start, neighbors, success } is
        Ok [.. as rest, last] ->
            Ok {
                moves: List.len rest + 1,
                goalBucket: if last.volumeOne == goal then One else Two,
                otherBucket: if last.volumeOne == goal then last.volumeTwo else last.volumeOne,
            }

        _ -> Err NoSolutionExists
