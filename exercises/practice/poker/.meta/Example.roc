module [best_hands]

Value : U8
Suit : [Spades, Hearts, Diamonds, Clubs]
Card : { value : Value, suit : Suit }
Hand : List Card
HandParsingError : [InvalidNumberOfCards U64, CardWasEmpty, InvalidCardValue (List U8), InvalidCardSuit U8]

best_hands : List Str -> Result (List Str) HandParsingError
best_hands = |hands|
    parsed_hands = hands |> List.map_try(parse_hand)?
    ranks = parsed_hands |> List.map(get_rank)
    top_rank = ranks |> List.max |> Result.with_default(0)
    List.map2(hands, ranks, |hand, rank| { hand, rank })
    |> List.join_map(
        |{ hand, rank }|
            if rank == top_rank then [hand] else [],
    )
    |> Ok

parse_hand : Str -> Result Hand HandParsingError
parse_hand = |hand_str|
    cards = hand_str |> Str.split_on(" ")
    num_cards = List.len(cards)
    if num_cards != 5 then
        Err(InvalidNumberOfCards(num_cards))
    else
        cards |> List.map_try(parse_card)

parse_card : Str -> Result Card [CardWasEmpty, InvalidCardValue (List U8), InvalidCardSuit U8]
parse_card = |card_str|
    when card_str |> Str.to_utf8 is
        [] -> Err(CardWasEmpty)
        [.. as value_chars, suit_char] ->
            value = parse_value(value_chars)?
            suit = parse_suit(suit_char)?
            Ok({ value, suit })

parse_value : List U8 -> Result Value [InvalidCardValue (List U8)]
parse_value = |chars|
    when chars is
        [val] if val >= '2' and val <= '9' -> Ok((val - '0'))
        ['1', '0'] -> Ok(10)
        ['J'] -> Ok(11)
        ['Q'] -> Ok(12)
        ['K'] -> Ok(13)
        ['A'] -> Ok(14)
        _ -> Err(InvalidCardValue(chars))

parse_suit : U8 -> Result Suit [InvalidCardSuit U8]
parse_suit = |char|
    when char is
        'S' -> Ok(Spades)
        'H' -> Ok(Hearts)
        'D' -> Ok(Diamonds)
        'C' -> Ok(Clubs)
        _ -> Err(InvalidCardSuit(char))

get_rank : Hand -> U64
get_rank = |hand|
    card_values = hand |> List.map(.value) |> List.map(Num.to_u64) |> List.sort_asc
    is_consecutive =
        List.map2(card_values, (card_values |> List.take_last(4)), |card1, card2| (card1, card2))
        |> List.all(|(card1, card2)| card2 - card1 == 1)
    is_special_straight = card_values == [2, 3, 4, 5, 14] # straight starting with Ace
    is_straight = is_consecutive or is_special_straight
    is_flush = (hand |> List.map(.suit) |> Set.from_list |> Set.len) == 1

    value_groups =
        # Example: [4, 4, 4, 7, 7] -> [{size: 3, value: 4}, {size: 2, value: 7}]
        card_values
        |> List.walk(
            List.repeat(0, 13),
            |counters, card_value|
                counters |> List.update((card_value - 2), |group_size| group_size + 1),
        )
        |> List.map_with_index(|counter, value| counter * 13 + value)
        |> List.sort_desc
        |> List.map(|group_rank| { size: group_rank // 13, value: group_rank % 13 + 2 })
        |> List.drop_if(|{ size }| size == 0)

    group_sizes = value_groups |> List.map(.size)

    category =
        if is_flush and is_straight then
            8 # Straight flush
        else if group_sizes == [4, 1] then
            7 # Four of a kind
        else if group_sizes == [3, 2] then
            6 # Full house
        else if is_flush then
            5 # Flush
        else if is_straight then
            4 # Straight
        else if group_sizes == [3, 1, 1] then
            3 # Three of a kind
        else if group_sizes == [2, 2, 1] then
            2 # Two pairs
        else if group_sizes == [2, 1, 1, 1] then
            1 # One pair
        else
            0 # High card

    rank_within_category =
        if is_special_straight then
            0 # the straight starting with an Ace is the smallest straight
        else
            value_groups
            |> List.walk(
                0,
                |rank, { value }|
                    rank * 13 + value - 2,
            )

    category * Num.pow_int(13, 5) + rank_within_category
