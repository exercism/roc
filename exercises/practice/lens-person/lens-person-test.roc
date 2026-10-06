# Adapted from the Haskell track's lens-person tests:
# https://github.com/exercism/haskell/blob/main/exercises/practice/lens-person/test/Tests.hs

import Person

test_person : Person
test_person = {
	name: { forenames: "Jane Joanna", surname: "Doe" },
	birth: {
		born_at: { street: "Longway", house_number: 1024, place: "Springfield", country: "United States" },
		born_on: { year: 1984, month: 4, day: 12 },
	},
	address: { street: "Shortlane", house_number: 2, place: "Fallmeadow", country: "Canada" },
}

# Read the birth street
expect {
	test_person.birth.street() == "Longway"
}

# Read a different birth street
expect {
	birth = { ..test_person.birth, born_at: { ..test_person.birth.born_at, street: "Queen Street" } }
	birth.street() == "Queen Street"
}

# Change only the current street
expect {
	result = test_person.set_current_street("Middleroad")
	result == { ..test_person, address: { ..test_person.address, street: "Middleroad" } }
}

# Setting the current street to itself preserves the person
expect {
	test_person.set_current_street("Shortlane") == test_person
}

# The latest street replacement wins
expect {
	test_person.set_current_street("First").set_current_street("Second") == test_person.set_current_street("Second")
}

# Change only the birth month
expect {
	result = test_person.set_birth_month(9)
	result == { ..test_person, birth: { ..test_person.birth, born_on: { year: 1984, month: 9, day: 12 } } }
}

# January and December are valid months
expect {
	[1, 12].all(
		|month| {
			test_person.set_birth_month(month) == { ..test_person, birth: { ..test_person.birth, born_on: { year: 1984, month, day: 12 } } }
		},
	)
}

# Setting the birth month to itself preserves the person
expect {
	test_person.set_birth_month(4) == test_person
}

# Preserve a different birth year and day
expect {
	person = { ..test_person, birth: { ..test_person.birth, born_on: { year: 2000, month: 1, day: 28 } } }
	person.set_birth_month(2) == { ..person, birth: { ..person.birth, born_on: { year: 2000, month: 2, day: 28 } } }
}

# Transform both street names and preserve all other fields
expect {
	result = test_person.rename_streets(Str.with_ascii_uppercased)
	result == {
		..test_person,
		birth: { ..test_person.birth, born_at: { ..test_person.birth.born_at, street: "LONGWAY" } },
		address: { ..test_person.address, street: "SHORTLANE" },
	}
}

# Apply a custom transform exactly once to each street
expect {
	result = test_person.rename_streets(|name| "New ${name}!")
	result == {
		..test_person,
		birth: { ..test_person.birth, born_at: { ..test_person.birth.born_at, street: "New Longway!" } },
		address: { ..test_person.address, street: "New Shortlane!" },
	}
}

# An identity transform preserves the person
expect {
	test_person.rename_streets(|name| name) == test_person
}

# Independent updates compose
expect {
	result = test_person.set_current_street("Middleroad").set_birth_month(9)
	result == {
		..test_person,
		birth: { ..test_person.birth, born_on: { year: 1984, month: 9, day: 12 } },
		address: { ..test_person.address, street: "Middleroad" },
	}
}

# Preserve Unicode in both street names
expect {
	person = {
		..test_person,
		birth: { ..test_person.birth, born_at: { ..test_person.birth.born_at, street: "Érables" } },
		address: { ..test_person.address, street: "桜通り" },
	}
	person.rename_streets(|street_name| "${street_name}!") == {
		..person,
		birth: { ..person.birth, born_at: { ..person.birth.born_at, street: "Érables!" } },
		address: { ..person.address, street: "桜通り!" },
	}
}
