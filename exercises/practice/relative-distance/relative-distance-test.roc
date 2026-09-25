# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/relative-distance/canonical-data.json
# File last updated on 2026-09-25

import FamilyTree

## Direct parent-child relation
expect {
	family_tree = FamilyTree.(
		Dict.from_list([
			("Vera", ["Tomoko"]),
			("Tomoko", ["Aditi"]),
		]),
	)
	result = family_tree.degree_of_separation("Vera", "Tomoko")
	result == Ok(1)
}

## Sibling relationship
expect {
	family_tree = FamilyTree.(
		Dict.from_list([
			("Dalia", ["Olga", "Yassin"]),
		]),
	)
	result = family_tree.degree_of_separation("Olga", "Yassin")
	result == Ok(1)
}

## Two degrees of separation, grandchild
expect {
	family_tree = FamilyTree.(
		Dict.from_list([
			("Khadija", ["Mateo"]),
			("Mateo", ["Rami"]),
		]),
	)
	result = family_tree.degree_of_separation("Khadija", "Rami")
	result == Ok(2)
}

## Unrelated individuals
expect {
	family_tree = FamilyTree.(
		Dict.from_list([
			("Priya", ["Rami"]),
			("Kaito", ["Elif"]),
		]),
	)
	result = family_tree.degree_of_separation("Priya", "Kaito")
	result.is_err()
}

## Complex graph, cousins
expect {
	family_tree = FamilyTree.(
		Dict.from_list([
			("Aiko", ["Bao", "Carlos"]),
			("Bao", ["Dalia", "Elias"]),
			("Carlos", ["Fatima", "Gustavo"]),
			("Dalia", ["Hassan", "Isla"]),
			("Elias", ["Javier"]),
			("Fatima", ["Khadija", "Liam"]),
			("Gustavo", ["Mina"]),
			("Hassan", ["Noah", "Olga"]),
			("Isla", ["Pedro"]),
			("Javier", ["Quynh", "Ravi"]),
			("Khadija", ["Sofia"]),
			("Liam", ["Tariq", "Uma"]),
			("Mina", ["Viktor", "Wang"]),
			("Noah", ["Xiomara"]),
			("Olga", ["Yuki"]),
			("Pedro", ["Zane", "Aditi"]),
			("Quynh", ["Boris"]),
			("Ravi", ["Celine"]),
			("Sofia", ["Diego", "Elif"]),
			("Tariq", ["Farah"]),
			("Uma", ["Giorgio"]),
			("Viktor", ["Hana", "Ian"]),
			("Wang", ["Jing"]),
			("Xiomara", ["Kaito"]),
			("Yuki", ["Leila"]),
			("Zane", ["Mateo"]),
			("Aditi", ["Nia"]),
			("Boris", ["Oscar"]),
			("Celine", ["Priya"]),
			("Diego", ["Qi"]),
			("Elif", ["Rami"]),
			("Farah", ["Sven"]),
			("Giorgio", ["Tomoko"]),
			("Hana", ["Umar"]),
			("Ian", ["Vera"]),
			("Jing", ["Wyatt"]),
			("Kaito", ["Xia"]),
			("Leila", ["Yassin"]),
			("Mateo", ["Zara"]),
			("Nia", ["Antonio"]),
			("Oscar", ["Bianca"]),
			("Priya", ["Cai"]),
			("Qi", ["Dimitri"]),
			("Rami", ["Ewa"]),
			("Sven", ["Fabio"]),
			("Tomoko", ["Gabriela"]),
			("Umar", ["Helena"]),
			("Vera", ["Igor"]),
			("Wyatt", ["Jun"]),
			("Xia", ["Kim"]),
			("Yassin", ["Lucia"]),
			("Zara", ["Mohammed"]),
		]),
	)
	result = family_tree.degree_of_separation("Dimitri", "Fabio")
	result == Ok(9)
}

