# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/dnd-character/canonical-data.json
# File last updated on 2026-08-10
app [main!] {
	pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.21.0/4rAQg8kUYZ3Vksr4qMQHpaFYNiHSn9GgS7gVxghd1XYV.tar.zst",
	random: "https://github.com/kili-ilo/roc-random/releases/download/0.9.1/4y2ZUECKuLohLfnxRmukt3wHCBMDYwkKDc2jLSmYz8NM.tar.zst",
}

import DndCharacter
import random.Random

# ability modifier for score 3 is -4
expect {
	result = DndCharacter.modifier(3)
	result == -4
}

# ability modifier for score 4 is -3
expect {
	result = DndCharacter.modifier(4)
	result == -3
}

# ability modifier for score 5 is -3
expect {
	result = DndCharacter.modifier(5)
	result == -3
}

# ability modifier for score 6 is -2
expect {
	result = DndCharacter.modifier(6)
	result == -2
}

# ability modifier for score 7 is -2
expect {
	result = DndCharacter.modifier(7)
	result == -2
}

# ability modifier for score 8 is -1
expect {
	result = DndCharacter.modifier(8)
	result == -1
}

# ability modifier for score 9 is -1
expect {
	result = DndCharacter.modifier(9)
	result == -1
}

# ability modifier for score 10 is 0
expect {
	result = DndCharacter.modifier(10)
	result == 0
}

# ability modifier for score 11 is 0
expect {
	result = DndCharacter.modifier(11)
	result == 0
}

# ability modifier for score 12 is +1
expect {
	result = DndCharacter.modifier(12)
	result == 1
}

# ability modifier for score 13 is +1
expect {
	result = DndCharacter.modifier(13)
	result == 1
}

# ability modifier for score 14 is +2
expect {
	result = DndCharacter.modifier(14)
	result == 2
}

# ability modifier for score 15 is +2
expect {
	result = DndCharacter.modifier(15)
	result == 2
}

# ability modifier for score 16 is +3
expect {
	result = DndCharacter.modifier(16)
	result == 3
}

# ability modifier for score 17 is +3
expect {
	result = DndCharacter.modifier(17)
	result == 3
}

# ability modifier for score 18 is +4
expect {
	result = DndCharacter.modifier(18)
	result == 4
}

# random ability is within range
expect {
	random_state = Random.seed(0)
	{ value: score, state: _updated_random_state } = DndCharacter.ability(random_state)
	score >= 3 and score <= 18
}

# random character is valid
expect {
	random_state = Random.seed(0)
	{ value: character, state: _updated_random_state } = DndCharacter.generate(random_state)
	character.strength >= 3 and character.strength <= 18
		and character.dexterity >= 3 and character.dexterity <= 18
			and character.constitution >= 3 and character.constitution <= 18
				and character.intelligence >= 3 and character.intelligence <= 18
					and character.wisdom >= 3 and character.wisdom <= 18
						and character.charisma >= 3 and character.charisma <= 18
							and character.hitpoints == (10.I8 + DndCharacter.modifier(character.constitution)).to_u8_try() ?? 1 # minimum HP = 1
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
