# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/space-age/canonical-data.json
# File last updated on 2024-09-07
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import SpaceAge exposing [age]

# age on Earth
expect
    result = age Earth 1000000000
    Num.isApproxEq result 31.69 { atol: 0.01 }

# age on Mercury
expect
    result = age Mercury 2134835688
    Num.isApproxEq result 280.88 { atol: 0.01 }

# age on Venus
expect
    result = age Venus 189839836
    Num.isApproxEq result 9.78 { atol: 0.01 }

# age on Mars
expect
    result = age Mars 2129871239
    Num.isApproxEq result 35.88 { atol: 0.01 }

# age on Jupiter
expect
    result = age Jupiter 901876382
    Num.isApproxEq result 2.41 { atol: 0.01 }

# age on Saturn
expect
    result = age Saturn 2000000000
    Num.isApproxEq result 2.15 { atol: 0.01 }

# age on Uranus
expect
    result = age Uranus 1210123456
    Num.isApproxEq result 0.46 { atol: 0.01 }

# age on Neptune
expect
    result = age Neptune 1821023456
    Num.isApproxEq result 0.35 { atol: 0.01 }
