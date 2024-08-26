module [colorCode, colors]

colors =
    ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]

colorCode = \color ->
    colors |> List.findFirstIndex \elem -> elem == color
