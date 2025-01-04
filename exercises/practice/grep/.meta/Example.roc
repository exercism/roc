module [grep]

import "iliad.txt" as iliad : Str
import "midsummer-night.txt" as midsummer_night : Str
import "paradise-lost.txt" as paradise_lost : Str

grep : Str, List Str, List Str -> Result Str _
grep = \pattern, flags, file_names ->
    config = parse_flags? flags
    files = collect_files? file_names
    display_file_names = List.len files > 1
    List.joinMap files \file ->
        when find_matches config pattern file.text is
            [] -> []
            _ if config.display_file_names -> [file.name]
            matches ->
                List.map matches \{ line, index } ->
                    line_number =
                        if config.display_line_numbers then
                            "$(index + 1 |> Num.toStr):"
                        else
                            ""
                    file_name =
                        if display_file_names then
                            "$(file.name):"
                        else
                            ""
                    "$(file_name)$(line_number)$(line)"
    |> Str.joinWith "\n"
    |> Ok

find_matches : Config, Str, Str -> List { line : Str, index : U64 }
find_matches = \config, pattern, text ->
    Str.splitOn text "\n"
    |> List.mapWithIndex \line, index ->
        { line, index }
    |> List.keepIf \{ line } ->
        (line_to_match, pattern_to_match) =
            if config.ignore_case then
                (to_lower line, to_lower pattern)
            else
                (line, pattern)

        matches =
            if config.match_full_lines then
                line_to_match == pattern_to_match
            else
                Str.contains line_to_match pattern_to_match

        # Using != is equivalent to xor which inverts `matches`
        config.invert_results != matches

to_lower : Str -> Str
to_lower = \str ->
    Str.toUtf8 str
    |> List.map \byte ->
        if 'A' <= byte && byte <= 'Z' then
            byte - 'A' + 'a'
        else
            byte
    |> Str.fromUtf8
    |> Result.withDefault ""

Config : {
    display_line_numbers : Bool,
    display_file_names : Bool,
    ignore_case : Bool,
    match_full_lines : Bool,
    invert_results : Bool,
}

parse_flags : List Str -> Result Config _
parse_flags = \flags ->
    default_config = {
        display_line_numbers: Bool.false,
        display_file_names: Bool.false,
        ignore_case: Bool.false,
        match_full_lines: Bool.false,
        invert_results: Bool.false,
    }
    List.walkTry flags default_config \config, flag ->
        when flag is
            "-l" -> Ok { config & display_file_names: Bool.true }
            "-n" -> Ok { config & display_line_numbers: Bool.true }
            "-i" -> Ok { config & ignore_case: Bool.true }
            "-x" -> Ok { config & match_full_lines: Bool.true }
            "-v" -> Ok { config & invert_results: Bool.true }
            _ -> Err (UnknownFlag flag)

collect_files : List Str -> Result (List { name : Str, text : Str }) _
collect_files = \names ->
    List.mapTry names \name ->
        when name is
            "midsummer-night.txt" -> Ok { name: "midsummer-night.txt", text: midsummer_night }
            "iliad.txt" -> Ok { name: "iliad.txt", text: iliad }
            "paradise-lost.txt" -> Ok { name: "paradise-lost.txt", text: paradise_lost }
            _ -> Err (FileNotFound name)