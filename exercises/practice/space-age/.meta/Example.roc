module [age]

round = \value, { digits ? 2 } ->
    pow = 10.0 |> Num.pow digits
    value * pow |> Num.round |> Num.toFrac |> Num.div pow

age = \planet, seconds ->
    periodInEarthYears = orbitalPeriodInEarthYears? planet
    periodInSeconds = periodInEarthYears * 365.25 * 24 * 60 * 60
    planetYears = seconds / periodInSeconds
    Ok (round planetYears {})

orbitalPeriodInEarthYears = \planet ->
    when planet is
        "Mercury" -> Ok 0.2408467
        "Venus" -> Ok 0.61519726
        "Earth" -> Ok 1.0
        "Mars" -> Ok 1.8808158
        "Jupiter" -> Ok 11.862615
        "Saturn" -> Ok 29.447498
        "Uranus" -> Ok 84.016846
        "Neptune" -> Ok 164.79132
        _ -> Err NotAPlanet
