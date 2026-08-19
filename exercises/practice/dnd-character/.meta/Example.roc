## This exercise uses the https://github.com/kili-ilo/roc-random library
import random.Random

DndCharacter := {
	strength : U8,
	dexterity : U8,
	constitution : U8,
	intelligence : U8,
	wisdom : U8,
	charisma : U8,
	hitpoints : U8,
}.{
	modifier : U8 -> I8
	modifier = |constitution| {
		(
			(
				constitution.to_i8_try() ?? {
					crash "Unreachable"
				}
			) - 10
		).div_floor_by(2)
	}

	ability : Random.Generator(U8)
	ability = {
		dice_gen = Random.list(Random.bounded_u8(1, 6), 4)
		sum_without_min = |dice| dice.sum() - (
			dice.min() ?? {
				crash "Unreachable: cannot be empty, as there are always 4 dice"
			}
		)
		Random.map(dice_gen, sum_without_min)
	}

	generate : Random.Generator(DndCharacter)
	generate = {
		{
			strength: ability,
			dexterity: ability,
			constitution: ability,
			intelligence: ability,
			wisdom: ability,
			charisma: ability,
			hitpoints: Random.static(0),
		}.Random
			|> Random.map(
				|character| {
					{
						..character,
						hitpoints: (10.I8 + modifier(character.constitution)).to_u8_try() ?? 1,
					}
				},
			)
	}
}
