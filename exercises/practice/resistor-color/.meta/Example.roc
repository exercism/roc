module [color_code, color_code_from_dict, colors]

colors : List Str
colors =
    ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]

color_code : Str -> Result U64 [NotFound]
color_code = \color ->
    colors |> List.findFirstIndex \elem -> elem == color

# Since the list of colors is quite small, representing it as a List is simple
# and efficient. However, if there were many more colors, it would make sense
# to use a Dict instead to avoid traversing the list at each lookup:
colors_dict =
    colors
    |> List.mapWithIndex \color, index -> (color, index)
    |> Dict.fromList

color_code_from_dict = \color ->
    colors_dict |> Dict.get color
