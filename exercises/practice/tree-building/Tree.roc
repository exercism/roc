Tree := { id : U64, children : List(Tree) ?? [] }.{
	is_eq : _

	Record : { id : U64, parent_id : U64 }

	## This function passes all the tests, but it's slow and ugly.
	## Try to improve it gradually.
	from_records : List(Record) -> Try(Tree, [EmptyRecords, InvalidId, InvalidParent])
	from_records = |records| {
		if records.len() == 0 {
			Err(EmptyRecords)
		} else {
			xs = records.sort_with(|a, b| a.id.order_relative_to(b.id))
			var $n = 0.U64
			for r in xs {
				if r.id == $n {
					var $count = 0
					for r2 in records {
						if r2.id == r.id {
							$count = $count + 1
						}
					}
					if $count == 1 {
						if r.id == 0 {
							if r.parent_id != 0 {
								return Err(InvalidParent)
							}
						} else {
							if r.parent_id < r.id {
								var $found = Bool.False
								for r3 in records {
									if r3.id == r.parent_id {
										$found = Bool.True
									}
								}
								if $found == Bool.False {
									return Err(InvalidParent)
								}
							} else {
								return Err(InvalidParent)
							}
						}
					} else {
						return Err(InvalidId)
					}
				} else {
					return Err(InvalidId)
				}
				$n = $n + 1
			}

			f : U64 -> Tree
			f = |x| {
				var $tmp = []
				for r in records.sort_with(|a, b| a.id.order_relative_to(b.id)) {
					if r.id != 0 {
						if r.parent_id == x {
							$tmp = $tmp.append(r.id)
						}
					}
				}
				var $result = []
				for x2 in $tmp {
					for r in records {
						if r.id == x2 {
							$result = $result.append(f(r.id))
						}
					}
				}
				{ id: x, children: $result }
			}
			Ok(f(0))
		}
	}
}
