# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/markdown/canonical-data.json
# File last updated on 2026-10-08
app [] {
	parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/2.0.0/7CLzCK6qUz7zmj6nvBxMEFu11HPwQTnCovKiyWzDSLTW.tar.zst",
}

import Markdown exposing [parse]

## parses normal text as a paragraph
expect {
	result = parse("This will be a paragraph")
	result == Ok("<p>This will be a paragraph</p>")
}

## parsing italics
expect {
	result = parse("_This will be italic_")
	result == Ok("<p><em>This will be italic</em></p>")
}

## parsing bold text
expect {
	result = parse("__This will be bold__")
	result == Ok("<p><strong>This will be bold</strong></p>")
}

## mixed normal, italics and bold text
expect {
	result = parse("This will _be_ __mixed__")
	result == Ok("<p>This will <em>be</em> <strong>mixed</strong></p>")
}

## with h1 header level
expect {
	result = parse("# This will be an h1")
	result == Ok("<h1>This will be an h1</h1>")
}

## with h2 header level
expect {
	result = parse("## This will be an h2")
	result == Ok("<h2>This will be an h2</h2>")
}

## with h3 header level
expect {
	result = parse("### This will be an h3")
	result == Ok("<h3>This will be an h3</h3>")
}

## with h4 header level
expect {
	result = parse("#### This will be an h4")
	result == Ok("<h4>This will be an h4</h4>")
}

## with h5 header level
expect {
	result = parse("##### This will be an h5")
	result == Ok("<h5>This will be an h5</h5>")
}

## with h6 header level
expect {
	result = parse("###### This will be an h6")
	result == Ok("<h6>This will be an h6</h6>")
}

## h7 header level is a paragraph
expect {
	result = parse("####### This will not be an h7")
	result == Ok("<p>####### This will not be an h7</p>")
}

## unordered lists
expect {
	result = parse("* Item 1\n* Item 2")
	result == Ok("<ul><li>Item 1</li><li>Item 2</li></ul>")
}

## With a little bit of everything
expect {
	result = parse("# Header!\n* __Bold Item__\n* _Italic Item_")
	result == Ok("<h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>")
}

## with markdown symbols in the header text that should not be interpreted
expect {
	result = parse("# This is a header with # and * in the text")
	result == Ok("<h1>This is a header with # and * in the text</h1>")
}

## with markdown symbols in the list item text that should not be interpreted
expect {
	result = parse("* Item 1 with a # in the text\n* Item 2 with * in the text")
	result == Ok("<ul><li>Item 1 with a # in the text</li><li>Item 2 with * in the text</li></ul>")
}

## with markdown symbols in the paragraph text that should not be interpreted
expect {
	result = parse("This is a paragraph with # and * in the text")
	result == Ok("<p>This is a paragraph with # and * in the text</p>")
}

## unordered lists close properly with preceding and following lines
expect {
	result = parse("# Start a list\n* Item 1\n* Item 2\nEnd a list")
	result == Ok("<h1>Start a list</h1><ul><li>Item 1</li><li>Item 2</li></ul><p>End a list</p>")
}

## multiple paragraphs
expect {
	result = parse("First\nSecond")
	result == Ok("<p>First</p><p>Second</p>")
}

## a heading closes a list
expect {
	result = parse("* Item\n## Heading")
	result == Ok("<ul><li>Item</li></ul><h2>Heading</h2>")
}

## separate lists
expect {
	result = parse("* First\nMiddle\n* Second")
	result == Ok("<ul><li>First</li></ul><p>Middle</p><ul><li>Second</li></ul>")
}

## repeated inline emphasis
expect {
	result = parse("_one_ and _two_, __three__ and __four__")
	result == Ok("<p><em>one</em> and <em>two</em>, <strong>three</strong> and <strong>four</strong></p>")
}

## emphasis in headings
expect {
	result = parse("## _Small_ and __large__")
	result == Ok("<h2><em>Small</em> and <strong>large</strong></h2>")
}

## Unicode text is preserved
expect {
	result = parse("* Café __你好__\n_👩🏽‍💻_")
	result == Ok("<ul><li>Café <strong>你好</strong></li></ul><p><em>👩🏽‍💻</em></p>")
}

## unmatched emphasis markers are literal
expect {
	result = parse("An unfinished __span")
	result == Ok("<p>An unfinished __span</p>")
}

## heading and list markers need a following space
expect {
	result = parse("#Heading\n*Item")
	result == Ok("<p>#Heading</p><p>*Item</p>")
}

## empty input is an empty paragraph
expect {
	result = parse("")
	result == Ok("<p></p>")
}

## blank lines remain empty paragraphs
expect {
	result = parse("First\n\nLast")
	result == Ok("<p>First</p><p></p><p>Last</p>")
}
