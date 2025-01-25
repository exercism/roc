module [parse]

import parser.Parser as P
import parser.String as S

# --- SGF GRAMMAR ---
# Source: https://homepages.cwi.nl/~aeb/go/misc/sgfnotes.html
#
# Collection = GameTree+
# GameTree   = '(' Sequence GameTree* ')'
# Sequence   = Node+
# Node       = ';' Property*
# Property   = PropIdent PropValue+
# PropIdent  = UcLetter+
# PropValue  = '[' CValueType ']'
# CValueType = (ValueType | Compose)
# ValueType  = (None | Number | Real | Double | Color | SimpleText | Text | Point  | Move | Stone)
# UcLetter   = 'A'..'Z'
# Compose    = ValueType ':' ValueType
#
# Note: In this exercise, we only support `Text` values for `CValueType`, where
#       `Text` is escaped as per the instructions. `Compose` is not supported.

NodeProperties : Dict Str (List Str)

# Note: Empty is unused, it's only here to avoid infinite type recursion because
#       the Roc compiler does not yet understand that an empty List can end the
#       recursion.
GameTree : [Empty, GameNode { properties : NodeProperties, children : List GameTree }]

build_game_node : List NodeProperties, List GameTree -> GameTree
build_game_node = |node_props, alternatives|
    help = |remaining_node_props, sub_trees|
        when remaining_node_props is
            [root_node] ->
                GameNode({ properties: root_node, children: sub_trees })

            [.. as rest, last] ->
                help(rest, [GameNode({ properties: last, children: sub_trees })])

            [] -> crash("Unreachable: remaining_node_props list cannot be empty")
    help(node_props, alternatives)

game_tree : P.Parser (List U8) GameTree
game_tree =
    P.const(|node_props| |alternatives| build_game_node(node_props, alternatives))
    |> P.skip(S.codeunit('('))
    |> P.keep(P.one_or_more(node))
    |> P.keep(P.many(sub_tree))
    |> P.skip(S.codeunit(')'))

sub_tree : P.Parser (List U8) GameTree
sub_tree =
    P.const(|t| t)
    |> P.keep(
        P.one_of(
            [
                P.const(|t| t) |> P.keep(P.lazy(|_| game_tree)),
                P.const(|_| Empty) |> P.keep(P.fail("empty")),
            ],
        ),
    )

node : P.Parser (List U8) NodeProperties
node =
    P.const(|s| s)
    |> P.skip(S.codeunit(';'))
    |> P.keep(P.many(property))
    |> P.map(|properties| Dict.from_list(properties))

property : P.Parser (List U8) (Str, List Str)
property =
    P.map2(
        prop_ident,
        P.one_or_more(prop_value),
        |id, values|
            (
                id |> Str.from_utf8 |> Result.with_default("<BadUTF8>"),
                values |> List.map(|value| value |> Str.from_utf8 |> Result.with_default("<BadUTF8>")),
            ),
    )

prop_ident : P.Parser (List U8) (List U8)
prop_ident =
    P.one_or_more(uc_letter)

prop_value : P.Parser (List U8) (List U8)
prop_value =
    P.const(|value| value)
    |> P.skip(S.codeunit('['))
    |> P.keep(value_type) # in this exercise we don't support 'Compose'
    |> P.skip(S.codeunit(']'))

value_type : P.Parser (List U8) (List U8)
value_type =
    P.build_primitive_parser(
        |input|
            help = |result, chars|
                when chars is
                    [] -> Err(ParsingFailure("No closing bracket"))
                    [']', ..] -> Ok({ val: result, input: chars })
                    ['\\', '\t', .. as rest] -> help((result |> List.append(' ')), rest)
                    ['\\', '\n', .. as rest] -> help(result, rest)
                    ['\\', c, .. as rest] -> help((result |> List.append(c)), rest)
                    ['\t', .. as rest] -> help((result |> List.append(' ')), rest)
                    [c, .. as rest] -> help((result |> List.append(c)), rest)
            help([], input),
    )

uc_letter : P.Parser (List U8) U8
uc_letter =
    S.codeunit_satisfies(|b| b >= 'A' and b <= 'Z')

parse : Str -> Result GameTree [ParsingFailure Str, ParsingIncomplete Str]
parse = |sgf|
    S.parse_str(game_tree, sgf)
