# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/hello-world/canonical-data.json
# File last updated on 2024-08-23

app [main] { pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.12.0/Lb8EgiejTUzbggO2HVVuPJFkwvvsfW6LojkLR20kTVE.tar.br" }

import pf.Task exposing [Task]

main =
    Task.ok {}

import HelloWorld exposing [hello]

# Say Hi!
expect hello == "Hello, World!"


