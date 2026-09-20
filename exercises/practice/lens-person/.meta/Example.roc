Person := { name : Name, birth : Birth, address : Address }.{
	Name : { forenames : Str, surname : Str }

	Address : { street : Str, house_number : U64, place : Str, country : Str }

	Date : { year : I64, month : U8, day : U8 }

	Birth := { born_at : Address, born_on : Date }.{
		is_eq : _

		street : Birth -> Str
		street = |birth| {
			birth.born_at.street
		}
	}

	# The following line enables the default `is_eq` implementation
	is_eq : _

	set_current_street : Person, Str -> Person
	set_current_street = |person, new_street| {
		person |> (address.compose(street).set)(new_street)
	}

	set_birth_month : Person, U8 -> Person
	set_birth_month = |person, new_month| {
		person |> (birth.compose(born_on).compose(month).set)(new_month)
	}

	rename_streets : Person, (Str -> Str) -> Person
	rename_streets = |person, rename| {
		updated = birth.compose(born_at).compose(street).over(person, rename)
		address.compose(street).over(updated, rename)
	}
}

Lens(whole, part) := { get : whole -> part, set : whole, part -> whole }.{
	compose : Lens(outer, inner), Lens(inner, part) -> Lens(outer, part)
	compose = |outer, inner| {
		{
			get: |whole| whole |> outer.get |> inner.get,
			set: |whole, value| {
				updated = whole |> outer.get |> (inner.set)(value)
				whole |> (outer.set)(updated)
			},
		}
	}

	over : Lens(whole, part), whole, (part -> part) -> whole
	over = |lens, whole, transform| {
		updated = whole |> lens.get |> transform
		whole |> (lens.set)(updated)
	}
}

address : Lens(Person, Person.Address)
address = {
	get: |person| person.address,
	set: |person, value| { ..person, address: value },
}

birth : Lens(Person, Person.Birth)
birth = {
	get: |person| person.birth,
	set: |person, value| { ..person, birth: value },
}

born_at : Lens(Person.Birth, Person.Address)
born_at = {
	get: |birth_info| birth_info.born_at,
	set: |birth_info, value| { ..birth_info, born_at: value },
}

born_on : Lens(Person.Birth, Person.Date)
born_on = {
	get: |birth_info| birth_info.born_on,
	set: |birth_info, value| { ..birth_info, born_on: value },
}

street : Lens(Person.Address, Str)
street = {
	get: |street_address| street_address.street,
	set: |street_address, value| { ..street_address, street: value },
}

month : Lens(Person.Date, U8)
month = {
	get: |date| date.month,
	set: |date, value| { ..date, month: value },
}
