# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/pig-latin/canonical-data.json
# File last updated on 2024-09-03
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import PigLatin exposing [translate]

##
## ay is added to words that start with vowels
##

# word beginning with a
expect
    result = translate "apple"
    result == "appleay"

# word beginning with e
expect
    result = translate "ear"
    result == "earay"

# word beginning with i
expect
    result = translate "igloo"
    result == "iglooay"

# word beginning with o
expect
    result = translate "object"
    result == "objectay"

# word beginning with u
expect
    result = translate "under"
    result == "underay"

# word beginning with a vowel and followed by a qu
expect
    result = translate "equal"
    result == "equalay"

##
## first letter and ay are moved to the end of words that start with consonants
##

# word beginning with p
expect
    result = translate "pig"
    result == "igpay"

# word beginning with k
expect
    result = translate "koala"
    result == "oalakay"

# word beginning with x
expect
    result = translate "xenon"
    result == "enonxay"

# word beginning with q without a following u
expect
    result = translate "qat"
    result == "atqay"

##
## some letter clusters are treated like a single consonant
##

# word beginning with ch
expect
    result = translate "chair"
    result == "airchay"

# word beginning with qu
expect
    result = translate "queen"
    result == "eenquay"

# word beginning with qu and a preceding consonant
expect
    result = translate "square"
    result == "aresquay"

# word beginning with th
expect
    result = translate "therapy"
    result == "erapythay"

# word beginning with thr
expect
    result = translate "thrush"
    result == "ushthray"

# word beginning with sch
expect
    result = translate "school"
    result == "oolschay"

##
## some letter clusters are treated like a single vowel
##

# word beginning with yt
expect
    result = translate "yttria"
    result == "yttriaay"

# word beginning with xr
expect
    result = translate "xray"
    result == "xrayay"

##
## position of y in a word determines if it is a consonant or a vowel
##

# y is treated like a consonant at the beginning of a word
expect
    result = translate "yellow"
    result == "ellowyay"

# y is treated like a vowel at the end of a consonant cluster
expect
    result = translate "rhythm"
    result == "ythmrhay"

# y as second letter in two letter word
expect
    result = translate "my"
    result == "ymay"

##
## phrases are translated
##

# a whole phrase
expect
    result = translate "quick fast run"
    result == "ickquay astfay unray"

