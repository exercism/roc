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
		crash "Please implement the 'modifier' function"
	}

	ability : Random.Generator(U8)
	ability = {
		crash "Please implement the 'ability' function"
	}

	generate : Random.Generator(DndCharacter)
	generate = {
		crash "Please implement the 'generate' function"
	}
}
