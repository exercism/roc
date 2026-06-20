Yacht :: {}.{
	Category := [Ones, Twos, Threes, Fours, Fives, Sixes, FullHouse, FourOfAKind, LittleStraight, BigStraight, Choice, Yacht]

	score : List(U8), Category -> U8
	score = |dice, category| {
		if dice.len() != 5 or dice.any(|die| die < 1 or die > 6) {
			0
		} else {
			match category {
				Ones => score_ones_to_sixes(dice, 1)
				Twos => score_ones_to_sixes(dice, 2)
				Threes => score_ones_to_sixes(dice, 3)
				Fours => score_ones_to_sixes(dice, 4)
				Fives => score_ones_to_sixes(dice, 5)
				Sixes => score_ones_to_sixes(dice, 6)
				FullHouse => score_full_house(dice)
				FourOfAKind => score_four_of_a_kind(dice)
				LittleStraight => score_straight(dice, [1, 2, 3, 4, 5])
				BigStraight => score_straight(dice, [2, 3, 4, 5, 6])
				Choice => dice.sum()
				Yacht => {
					if Set.from_list(dice).len() == 1 {
						50
					} else {
						0
					}
				}
			}
		}
	}
}

score_ones_to_sixes : List(U8), U8 -> U8
score_ones_to_sixes = |dice, value| {
	dice.keep_if(|die| die == value).sum()
}

value_counts : List(U8) -> List(U8)
value_counts = |dice| {
	dice.fold(
		[0, 0, 0, 0, 0, 0],
		|counts, die| {
			counts.update(U8.to_u64(die - 1), |x| x + 1) ?? counts
		},
	)
}

score_full_house : List(U8) -> U8
score_full_house = |dice| {
	if Set.from_list(value_counts(dice)) == Set.from_list([0, 2, 3]) {
		dice.sum()
	} else {
		0
	}
}

score_four_of_a_kind : List(U8) -> U8
score_four_of_a_kind = |dice| {
	value_counts(dice)
		.fold_with_index_until(
			0,
			|_, count, index| {
				if count < 4 {
					Continue(0)
				} else {
					Break(((index + 1).to_u8_try() ?? 0) * 4)
				}
			},
		)
}

score_straight : List(U8), List(U8) -> U8
score_straight = |dice, target| {
	if sort_asc(dice) == target {
		30
	} else {
		0
	}
}

sort_asc = |list| {
	list.sort_with(
		|a, b| {
			if a < b {
				LT
			} else if a > b {
				GT
			} else {
				EQ
			}
		},
	)
}
