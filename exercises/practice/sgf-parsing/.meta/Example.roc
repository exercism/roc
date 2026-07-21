import parser.Parser as P
import parser.String as S

SgfParsing :: {}.{
	NodeProperties : Dict(Str, List(Str))
	GameTree := { properties : NodeProperties, children : List(GameTree) }.{
		# The following line enables the default `is_eq` implementation
		is_eq : _
	}

	parse : Str -> Try(GameTree, [ParsingFailure(Str), ParsingIncomplete(Str)])
	parse = |sgf| {
		S.parse_str(game_tree, sgf)
	}
}

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

build_game_node : List(SgfParsing.NodeProperties), List(SgfParsing.GameTree) -> SgfParsing.GameTree
build_game_node = |node_props, alternatives| {
	help : List(SgfParsing.NodeProperties), List(SgfParsing.GameTree) -> SgfParsing.GameTree
	help = |remaining_node_props, sub_trees| {
		match remaining_node_props {
			[root_node] =>
				{ properties: root_node, children: sub_trees }

			[.. as rest, last] =>
				help(rest, [{ properties: last, children: sub_trees }])

			[] => {
				crash "Unreachable: remaining_node_props list cannot be empty"
			}
		}
	}
	help(node_props, alternatives)
}

game_tree : P.Parser(List(U8), SgfParsing.GameTree)
game_tree = 
	P.const(|node_props| |alternatives| build_game_node(node_props, alternatives))
		.skip(S.codeunit('('))
		.keep(node.one_or_more())
		.keep(sub_tree.many())
		.skip(S.codeunit(')'))

sub_tree : P.Parser(List(U8), SgfParsing.GameTree)
sub_tree = 
	P.const(|t| t)
		.keep(
			P.const(|t| t).keep(P.lazy(|_| game_tree)),
		)

node : P.Parser(List(U8), SgfParsing.NodeProperties)
node = 
	P.const(|s| s)
		.skip(S.codeunit(';'))
		.keep(P.many(property))
		.map(|properties| Dict.from_list(properties))

property : P.Parser(List(U8), (Str, List(Str)))
property = 
	P.map2(
		prop_ident,
		P.one_or_more(prop_value),
		|id, values|
			(
				((id->Str.from_utf8()) ?? "<BadUTF8>"),
				values.map(|value| ((value->Str.from_utf8()) ?? "<BadUTF8>")),
			),
	)

prop_ident : P.Parser(List(U8), List(U8))
prop_ident = 
	P.one_or_more(uc_letter)

prop_value : P.Parser(List(U8), List(U8))
prop_value = 
	P.const(|value| value)
		.skip(S.codeunit('['))
		.keep(value_type) # in this exercise we don't support 'Compose'
		.skip(S.codeunit(']'))

value_type : P.Parser(List(U8), List(U8))
value_type = 
	P.build_primitive_parser(
		|input| {
			help = |result, chars| {
				match chars {
					[] => Err(ParsingFailure("No closing bracket"))
					[']', ..] => Ok({ val: result, input: chars })
					['\\', '\t', .. as rest] => help((result.append(' ')), rest)
					['\\', '\n', .. as rest] => help(result, rest)
					['\\', c, .. as rest] => help((result.append(c)), rest)
					['\t', .. as rest] => help((result.append(' ')), rest)
					[c, .. as rest] => help((result.append(c)), rest)
				}
			}
			help([], input)
		},
	)

uc_letter : P.Parser(List(U8), U8)
uc_letter = 
	S.codeunit_satisfies(|b| b >= 'A' and b <= 'Z')
