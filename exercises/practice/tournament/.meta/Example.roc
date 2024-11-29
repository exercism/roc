module [tally]

MatchResult : [Win, Loss, Draw]
TeamTally : { mp : U64, w : U64, d : U64, l : U64, p : U64 }

tally : Str -> Result Str [InvalidRow Str, InvalidResult Str]
tally = \table ->
    if table == "" then
        Ok header
        else

    table
        |> Str.splitOn "\n"
        |> List.mapTry? \row ->
            when row |> Str.splitOn ";" is
                [team1, team2, resultStr] ->
                    result = resultStr |> parseResult?
                    Ok (team1, team2, result)

                _ -> Err (InvalidRow row)
        |> List.walk (Dict.empty {}) \tallyDict, (team1, team2, result) ->
            tallyDict
            |> updateTallyDict team1 result
            |> updateTallyDict team2 (oppositeResult result)
        |> tallyDictToTable
        |> Ok

parseResult : Str -> Result MatchResult [InvalidResult Str]
parseResult = \resultStr ->
    when resultStr is
        "win" -> Ok Win
        "loss" -> Ok Loss
        "draw" -> Ok Draw
        _ -> Err (InvalidResult resultStr)

oppositeResult : MatchResult -> MatchResult
oppositeResult = \result ->
    when result is
        Win -> Loss
        Loss -> Win
        Draw -> Draw

updateTallyDict : Dict Str TeamTally, Str, MatchResult -> Dict Str TeamTally
updateTallyDict = \tallyDict, team, result ->
    tallyDict
    |> Dict.update team \maybeTeamTally ->
        when maybeTeamTally is
            Ok teamTally -> Ok (teamTally |> updateTeamTally result)
            Err Missing -> Ok ({ mp: 0, w: 0, d: 0, l: 0, p: 0 } |> updateTeamTally result)

updateTeamTally : TeamTally, MatchResult -> TeamTally
updateTeamTally = \teamTally, result ->
    when result is
        Win -> { teamTally & mp: teamTally.mp + 1, w: teamTally.w + 1, p: teamTally.p + 3 }
        Draw -> { teamTally & mp: teamTally.mp + 1, d: teamTally.d + 1, p: teamTally.p + 1 }
        Loss -> { teamTally & mp: teamTally.mp + 1, l: teamTally.l + 1 }

tallyDictToTable : Dict Str TeamTally -> Str
tallyDictToTable = \tallyDict ->
    tableContent =
        tallyDict
        |> Dict.toList
        |> List.sortWith \(team1, teamTally1), (team2, teamTally2) ->
            when Num.compare teamTally1.p teamTally2.p is
                GT -> LT
                LT -> GT
                EQ -> compareStrings team1 team2
        |> List.map \(team, teamTally) ->
            tallyColumns =
                [.mp, .w, .d, .l, .p]
                |> List.map \field -> teamTally |> field |> alignRight
                |> Str.joinWith " | "
            "$(team |> padRight 30) | $(tallyColumns)"
        |> Str.joinWith "\n"
    "$(header)\n$(tableContent)"

header : Str
header = "Team                           | MP |  W |  D |  L |  P"

## Compare two strings, first by their UTF8 representations, then by length:
## "" < "ABC" < "abc" < "abcdef"
compareStrings : Str, Str -> [LT, EQ, GT]
compareStrings = \string1, string2 ->
    b1 = string1 |> Str.toUtf8
    b2 = string2 |> Str.toUtf8
    result =
        List.map2 b1 b2 \c1, c2 -> Num.compare c1 c2
        |> List.walkTry (Ok EQ) \_state, cmp ->
            when cmp is
                EQ -> Ok EQ
                res -> Err res
    when result is
        Ok _cmp -> Num.compare (List.len b1) (List.len b2)
        Err res -> res

## Pad a string with spaces on the right to reach a given width.
## Warning: this function assumes that the input string is ASCII
padRight : Str, U64 -> Str
padRight = \string, width ->
    chars = string |> Str.toUtf8
    length = chars |> List.len
    spaces = if length < width then List.repeat " " (width - length) |> Str.joinWith "" else ""
    "$(string)$(spaces)"

## Convert a number to a right-aligned string of width 2 or more
alignRight : U64 -> Str
alignRight = \number ->
    if number < 10 then " $(number |> Num.toStr)" else "$(number |> Num.toStr)"
