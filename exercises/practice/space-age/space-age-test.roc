# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/space-age/canonical-data.json
# File last updated on 2024-09-01
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br",
}

import pf.Task exposing [Task]

main =
    Task.ok {}

import SpaceAge exposing [age]

# age on Earth
expect
    result = age "Earth" 1000000000
    result == Ok 31.69

# age on Mercury
expect
    result = age "Mercury" 2134835688
    result == Ok 280.88

# age on Venus
expect
    result = age "Venus" 189839836
    result == Ok 9.78

# age on Mars
expect
    result = age "Mars" 2129871239
    result == Ok 35.88

# age on Jupiter
expect
    result = age "Jupiter" 901876382
    result == Ok 2.41

# age on Saturn
expect
    result = age "Saturn" 2000000000
    result == Ok 2.15

# age on Uranus
expect
    result = age "Uranus" 1210123456
    result == Ok 0.46

# age on Neptune
expect
    result = age "Neptune" 1821023456
    result == Ok 0.35

# invalid planet causes error
expect
    result = age "Sun" 680804807
    result == Err (PlanetArgWasNotAPlanet "Sun")

