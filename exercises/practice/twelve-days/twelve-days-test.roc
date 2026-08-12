# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/twelve-days/canonical-data.json
# File last updated on 2026-08-10

import TwelveDays exposing [recite]

# first day a partridge in a pear tree
expect {
	result = recite(1, 1)?
	result == "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree."
}
# second day two turtle doves
expect {
	result = recite(2, 2)?
	result == "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree."
}
# third day three french hens
expect {
	result = recite(3, 3)?
	result == "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
}
# fourth day four calling birds
expect {
	result = recite(4, 4)?
	result == "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
}
# fifth day five gold rings
expect {
	result = recite(5, 5)?
	result == "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
}
# sixth day six geese-a-laying
expect {
	result = recite(6, 6)?
	result == "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
}
# seventh day seven swans-a-swimming
expect {
	result = recite(7, 7)?
	result == "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
}
# eighth day eight maids-a-milking
expect {
	result = recite(8, 8)?
	result == "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
}
# ninth day nine ladies dancing
expect {
	result = recite(9, 9)?
	result == "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
}
# tenth day ten lords-a-leaping
expect {
	result = recite(10, 10)?
	result == "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
}
# eleventh day eleven pipers piping
expect {
	result = recite(11, 11)?
	result == "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
}
# twelfth day twelve drummers drumming
expect {
	result = recite(12, 12)?
	result == "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
}

# recites first three verses of the song
expect {
	result = recite(1, 3)?
	result ==
		\\On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.
		\\On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.
		\\On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

}
# recites three verses from the middle of the song
expect {
	result = recite(4, 6)?
	result ==
		\\On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
		\\On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
		\\On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

}
# recites the whole song
expect {
	result = recite(1, 12)?
	result ==
		\\On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.
		\\On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.
		\\On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
		\\On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
		\\On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
		\\On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
		\\On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
		\\On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
		\\On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
		\\On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
		\\On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
		\\On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
