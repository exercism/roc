app [main!] {
	pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.21.0/4rAQg8kUYZ3Vksr4qMQHpaFYNiHSn9GgS7gVxghd1XYV.tar.zst",
	random: "https://github.com/kili-ilo/roc-random/releases/download/0.9.0/CwDEAmyUMCsqW6dh4pxYnp7suUZAj5b5gpZuh7udtyE7.tar.zst",
}

import RobotName exposing [Factory, Robot]

### Let's start by testing the basic robot workflow

# A new robot must not have a name
expect {
	factory = Factory.new({ seed: 0 })
	robot = factory.build_robot()
	result = robot.get_name()
	result == NoName
}

# After the first boot, a robot must have a name
expect {
	factory = Factory.new({ seed: 0 })
	robot = factory.build_robot().boot()
	result = robot.get_name()
	result != NoName
}

# Rebooting a robot should leave its name unchanged
expect {
	factory = Factory.new({ seed: 0 })
	robot = factory.build_robot().boot()
	name1 = robot.get_name()
	name2 = robot.boot().get_name()
	name1 == name2
}

# After it is factory reset and booted, a robot must have a  name
expect {
	factory = Factory.new({ seed: 0 })
	robot = factory.build_robot().boot().factory_reset().boot()
	result = robot.get_name()
	result != NoName
}

# After it is factory reset and booted, a robot must have a new name. If by
# chance it is the same (you should buy a lottery ticket today), we can try
# again to get a new name. If it's the same again we can be pretty confident
# that there's a problem.
expect {
	factory = Factory.new({ seed: 0 })
	robot = factory.build_robot().boot()
	name1 = robot.get_name()
	name2 = robot.factory_reset().boot().get_name()
	name3 = robot.factory_reset().boot().factory_reset().boot().get_name()
	name1 != name2 or name1 != name3
}

# If you factory reset and boot a new robot it should have a name
expect {
	factory = Factory.new({ seed: 0 })
	robot = factory.build_robot().factory_reset().boot()
	result = robot.get_name()
	result != NoName
}

# Once created and booted, a robot's name must be 5 characters long
expect {
	factory = Factory.new({ seed: 0 })
	robot = factory.build_robot().boot()
	match robot.get_name() {
		Name(name) => name.to_utf8().len() == 5
		NoName => Bool.False
	}
}

### Next we will try to ensure that the random names are sufficiently diverse.
### For this, we will first create many robot names.

## Create many robots using a given random seed, and return their names
## encoded using Str.to_utf8.
## If the quantity is set to 1,000, it is enough to offer strong statistical
## guarantees in the tests below, for example the probability that any letter
## or digit is absent from all names is negligible.
generate_robot_names : { seed : U32, quantity : U64 } -> List(List(U8))
generate_robot_names = |{ seed, quantity }| {
	factory = Factory.new({ seed: seed })
	(0..<quantity)
		.fold(
			{ names: [], factory },
			|state, _| {
				robot = state.factory.build_robot().boot()
				name_utf8 =
					match robot.get_name() {
						Name(name) => name.to_utf8()
						NoName => {
							crash "A robot must have a name after the first boot"
						}
					}
				{
					names: state.names.append(name_utf8),
					factory: robot.get_factory(),
				}
			},
		)
		|> (|{ names, factory: _ }| names)
}

## many random robot names based on seed 0
many_names_0 : List(List(U8))
many_names_0 = generate_robot_names({ seed: 0, quantity: 1000 })

## many random robot names based on seed 1
many_names_1 : List(List(U8))
many_names_1 = generate_robot_names({ seed: 1, quantity: 1000 })

## The set of letters from 'A' to 'Z'
capital_letters : Set(U8)
capital_letters = ('A'..='Z') |> List.from_iter |> Set.from_list

# The first character of a robot's name must range from 'A' to 'Z'
expect {
	result = many_names_0.map_try(List.first)
	match result {
		Ok(chars) => Set.from_list(chars) == capital_letters
		Err(_) => Bool.False
	}
}

# The second character must also range from 'A' to 'Z'
expect {
	result = many_names_0.map_try(|name| name.get(1))
	match result {
		Ok(chars) => Set.from_list(chars) == capital_letters
		Err(OutOfBounds) => Bool.False
	}
}

## The set of digits from '0' to '9'
digits : Set(U8)
digits = ('0'..='9') |> List.from_iter |> Set.from_list

