##
## Example solution
##

FamilyTree := Dict(Str, List(Str)).{
	degree_of_separation : FamilyTree, Str, Str -> Try(U64, [NoKnownRelationship])
	degree_of_separation = |FamilyTree.(family_tree), person_a, person_b| {
		families = family_tree.to_list()
		neighbors = |person| {
			families.join_map(
				|(parent, children)| {
					if person == parent {
						children
					} else if children.contains(person) {
						# A child is connected to its parent and all its siblings
						children.append(parent)
					} else {
						[]
					}
				},
			)
		}

		search : List(Str), Set(Str), U64 -> Try(U64, [NoKnownRelationship, ..])
		search = |frontier, visited, distance| {
			if frontier.contains(person_b) {
				Ok(distance)
			} else if frontier.is_empty() {
				Err(NoKnownRelationship)
			} else {
				next = frontier.join_map(neighbors)
					|> Set.from_list
					|> Set.difference(visited)
				search(next.to_list(), visited.union(next), distance + 1)
			}
		}
		search([person_a], Set.from_list([person_a]), 0)
	}
}
