# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/bob/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Bob exposing [response]

# stating something
expect
    result = response("Tom-ay-to, tom-aaaah-to.")
    result == "Whatever."

# shouting
expect
    result = response("WATCH OUT!")
    result == "Whoa, chill out!"

# shouting gibberish
expect
    result = response("FCECDFCAAB")
    result == "Whoa, chill out!"

# asking a question
expect
    result = response("Does this cryogenic chamber make me look fat?")
    result == "Sure."

# asking a numeric question
expect
    result = response("You are, what, like 15?")
    result == "Sure."

# asking gibberish
expect
    result = response("fffbbcbeab?")
    result == "Sure."

# talking forcefully
expect
    result = response("Hi there!")
    result == "Whatever."

# using acronyms in regular speech
expect
    result = response("It's OK if you don't want to go work for NASA.")
    result == "Whatever."

# forceful question
expect
    result = response("WHAT'S GOING ON?")
    result == "Calm down, I know what I'm doing!"

# shouting numbers
expect
    result = response("1, 2, 3 GO!")
    result == "Whoa, chill out!"

# no letters
expect
    result = response("1, 2, 3")
    result == "Whatever."

# question with no letters
expect
    result = response("4?")
    result == "Sure."

# shouting with special characters
expect
    result = response("ZOMG THE %^*@#\$(*^ ZOMBIES ARE COMING!!11!!1!")
    result == "Whoa, chill out!"

# shouting with no exclamation mark
expect
    result = response("I HATE THE DENTIST")
    result == "Whoa, chill out!"

# statement containing question mark
expect
    result = response("Ending with ? means a question.")
    result == "Whatever."

# non-letters with question
expect
    result = response(":) ?")
    result == "Sure."

# prattling on
expect
    result = response("Wait! Hang on. Are you going to be OK?")
    result == "Sure."

# silence
expect
    result = response("")
    result == "Fine. Be that way!"

# prolonged silence
expect
    result = response("          ")
    result == "Fine. Be that way!"

# alternate silence
expect
    result = response("\t\t\t\t\t\t\t\t\t\t")
    result == "Fine. Be that way!"

# multiple line question
expect
    result = response("\nDoes this cryogenic chamber make me look fat?\nNo.")
    result == "Whatever."

# starting with whitespace
expect
    result = response("         hmmmmmmm...")
    result == "Whatever."

# ending with whitespace
expect
    result = response("Okay if like my  spacebar  quite a bit?   ")
    result == "Sure."

# other whitespace
expect
    result = response("\n\r \t")
    result == "Fine. Be that way!"

# non-question ending with whitespace
expect
    result = response("This is a statement ending with whitespace      ")
    result == "Whatever."

