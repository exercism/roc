Poker :: {}.{
	HandParsingError : [InvalidNumberOfCards(U64), CardWasEmpty, InvalidCardValue(List(U8)), InvalidCardSuit(U8)]

	best_hands : List(Str) -> Try(List(Str), HandParsingError)
	best_hands = |hands| {
		parsed_hands = hands->map_try(parse_hand)?
		ranks = parsed_hands.map(get_rank)
		top_rank = ranks.fold(
			0,
			|max_val, val| if val > max_val {
				val
			} else {
				max_val
			},
		)
		List.map2(hands, ranks, |hand, rank| { hand, rank })
			->join_map(
				|res| {
					{ hand, rank } = res
					if rank == top_rank {
						[hand]
					} else {
						[]
					}
				},
			)
			->Ok()
	}
}

Value : U8

Suit : [Spades, Hearts, Diamonds, Clubs]

Card : { value : Value, suit : Suit }

Hand : List(Card)

parse_hand : Str -> Try(Hand, HandParsingError)
parse_hand = |hand_str| {
	cards = hand_str.split_on(" ")
	num_cards = cards.len()
	if num_cards != 5 {
		Err(InvalidNumberOfCards(num_cards))
	} else {
		cards->map_try(parse_card)
	}
}

parse_card : Str -> Try(Card, [CardWasEmpty, InvalidCardValue(List(U8)), InvalidCardSuit(U8), ..])
parse_card = |card_str| {
	match card_str.to_utf8() {
		[] => Err(CardWasEmpty)
		[.. as value_chars, suit_char] => {
			value = parse_value(value_chars)?
			suit = parse_suit(suit_char)?
			Ok({ value, suit })
		}
	}
}

parse_value : List(U8) -> Try(Value, [InvalidCardValue(List(U8)), ..])
parse_value = |chars| {
	match chars {
		[val] if val >= '2' and val <= '9' => Ok((val - '0'))
		['1', '0'] => Ok(10)
		['J'] => Ok(11)
		['Q'] => Ok(12)
		['K'] => Ok(13)
		['A'] => Ok(14)
		_ => Err(InvalidCardValue(chars))
	}
}

parse_suit : U8 -> Try(Suit, [InvalidCardSuit(U8), ..])
parse_suit = |char| {
	match char {
		'S' => Ok(Spades)
		'H' => Ok(Hearts)
		'D' => Ok(Diamonds)
		'C' => Ok(Clubs)
		_ => Err(InvalidCardSuit(char))
	}
}

get_rank : Hand -> U64
get_rank = |hand| {
	card_values = sort_asc(hand.map(|c| U8.to_u64(c.value)))
	is_consecutive = 
		List.map2(card_values, take_last(card_values, 4), |card1, card2| (card1, card2))
			.all(
				|pair| {
					(card1, card2) = pair
					card2 - card1 == 1
				},
			)
	is_special_straight = card_values == [2, 3, 4, 5, 14] # straight starting with Ace
	is_straight = is_consecutive or is_special_straight
	is_flush = (hand.map(|c| c.suit)->Set.from_list().len()) == 1

	value_groups = 
		card_values
			.fold(
				List.repeat(0, 13),
				|counters, card_value| {
					counters.update((card_value - 2), |group_size| group_size + 1) ?? counters
				},
			)
			.map_with_index(|counter, value| counter * 13 + value)
			->sort_desc()
			.map(|group_rank| { size: group_rank // 13, value: group_rank % 13 + 2 })
			.drop_if(
				|group| {
					{ size, value: _ } = group
					size == 0
				},
			)

	group_sizes = value_groups.map(|g| g.size)

	category = 
		if is_flush and is_straight {
			8 # Straight flush
		} else if group_sizes == [4, 1] {
			7 # Four of a kind
		} else if group_sizes == [3, 2] {
			6 # Full house
		} else if is_flush {
			5 # Flush
		} else if is_straight {
			4 # Straight
		} else if group_sizes == [3, 1, 1] {
			3 # Three of a kind
		} else if group_sizes == [2, 2, 1] {
			2 # Two pairs
		} else if group_sizes == [2, 1, 1, 1] {
			1 # One pair
		} else {
			0 # High card
		}

	rank_within_category = 
		if is_special_straight {
			0 # the straight starting with an Ace is the smallest straight
		} else {
			value_groups
				.fold(
					0,
					|rank, group| {
						{ value, size: _ } = group
						rank * 13 + value - 2
					},
				)
		}

	category * pow_int(13, 5) + rank_within_category
}

# The following functions should soon be available in Roc's builtins
join_map = |iter, func| {
	var $state = []
	for item in iter {
		for subitem in func(item) {
			$state = $state.append(subitem)
		}
	}
	$state
}

map_try = |iter, func| {
	var $state = []
	for item in iter {
		$state = $state.append(func(item)?)
	}
	Ok($state)
}

pow_int : U64, U64 -> U64
pow_int = |number, pow| {
	(1..=pow).fold(
		1,
		|acc, _| {
			acc * number
		},
	)
}

sort_asc = |list| {
	list.sort_with(|a, b| a.compare(b))
}

sort_desc = |list| {
	list.sort_with(|a, b| b.compare(a))
}

take_last = |list, n| {
	list.sublist({ start: list.len() - n, len: n })
}
