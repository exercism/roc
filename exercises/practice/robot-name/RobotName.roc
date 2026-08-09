import random.Random

RobotName :: {}.{

	## A factory is used to create robots, and holds state such as the existing
	## robot names and the current random state
	Factory :: {
		# TODO: change this opaque type however you need
	}.{
		new : { seed : U32 } -> Factory
		new = |{ seed }| {
			crash "Please implement the 'Factory.create' function"
		}

		build_robot : Factory -> Robot
		build_robot = |factory| {
			crash "Please implement the 'Factory.build_robot' function"
		}
	}

	## A robot must either have no name or a name composed of two letters
	## followed by three digits
	Robot :: {
		# TODO: change this opaque type however you need
	}.{
		boot : Robot -> Robot
		boot = |robot| {
			crash "Please implement the 'boot' function"
		}

		factory_reset : Robot -> Robot
		factory_reset = |robot| {
			crash "Please implement the 'factory_reset' function"
		}

		get_name : Robot -> Try(Str, _)
		get_name = |robot| {
			crash "Please implement the 'get_name' function"
		}

		get_factory : Robot -> Factory
		get_factory = |robot| {
			crash "Please implement the 'get_factory' function"
		}
	}
}
