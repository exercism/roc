module [measure]

## Breadth-First Search finds the shortest path from the `start` node to any successful
## node (i.e., such that `success node == Bool.true`). The `neighbors` function must
## return the list of direct neighbors of a given node.
bfs : { start : a, neighbors : a -> List a, success : a -> Bool }
    ->
    Result (List a) [NoPathExists] where a implements Hash & Eq
bfs = \{ start, neighbors, success } ->
    help = \to_visit, visited, from ->
        when to_visit is
            [] -> Err NoPathExists
            [node, .. as rest_to_visit] ->
                if visited |> Set.contains node then
                    help rest_to_visit visited from
                else if success node then
                    path_back_to_start = \path, step ->
                        updated_path = path |> List.append step
                        when from |> Dict.get step is
                            Ok previous -> path_back_to_start updated_path previous
                            Err KeyNotFound -> updated_path
                    path_back_to_start [] node |> List.reverse |> Ok
                    else

                neighbor_nodes = neighbors node
                new_from =
                    neighbor_nodes
                    |> List.dropIf \neighbor -> visited |> Set.contains neighbor
                    |> List.map \neighbor -> (neighbor, node)
                    |> Dict.fromList
                updated_from = from |> Dict.insertAll new_from
                updated_visited = visited |> Set.insert node
                updated_to_visit = rest_to_visit |> List.concat neighbor_nodes
                help updated_to_visit updated_visited updated_from
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
            One -> { volume_one: bucketOne, volume_two: 0 }
            Two -> { volume_one: 0, volume_two: bucketTwo }

    neighbors = \{ volume_one, volume_two } ->
        volume_one_to_two = Num.min volume_one (bucketTwo - volume_two)
        volume_two_to_one = Num.min volume_two (bucketOne - volume_one)
        [
            { volume_one: 0, volume_two }, # empty bucket one
            { volume_one, volume_two: 0 }, # empty bucket two
            { volume_one: bucketOne, volume_two }, # fill bucket one
            { volume_one, volume_two: bucketTwo }, # fill bucket two
            {
                # pour bucket one into bucket two
                volume_one: volume_one - volume_one_to_two,
                volume_two: volume_two + volume_one_to_two,
            },
            {
                # pour bucket two into bucket one
                volume_one: volume_one + volume_two_to_one,
                volume_two: volume_two - volume_two_to_one,
            },
        ]
        |> List.dropIf \{ volume_one: v1, volume_two: v2 } ->
            (v1 == volume_one && v2 == volume_two) # no change
            ||
            # forbidden move: cannot end up with the starting bucket empty and
            # the other bucket full
            when startBucket is
                One -> v1 == 0 && v2 == bucketTwo
                Two -> v1 == bucketOne && v2 == 0

    success = \{ volume_one, volume_two } -> volume_one == goal || volume_two == goal

    when bfs { start, neighbors, success } is
        Ok [.. as rest, last] ->
            Ok {
                moves: List.len rest + 1,
                goalBucket: if last.volume_one == goal then One else Two,
                otherBucket: if last.volume_one == goal then last.volume_two else last.volume_one,
            }

        _ -> Err NoSolutionExists