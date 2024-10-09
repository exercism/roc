# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/poker/canonical-data.json
# File last updated on 2024-10-08
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import Poker exposing [bestHands]

# single hand always wins
expect
    hands = ["4S 5S 7H 8D JC"]
    result = bestHands hands
    result == Ok ["4S 5S 7H 8D JC"]

# highest card out of all hands wins
expect
    hands = ["4D 5S 6S 8D 3C", "2S 4C 7S 9H 10H", "3S 4S 5D 6H JH"]
    result = bestHands hands
    result == Ok ["3S 4S 5D 6H JH"]

# a tie has multiple winners
expect
    hands = ["4D 5S 6S 8D 3C", "2S 4C 7S 9H 10H", "3S 4S 5D 6H JH", "3H 4H 5C 6C JD"]
    result = bestHands hands
    result == Ok ["3S 4S 5D 6H JH", "3H 4H 5C 6C JD"]

# multiple hands with the same high cards, tie compares next highest ranked, down to last card
expect
    hands = ["3S 5H 6S 8D 7H", "2S 5D 6D 8C 7S"]
    result = bestHands hands
    result == Ok ["3S 5H 6S 8D 7H"]

# winning high card hand also has the lowest card
expect
    hands = ["2S 5H 6S 8D 7H", "3S 4D 6D 8C 7S"]
    result = bestHands hands
    result == Ok ["2S 5H 6S 8D 7H"]

# one pair beats high card
expect
    hands = ["4S 5H 6C 8D KH", "2S 4H 6S 4D JH"]
    result = bestHands hands
    result == Ok ["2S 4H 6S 4D JH"]

# highest pair wins
expect
    hands = ["4S 2H 6S 2D JH", "2S 4H 6C 4D JD"]
    result = bestHands hands
    result == Ok ["2S 4H 6C 4D JD"]

# both hands have the same pair, high card wins
expect
    hands = ["4H 4S AH JC 3D", "4C 4D AS 5D 6C"]
    result = bestHands hands
    result == Ok ["4H 4S AH JC 3D"]

# two pairs beats one pair
expect
    hands = ["2S 8H 6S 8D JH", "4S 5H 4C 8C 5C"]
    result = bestHands hands
    result == Ok ["4S 5H 4C 8C 5C"]

# both hands have two pairs, highest ranked pair wins
expect
    hands = ["2S 8H 2D 8D 3H", "4S 5H 4C 8S 5D"]
    result = bestHands hands
    result == Ok ["2S 8H 2D 8D 3H"]

# both hands have two pairs, with the same highest ranked pair, tie goes to low pair
expect
    hands = ["2S QS 2C QD JH", "JD QH JS 8D QC"]
    result = bestHands hands
    result == Ok ["JD QH JS 8D QC"]

# both hands have two identically ranked pairs, tie goes to remaining card (kicker)
expect
    hands = ["JD QH JS 8D QC", "JS QS JC 2D QD"]
    result = bestHands hands
    result == Ok ["JD QH JS 8D QC"]

# both hands have two pairs that add to the same value, win goes to highest pair
expect
    hands = ["6S 6H 3S 3H AS", "7H 7S 2H 2S AC"]
    result = bestHands hands
    result == Ok ["7H 7S 2H 2S AC"]

# two pairs first ranked by largest pair
expect
    hands = ["5C 2S 5S 4H 4C", "6S 2S 6H 7C 2C"]
    result = bestHands hands
    result == Ok ["6S 2S 6H 7C 2C"]

# three of a kind beats two pair
expect
    hands = ["2S 8H 2H 8D JH", "4S 5H 4C 8S 4H"]
    result = bestHands hands
    result == Ok ["4S 5H 4C 8S 4H"]

# both hands have three of a kind, tie goes to highest ranked triplet
expect
    hands = ["2S 2H 2C 8D JH", "4S AH AS 8C AD"]
    result = bestHands hands
    result == Ok ["4S AH AS 8C AD"]

# with multiple decks, two players can have same three of a kind, ties go to highest remaining cards
expect
    hands = ["5S AH AS 7C AD", "4S AH AS 8C AD"]
    result = bestHands hands
    result == Ok ["4S AH AS 8C AD"]

# a straight beats three of a kind
expect
    hands = ["4S 5H 4C 8D 4H", "3S 4D 2S 6D 5C"]
    result = bestHands hands
    result == Ok ["3S 4D 2S 6D 5C"]

