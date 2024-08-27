module [value]

allColors = ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]

colorCode = \color ->
    allColors |> List.findFirstIndex \elem -> elem == color

value = \colors ->
    first = colors |> List.get? 0 |> colorCode?
    second = colors |> List.get? 1 |> colorCode?
    10 * first + second |> Ok
