# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/bob/canonical-data.json
# File last updated on 2024-08-24
app [main] { pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br" }

import pf.Task exposing [Task]

main =
    Task.ok {}

import Bob exposing [response]

# stating something
expect response "Tom-ay-to, tom-aaaah-to." == "Whatever."

# shouting
expect response "WATCH OUT!" == "Whoa, chill out!"

# shouting gibberish
expect response "FCECDFCAAB" == "Whoa, chill out!"

# asking a question
expect response "Does this cryogenic chamber make me look fat?" == "Sure."

# asking a numeric question
expect response "You are, what, like 15?" == "Sure."

# asking gibberish
expect response "fffbbcbeab?" == "Sure."

# talking forcefully
expect response "Hi there!" == "Whatever."

# using acronyms in regular speech
expect response "It's OK if you don't want to go work for NASA." == "Whatever."

# forceful question
expect response "WHAT'S GOING ON?" == "Calm down, I know what I'm doing!"

# shouting numbers
expect response "1, 2, 3 GO!" == "Whoa, chill out!"

# no letters
expect response "1, 2, 3" == "Whatever."

# question with no letters
expect response "4?" == "Sure."

# shouting with special characters
expect response "ZOMG THE %^*@#\$(*^ ZOMBIES ARE COMING!!11!!1!" == "Whoa, chill out!"

# shouting with no exclamation mark
expect response "I HATE THE DENTIST" == "Whoa, chill out!"

# statement containing question mark
expect response "Ending with ? means a question." == "Whatever."

# non-letters with question
expect response ":) ?" == "Sure."

# prattling on
expect response "Wait! Hang on. Are you going to be OK?" == "Sure."

# silence
expect response "" == "Fine. Be that way!"

# prolonged silence
expect response "          " == "Fine. Be that way!"

# alternate silence
expect response "\t\t\t\t\t\t\t\t\t\t" == "Fine. Be that way!"

# multiple line question
expect response "\nDoes this cryogenic chamber make me look fat?\nNo." == "Whatever."

# starting with whitespace
expect response "         hmmmmmmm..." == "Whatever."

# ending with whitespace
expect response "Okay if like my  spacebar  quite a bit?   " == "Sure."

# other whitespace
expect response "\n\r \t" == "Fine. Be that way!"

# non-question ending with whitespace
expect response "This is a statement ending with whitespace      " == "Whatever."

