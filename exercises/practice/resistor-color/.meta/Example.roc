module [colorCode, colorCodeFromDict, colors]

colors =
    ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]

colorCode = \color ->
    colors |> List.findFirstIndex \elem -> elem == color

# Since the list of colors is quite small, representing it as a List is simple
# and efficient. However, if there were many more colors, it would make sense
# to use a Dict instead to avoid traversing the list at each lookup:
colorsDict =
    colors
    |> List.mapWithIndex \color, index -> (color, index)
    |> Dict.fromList

colorCodeFromDict = \color ->
    colorsDict |> Dict.get color
