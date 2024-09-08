module [age]

Planet : [
    Mercury,
    Venus,
    Earth,
    Mars,
    Jupiter,
    Saturn,
    Uranus,
    Neptune,
]

age : Planet, Dec -> Dec
age = \planet, seconds ->
    periodInEarthYears = orbitalPeriodInEarthYears planet
    periodInSeconds = periodInEarthYears * 365.25 * 24 * 60 * 60
    planetYears = seconds / periodInSeconds
    round planetYears

round : Dec -> Dec
round = \value ->
    pow = 10.0 |> Num.pow 2
    value * pow |> Num.round |> Num.toFrac |> Num.div pow

orbitalPeriodInEarthYears = \planet ->
    when planet is
        Mercury -> 0.2408467
        Venus -> 0.61519726
        Earth -> 1.0
        Mars -> 1.8808158
        Jupiter -> 11.862615
        Saturn -> 29.447498
        Uranus -> 84.016846
        Neptune -> 164.79132
