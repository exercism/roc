## Example solution

import parser.Parser
import parser.Utf8

Markdown :: {}.{
	parse : Str -> Try(Str, _)
	parse = |markdown| {
		markdown.split_on("\n")
			.map_try(parse_line)?
			|> render_blocks
			|> Ok
	}
}

Block : [Heading(U64, Str), Paragraph(Str), ListItem(Str)]

parse_line : Str -> Try(Block, _)
parse_line = |line| {
	if line.starts_with("* ") {
		return Ok(ListItem(render_inline(line.drop_prefix("* "))?))
	}
	heading = [1, 2, 3, 4, 5, 6].find_first(|level| line.starts_with("#".repeat(level).concat(" ")))
	match heading {
		Ok(level) => Ok(Heading(level, render_inline(line.drop_prefix("#".repeat(level).concat(" ")))?))
		Err(NotFound) => Ok(Paragraph(render_inline(line)?))
	}
}

render_blocks : List(Block) -> Str
render_blocks = |blocks| {
	match blocks {
		[] => ""
		[ListItem(_), ..] => {
			{ html, rest } = render_list_items(blocks)
			wrap("ul", html).concat(render_blocks(rest))
		}
		[Heading(level, text), .. as rest] => wrap("h${level.to_str()}", text).concat(render_blocks(rest))
		[Paragraph(text), .. as rest] => wrap("p", text).concat(render_blocks(rest))
	}
}

render_list_items : List(Block) -> { html : Str, rest : List(Block) }
render_list_items = |blocks| {
	match blocks {
		[ListItem(text), .. as tail] => {
			{ html, rest } = render_list_items(tail)
			{ html: wrap("li", text).concat(html), rest }
		}
		_ => { html: "", rest: blocks }
	}
}

render_inline : Str -> Try(Str, _)
render_inline = |text| {
	Utf8.parse_str(inline_parser, text)
}

plain_text : Parser(List(U8), Str)
plain_text = Utf8.codeunit_satisfies(|byte| byte != '_')
	.one_or_more()
	.map(Str.from_utf8_lossy)

emphasis : Str, Str -> Parser(List(U8), Str)
emphasis = |marker, tag| {
	plain_text
		.between(Utf8.string(marker), Utf8.string(marker))
		.map(|text| wrap(tag, text))
}

inline_parser : Parser(List(U8), Str)
inline_parser = Parser.one_of([
	emphasis("__", "strong"),
	emphasis("_", "em"),
	plain_text,
	Utf8.string("_"),
]).many().map(|parts| Str.join_with(parts, ""))

wrap : Str, Str -> Str
wrap = |tag, text| "<${tag}>${text}</${tag}>"
