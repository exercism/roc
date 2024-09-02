module [age]

age : Str, Dec -> Result Dec [NotAPlanet]
age = \planet, seconds ->
    crash "Please implement the 'age' function"
