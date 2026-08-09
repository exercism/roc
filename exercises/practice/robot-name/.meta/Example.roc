import random.Random

RobotName :: {}.{

	## A factory is used to create robots, and holds state such as the existing
	## robot names and the current random state
	Factory :: {
		existing_names : Set(Str),
		random_state : Random.State,
	}.{
		new : { seed : U32 } -> Factory
		new = |{ seed }| {
			{ random_state: Random.seed(seed), existing_names: Set.empty() }
		}

		build_robot : Factory -> Robot
		build_robot = |factory| {
			{ maybe_name: Err(NoName), factory }
		}
	}

	## A robot must either have no name or a name composed of two letters
	## followed by three digits
	Robot :: {
		maybe_name : Try(Str, [NoName]),
		factory : Factory,
	}.{
		boot : Robot -> Robot
		boot = |robot| {
			match robot.maybe_name {
				Ok(_) => robot
				Err(NoName) => robot |> generate_random_name
			}
		}

		factory_reset : Robot -> Robot
		factory_reset = |robot| {
			match robot.maybe_name {
				Err(NoName) => robot
				Ok(name_to_remove) => {
					factory = robot.get_factory() |> remove_name(name_to_remove)
					{ maybe_name: Err(NoName), factory }
				}
			}
		}

		get_name : Robot -> Try(Str, [NoName, ..])
		get_name = |robot| {
			robot.maybe_name.map_err(|NoName| NoName)
		}

		get_factory : Robot -> Factory
		get_factory = |robot| {
			robot.factory
		}
	}
}

generate_random_name : Robot -> Robot
generate_random_name = |Robot.({ maybe_name, factory })| {
	letter_generator = Random.bounded_u8('A', 'Z')
	digit_generator = Random.bounded_u8('0', '9')
	robot_name_generator = {
		letters_gen = Random.list(letter_generator, 2)
		digits_gen = Random.list(digit_generator, 3)
		Random.map2(
			letters_gen,
			digits_gen,
			|letters, digits| {
				List.concat(letters, digits) |> Str.from_utf8 ?? {
					crash "Unreachable: ASCII is always valid UTF-8"
				}
			},
		)
	}
	{ value: possible_name, state: updated_state } = Random.step(factory.random_state, robot_name_generator)

	if factory.existing_names.contains(possible_name) {
		number_of_possible_names = 26 * 26 * 10 * 10 * 10
		if factory.existing_names.len() == number_of_possible_names {
			# better crash than run into an infinite loop
			crash "Too many robots, we have run out of possible names!"
		} else {
			updated_factory = { existing_names: factory.existing_names, random_state: updated_state }
			generate_random_name({ maybe_name, factory: updated_factory })
		}
	} else {
		updated_factory = {
			existing_names: factory.existing_names.insert(possible_name),
			random_state: updated_state,
		}
		{ maybe_name: Ok(possible_name), factory: updated_factory }
	}
}

remove_name : Factory, Str -> Factory
remove_name = |Factory.{ random_state, existing_names }, robot_name| {
	{ random_state, existing_names: existing_names.remove(robot_name) }
}
