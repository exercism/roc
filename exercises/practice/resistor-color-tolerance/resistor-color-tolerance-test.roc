# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/resistor-color-tolerance/canonical-data.json
# File last updated on 2026-10-27

import Resistor exposing [label_decoder]

## Orange, orange, black and red
expect {
	result = label_decoder([Orange, Orange, Black, Red])
	result == Ok({ resistance: Ohms(33), tolerance: 2 })
}

## Blue, gray, brown and violet
expect {
	result = label_decoder([Blue, Grey, Brown, Violet])
	result == Ok({ resistance: Ohms(680), tolerance: 0.1 })
}

## Red, black, red and green
expect {
	result = label_decoder([Red, Black, Red, Green])
	result == Ok({ resistance: Kiloohms(2), tolerance: 0.5 })
}

## Green, brownm orange and grey
expect {
	result = label_decoder([Green, Brown, Orange, Grey])
	result == Ok({ resistance: Kiloohms(51), tolerance: 0.05 })
}

## Only one band
expect {
	result = label_decoder([Black])
	result == Ok({ resistance: Ohms(0) })
}

## Orange, orange, yellow, black and brown
expect {
	result = label_decoder([Orange, Orange, Yellow, Black, Brown])
	result == Ok({ resistance: Ohms(334), tolerance: 1 })
}

## Red, green, yellow, yellow and brown
expect {
	result = label_decoder([Red, Green, Yellow, Yellow, Brown])
	result == Ok({ resistance: Megaohms(2.54), tolerance: 1 })
}

## Blue, gray, white, brown and brown
expect {
	result = label_decoder([Blue, Grey, White, Brown, Brown])
	result == Ok({ resistance: Kiloohms(6.89), tolerance: 1 })
}

## Violet, orange, red and gray
expect {
	result = label_decoder([Violet, Orange, Red, Grey])
	result == Ok({ resistance: Kiloohms(7.3), tolerance: 0.05 })
}

## Brown, red, orange, green and blue
expect {
	result = label_decoder([Brown, Red, Orange, Green, Blue])
	result == Ok({ resistance: Megaohms(12.3), tolerance: 0.25 })
}

## Brown, black, brown, yellow and violet
expect {
	result = label_decoder([Brown, Black, Brown, Yellow, Violet])
	result == Ok({ resistance: Megaohms(1.01), tolerance: 0.1 })
}

## Brown, black, red and red
expect {
	result = label_decoder([Brown, Black, Red, Red])
	result == Ok({ resistance: Kiloohms(1), tolerance: 2 })
}
