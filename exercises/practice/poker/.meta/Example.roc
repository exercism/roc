module [best_hands]

Value : U8
Suit : [Spades, Hearts, Diamonds, Clubs]
Card : { value : Value, suit : Suit }
Hand : List Card
HandParsingError : [InvalidNumberOfCards U64, CardWasEmpty, InvalidCardValue (List U8), InvalidCardSuit U8]

best_hands : List Str -> Result (List Str) HandParsingError
best_hands = \hands ->
    parsed_hands = hands |> List.mapTry? parse_hand
    ranks = parsed_hands |> List.map get_rank
    top_rank = ranks |> List.max |> Result.withDefault 0
    List.map2 hands ranks \hand, rank -> { hand, rank }
    |> List.joinMap \{ hand, rank } ->
        if rank == top_rank then [hand] else []
    |> Ok

parse_hand : Str -> Result Hand HandParsingError
parse_hand = \hand_str ->
    cards = hand_str |> Str.splitOn " "
    num_cards = List.len cards
    if num_cards != 5 then
        Err (InvalidNumberOfCards num_cards)
        else

    cards |> List.mapTry parse_card

parse_card : Str -> Result Card [CardWasEmpty, InvalidCardValue (List U8), InvalidCardSuit U8]
parse_card = \card_str ->
    when card_str |> Str.toUtf8 is
        [] -> Err CardWasEmpty
        [.. as value_chars, suit_char] ->
            value = parse_value? value_chars
            suit = parse_suit? suit_char
            Ok { value, suit }

parse_value : List U8 -> Result Value [InvalidCardValue (List U8)]
parse_value = \chars ->
    when chars is
        [val] if val >= '2' && val <= '9' -> Ok (val - '0')
        ['1', '0'] -> Ok 10
        ['J'] -> Ok 11
        ['Q'] -> Ok 12
        ['K'] -> Ok 13
        ['A'] -> Ok 14
        _ -> Err (InvalidCardValue chars)

parse_suit : U8 -> Result Suit [InvalidCardSuit U8]
parse_suit = \char ->
    when char is
        'S' -> Ok Spades
        'H' -> Ok Hearts
        'D' -> Ok Diamonds
        'C' -> Ok Clubs
        _ -> Err (InvalidCardSuit char)

get_rank : Hand -> U64
get_rank = \hand ->
    card_values = hand |> List.map .value |> List.map Num.toU64 |> List.sortAsc
    is_consecutive =
        List.map2 card_values (card_values |> List.takeLast 4) \card1, card2 -> (card1, card2)
        |> List.all \(card1, card2) -> card2 - card1 == 1
    is_special_straight = card_values == [2, 3, 4, 5, 14] # straight starting with Ace
    is_straight = is_consecutive || is_special_straight
    is_flush = (hand |> List.map .suit |> Set.fromList |> Set.len) == 1

    value_groups =
        # Example: [4, 4, 4, 7, 7] -> [{size: 3, value: 4}, {size: 2, value: 7}]
        card_values
        |> List.walk (List.repeat 0 13) \counters, card_value ->
            counters |> List.update (card_value - 2) \group_size -> group_size + 1
        |> List.mapWithIndex \counter, value -> counter * 13 + value
        |> List.sortDesc
        |> List.map \group_rank -> { size: group_rank // 13, value: group_rank % 13 + 2 }
        |> List.dropIf \{ size } -> size == 0

    group_sizes = value_groups |> List.map .size

    category =
        if is_flush && is_straight then
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
            |> List.walk 0 \rank, { value } ->
                rank * 13 + value - 2

    category * Num.powInt 13 5 + rank_within_category