## Complex graph, no shortcut, far removed nephew
expect {
	family_tree = FamilyTree.(
		Dict.from_list([
			("Aiko", ["Bao", "Carlos"]),
			("Bao", ["Dalia", "Elias"]),
			("Carlos", ["Fatima", "Gustavo"]),
			("Dalia", ["Hassan", "Isla"]),
			("Elias", ["Javier"]),
			("Fatima", ["Khadija", "Liam"]),
			("Gustavo", ["Mina"]),
			("Hassan", ["Noah", "Olga"]),
			("Isla", ["Pedro"]),
			("Javier", ["Quynh", "Ravi"]),
			("Khadija", ["Sofia"]),
			("Liam", ["Tariq", "Uma"]),
			("Mina", ["Viktor", "Wang"]),
			("Noah", ["Xiomara"]),
			("Olga", ["Yuki"]),
			("Pedro", ["Zane", "Aditi"]),
			("Quynh", ["Boris"]),
			("Ravi", ["Celine"]),
			("Sofia", ["Diego", "Elif"]),
			("Tariq", ["Farah"]),
			("Uma", ["Giorgio"]),
			("Viktor", ["Hana", "Ian"]),
			("Wang", ["Jing"]),
			("Xiomara", ["Kaito"]),
			("Yuki", ["Leila"]),
			("Zane", ["Mateo"]),
			("Aditi", ["Nia"]),
			("Boris", ["Oscar"]),
			("Celine", ["Priya"]),
			("Diego", ["Qi"]),
			("Elif", ["Rami"]),
			("Farah", ["Sven"]),
			("Giorgio", ["Tomoko"]),
			("Hana", ["Umar"]),
			("Ian", ["Vera"]),
			("Jing", ["Wyatt"]),
			("Kaito", ["Xia"]),
			("Leila", ["Yassin"]),
			("Mateo", ["Zara"]),
			("Nia", ["Antonio"]),
			("Oscar", ["Bianca"]),
			("Priya", ["Cai"]),
			("Qi", ["Dimitri"]),
			("Rami", ["Ewa"]),
			("Sven", ["Fabio"]),
			("Tomoko", ["Gabriela"]),
			("Umar", ["Helena"]),
			("Vera", ["Igor"]),
			("Wyatt", ["Jun"]),
			("Xia", ["Kim"]),
			("Yassin", ["Lucia"]),
			("Zara", ["Mohammed"]),
		]),
	)
	result = family_tree.degree_of_separation("Lucia", "Jun")
	result == Ok(14)
}

## Complex graph, some shortcuts, cross-down and cross-up, cousins several times removed, with unrelated family tree
expect {
	family_tree = FamilyTree.(
		Dict.from_list([
			("Aiko", ["Bao", "Carlos"]),
			("Bao", ["Dalia"]),
			("Carlos", ["Fatima", "Gustavo"]),
			("Dalia", ["Hassan", "Isla"]),
			("Fatima", ["Khadija", "Liam"]),
			("Gustavo", ["Mina"]),
			("Hassan", ["Noah", "Olga"]),
			("Isla", ["Pedro"]),
			("Javier", ["Quynh", "Ravi"]),
			("Khadija", ["Sofia"]),
			("Liam", ["Tariq", "Uma"]),
			("Mina", ["Viktor", "Wang"]),
			("Noah", ["Xiomara"]),
			("Olga", ["Yuki"]),
			("Pedro", ["Zane", "Aditi"]),
			("Quynh", ["Boris"]),
			("Ravi", ["Celine"]),
			("Sofia", ["Diego", "Elif"]),
			("Tariq", ["Farah"]),
			("Uma", ["Giorgio"]),
			("Viktor", ["Hana", "Ian"]),
			("Wang", ["Jing"]),
			("Xiomara", ["Kaito"]),
			("Yuki", ["Leila"]),
			("Zane", ["Mateo"]),
			("Aditi", ["Nia"]),
			("Boris", ["Oscar"]),
			("Celine", ["Priya"]),
			("Diego", ["Qi"]),
			("Elif", ["Rami"]),
			("Farah", ["Sven"]),
			("Giorgio", ["Tomoko"]),
			("Hana", ["Umar"]),
			("Ian", ["Vera"]),
			("Jing", ["Wyatt"]),
			("Kaito", ["Xia"]),
			("Leila", ["Yassin"]),
			("Mateo", ["Zara"]),
			("Nia", ["Antonio"]),
			("Oscar", ["Bianca"]),
			("Priya", ["Cai"]),
			("Qi", ["Dimitri"]),
			("Rami", ["Ewa"]),
			("Sven", ["Fabio"]),
			("Tomoko", ["Gabriela"]),
			("Umar", ["Helena"]),
			("Vera", ["Igor"]),
			("Wyatt", ["Jun"]),
			("Xia", ["Kim"]),
			("Yassin", ["Lucia"]),
			("Zara", ["Mohammed"]),
		]),
	)
	result = family_tree.degree_of_separation("Wyatt", "Xia")
	result == Ok(12)
}
