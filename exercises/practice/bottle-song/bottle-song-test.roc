# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/bottle-song/canonical-data.json
# File last updated on 2026-08-18

import BottleSong exposing [recite]

# first generic verse
expect {
	result = recite(10, 1)?
	result ==
		\\Ten green bottles hanging on the wall,
		\\Ten green bottles hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be nine green bottles hanging on the wall.

}
# last generic verse
expect {
	result = recite(3, 1)?
	result ==
		\\Three green bottles hanging on the wall,
		\\Three green bottles hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be two green bottles hanging on the wall.

}
# verse with 2 bottles
expect {
	result = recite(2, 1)?
	result ==
		\\Two green bottles hanging on the wall,
		\\Two green bottles hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be one green bottle hanging on the wall.

}
# verse with 1 bottle
expect {
	result = recite(1, 1)?
	result ==
		\\One green bottle hanging on the wall,
		\\One green bottle hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be no green bottles hanging on the wall.

}

# first two verses
expect {
	result = recite(10, 2)?
	result ==
		\\Ten green bottles hanging on the wall,
		\\Ten green bottles hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be nine green bottles hanging on the wall.
		\\
		\\Nine green bottles hanging on the wall,
		\\Nine green bottles hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be eight green bottles hanging on the wall.

}
# last three verses
expect {
	result = recite(3, 3)?
	result ==
		\\Three green bottles hanging on the wall,
		\\Three green bottles hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be two green bottles hanging on the wall.
		\\
		\\Two green bottles hanging on the wall,
		\\Two green bottles hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be one green bottle hanging on the wall.
		\\
		\\One green bottle hanging on the wall,
		\\One green bottle hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be no green bottles hanging on the wall.

}
# all verses
expect {
	result = recite(10, 10)?
	result ==
		\\Ten green bottles hanging on the wall,
		\\Ten green bottles hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be nine green bottles hanging on the wall.
		\\
		\\Nine green bottles hanging on the wall,
		\\Nine green bottles hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be eight green bottles hanging on the wall.
		\\
		\\Eight green bottles hanging on the wall,
		\\Eight green bottles hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be seven green bottles hanging on the wall.
		\\
		\\Seven green bottles hanging on the wall,
		\\Seven green bottles hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be six green bottles hanging on the wall.
		\\
		\\Six green bottles hanging on the wall,
		\\Six green bottles hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be five green bottles hanging on the wall.
		\\
		\\Five green bottles hanging on the wall,
		\\Five green bottles hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be four green bottles hanging on the wall.
		\\
		\\Four green bottles hanging on the wall,
		\\Four green bottles hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be three green bottles hanging on the wall.
		\\
		\\Three green bottles hanging on the wall,
		\\Three green bottles hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be two green bottles hanging on the wall.
		\\
		\\Two green bottles hanging on the wall,
		\\Two green bottles hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be one green bottle hanging on the wall.
		\\
		\\One green bottle hanging on the wall,
		\\One green bottle hanging on the wall,
		\\And if one green bottle should accidentally fall,
		\\There'll be no green bottles hanging on the wall.

}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
