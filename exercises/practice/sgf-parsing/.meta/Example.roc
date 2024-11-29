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

## This function builds a GameTree given a list of `NodeProperties` and a list
## of alternative children `GameTree`.
##
## For example, "(;A[1]B[2];C[3]D[4];E[5](;F[6]G[7];H[8])(;I[6]))" will be
## parsed by the `gameTree` parser into a `List NodeProperties` and a
## `List GameTree`:
## - The `List NodeProperties` will be [AB, CD, E] in this example, where XY
##   represents a `NodeProperties` value containing the properties X & Y (along
##   with their values).
## - The `List GameTree` will [FG->[H->[]], I->[]] where XY->[t1,t2] represents
##   a GameTree node with properties XY and with children trees t1 and t2.
##
## With these two input lists, the function will build the final GameTree:
## AB->[CD->[E->[FG->[H->[]], I->[]]]]
buildGameNode : List NodeProperties, List GameTree -> GameTree
buildGameNode = \nodeProps, alternatives ->
    help = \remainingNodeProps, subTrees ->
        when remainingNodeProps is
            [rootNode] ->
                GameNode { properties: rootNode, children: subTrees }

            [.. as rest, last] ->
                help rest [GameNode { properties: last, children: subTrees }]

            [] -> crash "Unreachable: remainingNodeProps list cannot be empty"
    help nodeProps alternatives

gameTree : P.Parser (List U8) GameTree
gameTree =
    P.const (\nodeProps -> \alternatives -> buildGameNode nodeProps alternatives)
    |> P.skip (S.codeunit '(')
    |> P.keep (P.oneOrMore node)
    |> P.keep (P.many subTree)
    |> P.skip (S.codeunit ')')

subTree : P.Parser (List U8) GameTree
subTree =
    P.const (\t -> t)
    |> P.keep
        (
            P.oneOf [
                P.const (\t -> t) |> P.keep (P.lazy (\_ -> gameTree)),
                P.const (\_ -> Empty) |> P.keep (P.fail "empty"),
            ]
        )

node : P.Parser (List U8) NodeProperties
node =
    P.const (\s -> s)
    |> P.skip (S.codeunit ';')
    |> P.keep (P.many property)
    |> P.map \properties -> Dict.fromList properties

## NOTE: UTF-8 error handling is very basic here. SGF actually uses ISO-8859-1
##       by default, not UTF-8. Moreover, any other encoding can be specified
##       via the CA property. This is not supported in this exercise.
property : P.Parser (List U8) (Str, List Str)
property =
    P.map2 propIdent (P.oneOrMore propValue) \id, values -> (
            id |> Str.fromUtf8 |> Result.withDefault "<BadUTF8>",
            values |> List.map \value -> value |> Str.fromUtf8 |> Result.withDefault "<BadUTF8>",
        )

propIdent : P.Parser (List U8) (List U8)
propIdent =
    P.oneOrMore ucLetter

propValue : P.Parser (List U8) (List U8)
propValue =
    P.const (\value -> value)
    |> P.skip (S.codeunit '[')
    |> P.keep valueType # in this exercise we don't support 'Compose'
    |> P.skip (S.codeunit ']')

## in this exercise we only support Text values
valueType : P.Parser (List U8) (List U8)
valueType =
    P.buildPrimitiveParser \input ->
        help = \result, chars ->
            when chars is
                [] -> Err (ParsingFailure "No closing bracket")
                [']', ..] -> Ok { val: result, input: chars }
                ['\\', '\t', .. as rest] -> help (result |> List.append ' ') rest
                ['\\', '\n', .. as rest] -> help result rest
                ['\\', c, .. as rest] -> help (result |> List.append c) rest
                ['\t', .. as rest] -> help (result |> List.append ' ') rest
                [c, .. as rest] -> help (result |> List.append c) rest
        help [] input

ucLetter : P.Parser (List U8) U8
ucLetter =
    S.codeunitSatisfies \b -> b >= 'A' && b <= 'Z'

parse : Str -> Result GameTree [ParsingFailure Str, ParsingIncomplete Str]
parse = \sgf ->
    S.parseStr gameTree sgf
