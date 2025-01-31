module [measure]

## Breadth-First Search finds the shortest path from the `start` node to any successful
## node (i.e., such that `success node == Bool.true`). The `neighbors` function must
## return the list of direct neighbors of a given node.
bfs = |{ start, neighbors, success }|
    help = |to_visit, visited, from|
        when to_visit is
            [] -> Err(NoPathExists)
            [node, .. as rest_to_visit] ->
                if visited |> Set.contains(node) then
                    help(rest_to_visit, visited, from)
                else if success(node) then
                    path_back_to_start = |path, step|
                        updated_path = path |> List.append(step)
                        when from |> Dict.get(step) is
                            Ok(previous) -> path_back_to_start(updated_path, previous)
                            Err(KeyNotFound) -> updated_path
                    path_back_to_start([], node) |> List.reverse |> Ok
                else
                    neighbor_nodes = neighbors(node)
                    new_from =
                        neighbor_nodes
                        |> List.drop_if(|neighbor| visited |> Set.contains(neighbor))
                        |> List.map(|neighbor| (neighbor, node))
                        |> Dict.from_list
                    updated_from = from |> Dict.insert_all(new_from)
                    updated_visited = visited |> Set.insert(node)
                    updated_to_visit = rest_to_visit |> List.concat(neighbor_nodes)
                    help(updated_to_visit, updated_visited, updated_from)
    help([start], Set.empty({}), Dict.empty({}))

measure :
    { bucket_one : U64, bucket_two : U64, goal : U64, start_bucket : [One, Two] }
    ->
    Result { moves : U64, goal_bucket : [One, Two], other_bucket : U64 } [NoSolutionExists]
measure = |{ bucket_one, bucket_two, goal, start_bucket }|
    if goal == 0 then
        Ok({ moves: 0, goal_bucket: One, other_bucket: 0 })
    else
        start =
            when start_bucket is
                One -> { volume_one: bucket_one, volume_two: 0 }
                Two -> { volume_one: 0, volume_two: bucket_two }

        neighbors = |{ volume_one, volume_two }|
            volume_one_to_two = Num.min(volume_one, (bucket_two - volume_two))
            volume_two_to_one = Num.min(volume_two, (bucket_one - volume_one))
            [
                { volume_one: 0, volume_two }, # empty bucket one
                { volume_one, volume_two: 0 }, # empty bucket two
                { volume_one: bucket_one, volume_two }, # fill bucket one
                { volume_one, volume_two: bucket_two }, # fill bucket two
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
            |> List.drop_if(
                |{ volume_one: v1, volume_two: v2 }|
                    (v1 == volume_one and v2 == volume_two) # no change
                    or
                    # forbidden move: cannot end up with the starting bucket empty and
                    # the other bucket full
                    when start_bucket is
                        One -> v1 == 0 and v2 == bucket_two
                        Two -> v1 == bucket_one and v2 == 0,
            )

        success = |{ volume_one, volume_two }| volume_one == goal or volume_two == goal

        when bfs({ start, neighbors, success }) is
            Ok([.. as rest, last]) ->
                Ok(
                    {
                        moves: List.len(rest) + 1,
                        goal_bucket: if last.volume_one == goal then One else Two,
                        other_bucket: if last.volume_one == goal then last.volume_two else last.volume_one,
                    },
                )

            _ -> Err(NoSolutionExists)