# aces can end a straight (10 J Q K A)
expect
    hands = ["4S 5H 4C 8D 4H", "10D JH QS KD AC"]
    result = bestHands hands
    result == Ok ["10D JH QS KD AC"]

# aces can start a straight (A 2 3 4 5)
expect
    hands = ["4S 5H 4C 8D 4H", "4D AH 3S 2D 5C"]
    result = bestHands hands
    result == Ok ["4D AH 3S 2D 5C"]

# aces cannot be in the middle of a straight (Q K A 2 3)
expect
    hands = ["2C 3D 7H 5H 2S", "QS KH AC 2D 3S"]
    result = bestHands hands
    result == Ok ["2C 3D 7H 5H 2S"]

# both hands with a straight, tie goes to highest ranked card
expect
    hands = ["4S 6C 7S 8D 5H", "5S 7H 8S 9D 6H"]
    result = bestHands hands
    result == Ok ["5S 7H 8S 9D 6H"]

# even though an ace is usually high, a 5-high straight is the lowest-scoring straight
expect
    hands = ["2H 3C 4D 5D 6H", "4S AH 3S 2D 5H"]
    result = bestHands hands
    result == Ok ["2H 3C 4D 5D 6H"]

# flush beats a straight
expect
    hands = ["4C 6H 7D 8D 5H", "2S 4S 5S 6S 7S"]
    result = bestHands hands
    result == Ok ["2S 4S 5S 6S 7S"]

# both hands have a flush, tie goes to high card, down to the last one if necessary
expect
    hands = ["2H 7H 8H 9H 6H", "3S 5S 6S 7S 8S"]
    result = bestHands hands
    result == Ok ["2H 7H 8H 9H 6H"]

# full house beats a flush
expect
    hands = ["3H 6H 7H 8H 5H", "4S 5H 4C 5D 4H"]
    result = bestHands hands
    result == Ok ["4S 5H 4C 5D 4H"]

# both hands have a full house, tie goes to highest-ranked triplet
expect
    hands = ["4H 4S 4D 9S 9D", "5H 5S 5D 8S 8D"]
    result = bestHands hands
    result == Ok ["5H 5S 5D 8S 8D"]

# with multiple decks, both hands have a full house with the same triplet, tie goes to the pair
expect
    hands = ["5H 5S 5D 9S 9D", "5H 5S 5D 8S 8D"]
    result = bestHands hands
    result == Ok ["5H 5S 5D 9S 9D"]

# four of a kind beats a full house
expect
    hands = ["4S 5H 4D 5D 4H", "3S 3H 2S 3D 3C"]
    result = bestHands hands
    result == Ok ["3S 3H 2S 3D 3C"]

# both hands have four of a kind, tie goes to high quad
expect
    hands = ["2S 2H 2C 8D 2D", "4S 5H 5S 5D 5C"]
    result = bestHands hands
    result == Ok ["4S 5H 5S 5D 5C"]

# with multiple decks, both hands with identical four of a kind, tie determined by kicker
expect
    hands = ["3S 3H 2S 3D 3C", "3S 3H 4S 3D 3C"]
    result = bestHands hands
    result == Ok ["3S 3H 4S 3D 3C"]

# straight flush beats four of a kind
expect
    hands = ["4S 5H 5S 5D 5C", "7S 8S 9S 6S 10S"]
    result = bestHands hands
    result == Ok ["7S 8S 9S 6S 10S"]

# aces can end a straight flush (10 J Q K A)
expect
    hands = ["KC AH AS AD AC", "10C JC QC KC AC"]
    result = bestHands hands
    result == Ok ["10C JC QC KC AC"]

# aces can start a straight flush (A 2 3 4 5)
expect
    hands = ["KS AH AS AD AC", "4H AH 3H 2H 5H"]
    result = bestHands hands
    result == Ok ["4H AH 3H 2H 5H"]

# aces cannot be in the middle of a straight flush (Q K A 2 3)
expect
    hands = ["2C AC QC 10C KC", "QH KH AH 2H 3H"]
    result = bestHands hands
    result == Ok ["2C AC QC 10C KC"]

# both hands have a straight flush, tie goes to highest-ranked card
expect
    hands = ["4H 6H 7H 8H 5H", "5S 7S 8S 9S 6S"]
    result = bestHands hands
    result == Ok ["5S 7S 8S 9S 6S"]

# even though an ace is usually high, a 5-high straight flush is the lowest-scoring straight flush
expect
    hands = ["2H 3H 4H 5H 6H", "4D AD 3D 2D 5D"]
    result = bestHands hands
    result == Ok ["2H 3H 4H 5H 6H"]

