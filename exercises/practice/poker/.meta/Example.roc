module [bestHands]

Value : U8
Suit : [Spades, Hearts, Diamonds, Clubs]
Card : { value : Value, suit : Suit }
Hand : List Card
HandParsingError : [InvalidNumberOfCards U64, CardWasEmpty, InvalidCardValue (List U8), InvalidCardSuit U8]

bestHands : List Str -> Result (List Str) HandParsingError
bestHands = \hands ->
    parsedHands = hands |> List.mapTry? parseHand
    ranks = parsedHands |> List.map getRank
    topRank = ranks |> List.max |> Result.withDefault 0
    List.map2 hands ranks \hand, rank -> { hand, rank }
    |> List.joinMap \{ hand, rank } ->
        if rank == topRank then [hand] else []
    |> Ok

parseHand : Str -> Result Hand HandParsingError
parseHand = \handStr ->
    cards = handStr |> Str.split " "
    numCards = List.len cards
    if numCards != 5 then
        Err (InvalidNumberOfCards numCards)
        else

    cards |> List.mapTry parseCard

parseCard : Str -> Result Card [CardWasEmpty, InvalidCardValue (List U8), InvalidCardSuit U8]
parseCard = \cardStr ->
    when cardStr |> Str.toUtf8 is
        [] -> Err CardWasEmpty
        [.. as valueChars, suitChar] ->
            value = parseValue? valueChars
            suit = parseSuit? suitChar
            Ok { value, suit }

parseValue : List U8 -> Result Value [InvalidCardValue (List U8)]
parseValue = \chars ->
    when chars is
        [val] if val >= '2' && val <= '9' -> Ok (val - '0')
        ['1', '0'] -> Ok 10
        ['J'] -> Ok 11
        ['Q'] -> Ok 12
        ['K'] -> Ok 13
        ['A'] -> Ok 14
        _ -> Err (InvalidCardValue chars)

parseSuit : U8 -> Result Suit [InvalidCardSuit U8]
parseSuit = \char ->
    when char is
        'S' -> Ok Spades
        'H' -> Ok Hearts
        'D' -> Ok Diamonds
        'C' -> Ok Clubs
        _ -> Err (InvalidCardSuit char)

getRank : Hand -> U64
getRank = \hand ->
    cardValues = hand |> List.map .value |> List.map Num.toU64 |> List.sortAsc
    isConsecutive =
        List.map2 cardValues (cardValues |> List.takeLast 4) \card1, card2 -> (card1, card2)
        |> List.all \(card1, card2) -> card2 - card1 == 1
    isSpecialStraight = cardValues == [2, 3, 4, 5, 14] # straight starting with Ace
    isStraight = isConsecutive || isSpecialStraight
    isFlush = (hand |> List.map .suit |> Set.fromList |> Set.len) == 1

    valueGroups =
        # Example: [4, 4, 4, 7, 7] -> [{size: 3, value: 4}, {size: 2, value: 7}]
        cardValues
        |> List.walk (List.repeat 0 13) \counters, cardValue ->
            counters |> List.update (cardValue - 2) \groupSize -> groupSize + 1
        |> List.mapWithIndex \counter, value -> counter * 13 + value
        |> List.sortDesc
        |> List.map \groupRank -> { size: groupRank // 13, value: groupRank % 13 + 2 }
        |> List.dropIf \{ size } -> size == 0

    groupSizes = valueGroups |> List.map .size

    category =
        if isFlush && isStraight then
            8 # Straight flush
        else if groupSizes == [4, 1] then
            7 # Four of a kind
        else if groupSizes == [3, 2] then
            6 # Full house
        else if isFlush then
            5 # Flush
        else if isStraight then
            4 # Straight
        else if groupSizes == [3, 1, 1] then
            3 # Three of a kind
        else if groupSizes == [2, 2, 1] then
            2 # Two pairs
        else if groupSizes == [2, 1, 1, 1] then
            1 # One pair
        else
            0 # High card

    rankWithinCategory =
        if isSpecialStraight then
            0 # the straight starting with an Ace is the smallest straight
        else
            valueGroups
            |> List.walk 0 \rank, { value } ->
                rank * 13 + value - 2

    category * Num.powInt 13 5 + rankWithinCategory