# The third character must range from '0' to '9'
expect {
	result = many_names_0.map_try(|name| name.get(2))
	match result {
		Ok(chars) => Set.from_list(chars) == digits
		Err(OutOfBounds) => Bool.False
	}
}

# The fourth character must range from '0' to '9'
expect {
	result = many_names_0.map_try(|name| name.get(3))
	match result {
		Ok(chars) => Set.from_list(chars) == digits
		Err(OutOfBounds) => Bool.False
	}
}

# The fifth character must range from '0' to '9'
expect {
	result = many_names_0.map_try(|name| name.get(4))
	match result {
		Ok(chars) => Set.from_list(chars) == digits
		Err(OutOfBounds) => Bool.False
	}
}

# The same seed must generate the same robot names
expect {
	new_names_0 = generate_robot_names({ seed: 0, quantity: 1000 })
	many_names_0 == new_names_0
}

# Different seeds must generate different robot names (to be precise, it's
# technically possible for the two lists to be identical, but the probability
# is negligible when the lists are long enough).
expect many_names_0 != many_names_1

# All robot names coming from the same factory must be unique
expect {
	unique_names = many_names_0 |> Set.from_list
	number_of_names = many_names_0.len()
	number_of_unique_names = unique_names.len()
	number_of_names == number_of_unique_names
}

### Finally, we will try to ensure that the characters are not linearly
### correlated within each name or across consecutive names. This does not
### guarantee that the names are truly random, but at least it should rule out
### many types of non-random sequences (e.g., such as simply incrementing a
### counter).

## The R² correlation coefficient, also known as the coefficient of determination,
## measures the degree of linear correlation between two lists of numbers.
## It ranges from -∞ to +1.0.
## When both lists are strongly linearly correlated, R² approaches +1.0.
## When both lists are long and independently drawn from the same random
## distribution, R² approaches -1.0.
r2_coeff : List(F64), List(F64) -> F64
r2_coeff = |numbers1, numbers2| {
	length = numbers1.len().to_f64()
	mean = numbers1.sum() / length
	subtract_mean = |val| val - mean
	square = |val| val * val
	# Total sum of squares (TSS)
	tss = numbers1.map(subtract_mean).map(square).sum()
	# Residual sum of squares (RSS)
	rss = numbers1.map2(numbers2, F64.minus).map(square).sum()
	epsilon = 1e-10 # to avoid division by zero
	1.0 - rss / (tss + epsilon)
}

# To speed up the correlation tests, we truncate the list of names
correlation_sample_size = 200

# It's not impossible for the random characters to be correlated by chance,
# but given 200 letters or digits, the probability that the correlation
# coefficient ends up greater than this threshold is negligible
r2_threshold = -0.25

seems_independent_enough_from : Try(List(U8), _), Try(List(U8), _) -> Bool
seems_independent_enough_from = |maybe_chars_1, maybe_chars_2| {
	match (maybe_chars_1, maybe_chars_2) {
		(Ok(chars1), Ok(chars2)) =>
			r2_coeff(chars1.map(U8.to_f64), chars2.map(U8.to_f64)) < r2_threshold
		_ => Bool.False
	}
}

# Characters within a name should not be correlated
expect {
	truncated_names_0 = many_names_0.take_first(correlation_sample_size)
	[0.U64, 1, 2, 3].join_map(
		|index1| {
			[1, 2, 3, 4].map(|index2| (index1, index2))
		},
	)
		.drop_if(|(index1, index2)| index1 >= index2)
		.all(
			|(index1, index2)| {
				maybe_chars = truncated_names_0.drop_last(1).map_try(|chars| chars.get(index1))
				maybe_chars_next = truncated_names_0.drop_first(1).map_try(|chars| chars.get(index2))
				maybe_chars |> seems_independent_enough_from(maybe_chars_next)
			},
		)
}

# Characters in consecutive names should not be correlated
expect {
	# we truncate the list to speed up the tests
	truncated_names_0 = many_names_0.take_first(correlation_sample_size)
	truncated_names_1 = many_names_0.drop_first(1).take_first(correlation_sample_size)
	[0.U64, 1, 2, 3, 4].join_map(
		|index1| {
			[0, 1, 2, 3, 4].map(|index2| (index1, index2))
		},
	)
		.all(
			|(index1, index2)| {
				maybe_chars_ = truncated_names_0.map_try(|chars| chars.get(index1))
				maybe_chars_next = truncated_names_1.map_try(|chars| chars.get(index2))
				maybe_chars_ |> seems_independent_enough_from(maybe_chars_next)
			},
		)
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
