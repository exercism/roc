Person := { name : Name, birth : Birth, address : Address }.{
	Name : { forenames : Str, surname : Str }

	Address : { street : Str, house_number : U64, place : Str, country : Str }

	Date : { year : I64, month : U8, day : U8 }

	Birth := { born_at : Address, born_on : Date }.{
		is_eq : _

		street : Birth -> Str
		street = |birth| {
			crash "Please implement the 'street' function"
		}
	}

	# The following line enables the default `is_eq` implementation
	is_eq : _

	set_current_street : Person, Str -> Person
	set_current_street = |person, new_street| {
		crash "Please implement the 'set_current_street' function"
	}

	set_birth_month : Person, U8 -> Person
	set_birth_month = |person, new_month| {
		crash "Please implement the 'set_birth_month' function"
	}

	rename_streets : Person, (Str -> Str) -> Person
	rename_streets = |person, rename| {
		crash "Please implement the 'rename_streets' function"
	}
}
