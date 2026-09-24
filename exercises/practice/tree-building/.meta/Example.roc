Tree := { id : U64, children : List(Tree) ?? [] }.{
	is_eq : _

	Record : { id : U64, parent_id : U64 }

	from_records : List(Record) -> Try(Tree, [EmptyRecords, InvalidId, InvalidParent])
	from_records = |records| {
		if records.is_empty() {
			return Err(EmptyRecords)
		}

		sorted = records.sort_with(|a, b| a.id.order_relative_to(b.id))
		_ = sorted.fold_try(
			0.U64,
			|expected_id, record| {
				if record.id != expected_id {
					Err(InvalidId)
				} else if (record.id == 0 and record.parent_id != 0) or (record.id > 0 and record.parent_id >= record.id) {
					Err(InvalidParent)
				} else {
					Ok(expected_id + 1)
				}
			},
		)?

		# Exclude the root's self-reference. Sorted records keep siblings in ID order.
		children_by_parent = sorted.drop_first(1).fold(
			Dict.empty(),
			|children, record| {
				children.update(
					record.parent_id,
					|existing| {
						Ok((existing ?? []).append(record.id))
					},
				)
			},
		)
		Ok(build_tree(0, children_by_parent))
	}
}

build_tree : U64, Dict(U64, List(U64)) -> Tree
build_tree = |id, children_by_parent| {
	child_ids = children_by_parent.get(id) ?? []
	{
		id,
		children: child_ids.map(|child_id| build_tree(child_id, children_by_parent)),
	}
}
