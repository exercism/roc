# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/collatz-conjecture/canonical-data.json
# File last updated on 2024-08-24
app [main] { pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br" }

import pf.Task exposing [Task]

main =
    Task.ok {}

import CollatzConjecture exposing [steps]

# zero steps for one
expect steps 1 == 0

# divide if even
expect steps 16 == 4

# even and odd steps
expect steps 12 == 9

# large number of even and odd steps
expect steps 1000000 == 152

