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
                [team1, team2, result_str] ->
                    result = result_str |> parse_result?
                    Ok (team1, team2, result)

                _ -> Err (InvalidRow row)
        |> List.walk (Dict.empty {}) \tally_dict, (team1, team2, result) ->
            tally_dict
            |> update_tally_dict team1 result
            |> update_tally_dict team2 (opposite_result result)
        |> tally_dict_to_table
        |> Ok

parse_result : Str -> Result MatchResult [InvalidResult Str]
parse_result = \result_str ->
    when result_str is
        "win" -> Ok Win
        "loss" -> Ok Loss
        "draw" -> Ok Draw
        _ -> Err (InvalidResult result_str)

opposite_result : MatchResult -> MatchResult
opposite_result = \result ->
    when result is
        Win -> Loss
        Loss -> Win
        Draw -> Draw

update_tally_dict : Dict Str TeamTally, Str, MatchResult -> Dict Str TeamTally
update_tally_dict = \tally_dict, team, result ->
    tally_dict
    |> Dict.update team \maybe_team_tally ->
        when maybe_team_tally is
            Ok team_tally -> Ok (team_tally |> update_team_tally result)
            Err Missing -> Ok ({ mp: 0, w: 0, d: 0, l: 0, p: 0 } |> update_team_tally result)

update_team_tally : TeamTally, MatchResult -> TeamTally
update_team_tally = \team_tally, result ->
    when result is
        Win -> { team_tally & mp: team_tally.mp + 1, w: team_tally.w + 1, p: team_tally.p + 3 }
        Draw -> { team_tally & mp: team_tally.mp + 1, d: team_tally.d + 1, p: team_tally.p + 1 }
        Loss -> { team_tally & mp: team_tally.mp + 1, l: team_tally.l + 1 }

tally_dict_to_table : Dict Str TeamTally -> Str
tally_dict_to_table = \tally_dict ->
    table_content =
        tally_dict
        |> Dict.toList
        |> List.sortWith \(team1, team_tally1), (team2, team_tally2) ->
            when Num.compare team_tally1.p team_tally2.p is
                GT -> LT
                LT -> GT
                EQ -> compare_strings team1 team2
        |> List.map \(team, team_tally) ->
            tally_columns =
                [.mp, .w, .d, .l, .p]
                |> List.map \field -> team_tally |> field |> align_right
                |> Str.joinWith " | "
            "$(team |> pad_right 30) | $(tally_columns)"
        |> Str.joinWith "\n"
    "$(header)\n$(table_content)"

header : Str
header = "Team                           | MP |  W |  D |  L |  P"

compare_strings : Str, Str -> [LT, EQ, GT]
compare_strings = \string1, string2 ->
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

pad_right : Str, U64 -> Str
pad_right = \string, width ->
    chars = string |> Str.toUtf8
    length = chars |> List.len
    spaces = if length < width then List.repeat " " (width - length) |> Str.joinWith "" else ""
    "$(string)$(spaces)"

align_right : U64 -> Str
align_right = \number ->
    if number < 10 then " $(number |> Num.toStr)" else "$(number |> Num.toStr)"