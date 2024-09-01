# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/house/canonical-data.json
# File last updated on 2024-08-28
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import House exposing [recite]

# verse one - the house that jack built
expect
    result = recite 1 1
    result == "This is the house that Jack built."

# verse two - the malt that lay
expect
    result = recite 2 2
    result == "This is the malt that lay in the house that Jack built."

# verse three - the rat that ate
expect
    result = recite 3 3
    result == "This is the rat that ate the malt that lay in the house that Jack built."

# verse four - the cat that killed
expect
    result = recite 4 4
    result == "This is the cat that killed the rat that ate the malt that lay in the house that Jack built."

# verse five - the dog that worried
expect
    result = recite 5 5
    result == "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."

# verse six - the cow with the crumpled horn
expect
    result = recite 6 6
    result == "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."

# verse seven - the maiden all forlorn
expect
    result = recite 7 7
    result == "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."

# verse eight - the man all tattered and torn
expect
    result = recite 8 8
    result == "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."

# verse nine - the priest all shaven and shorn
expect
    result = recite 9 9
    result == "This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."

# verse 10 - the rooster that crowed in the morn
expect
    result = recite 10 10
    result == "This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."

# verse 11 - the farmer sowing his corn
expect
    result = recite 11 11
    result == "This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."

# verse 12 - the horse and the hound and the horn
expect
    result = recite 12 12
    result == "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."

# multiple verses
expect
    result = recite 4 8
    result == "This is the cat that killed the rat that ate the malt that lay in the house that Jack built.\nThis is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\nThis is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\nThis is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\nThis is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."

# full rhyme
expect
    result = recite 1 12
    result == "This is the house that Jack built.\nThis is the malt that lay in the house that Jack built.\nThis is the rat that ate the malt that lay in the house that Jack built.\nThis is the cat that killed the rat that ate the malt that lay in the house that Jack built.\nThis is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\nThis is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\nThis is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\nThis is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\nThis is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\nThis is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\nThis is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\nThis is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."

