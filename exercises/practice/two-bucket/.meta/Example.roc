TwoBucket :: {}.{
	measure :
		{ bucket_one : U64, bucket_two : U64, goal : U64, start_bucket : [One, Two] } -> Try({ moves : U64, goal_bucket : [One, Two], other_bucket : U64 }, [NoSolutionExists])
	measure = |{ bucket_one, bucket_two, goal, start_bucket }| {
		if goal == 0 {
			Ok({ moves: 0, goal_bucket: One, other_bucket: 0 })
		} else {
			start = 
				match start_bucket {
					One => { volume_one: bucket_one, volume_two: 0 }
					Two => { volume_one: 0, volume_two: bucket_two }
				}

			neighbors = |{ volume_one, volume_two }| {
				volume_one_to_two = if volume_one < (bucket_two - volume_two) {
					volume_one
				} else {
					bucket_two - volume_two
				}
				volume_two_to_one = if volume_two < (bucket_one - volume_one) {
					volume_two
				} else {
					bucket_one - volume_one
				}
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
					.drop_if(
						|{ volume_one: v1, volume_two: v2 }| {
							(v1 == volume_one and v2 == volume_two) # no change
								or
								# forbidden move: cannot end up with the starting bucket empty and
								# the other bucket full
								match start_bucket {
									One => v1 == 0 and v2 == bucket_two
									Two => v1 == bucket_one and v2 == 0
								}
						},
					)
			}

			success = |{ volume_one, volume_two }| volume_one == goal or volume_two == goal

			match bfs({ start, neighbors, success }) {
				Ok(path) => {
					match path {
						[.. as rest, last] => {
							Ok(
								{
									moves: rest.len() + 1,
									goal_bucket: if last.volume_one == goal {
										One
									} else {
										Two
									},
									other_bucket: if last.volume_one == goal {
										last.volume_two
									} else {
										last.volume_one
									},
								},
							)
						}
						_ => Err(NoSolutionExists)
					}
				}

				_ => Err(NoSolutionExists)
			}
		}
	}
}

bfs = |{ start, neighbors, success }| {
	help = |to_visit, visited, from| {
		match to_visit {
			[] => Err(NoPathExists)
			[node, .. as rest_to_visit] => {
				if visited.contains(node) {
					help(rest_to_visit, visited, from)
				} else if success(node) {
					path_back_to_start = |path, step| {
						updated_path = path.append(step)
						match from.get(to_str(step)) {
							Ok(previous) => path_back_to_start(updated_path, previous)
							Err(KeyNotFound) => updated_path
						}
					}
					Ok(path_back_to_start([], node).rev())
				} else {
					neighbor_nodes = neighbors(node)
					updated_from = 
						neighbor_nodes
							.drop_if(|neighbor| visited.contains(neighbor))
							.fold(from, |acc_from, neighbor| acc_from.insert(to_str(neighbor), node))
					updated_visited = visited.insert(node)
					updated_to_visit = rest_to_visit.concat(neighbor_nodes)
					help(updated_to_visit, updated_visited, updated_from)
				}
			}
		}
	}
	help([start], Set.empty(), Dict.empty())
}

# TODO: remove to_str once records have a to_hash method
to_str = |{ volume_one, volume_two }| {
	volume_one.to_str().concat(volume_two.to_str())
}
