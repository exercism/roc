module [grep]

import "iliad.txt" as iliad : Str
import "midsummer-night.txt" as midsummerNight : Str
import "paradise-lost.txt" as paradiseLost : Str

grep : Str, List Str, List Str -> Result Str _
grep = \pattern, flags, fileNames ->
    config = parseFlags? flags
    files = collectFiles? fileNames
    displayFileNames = List.len files > 1
    List.joinMap files \file ->
        when findMatches config pattern file.text is
            [] -> []
            _ if config.displayFileNames -> [file.name]
            matches ->
                List.map matches \{ line, index } ->
                    lineNumber =
                        if config.displayLineNumbers then
                            "$(index + 1 |> Num.toStr):"
                        else
                            ""
                    fileName =
                        if displayFileNames then
                            "$(file.name):"
                        else
                            ""
                    "$(fileName)$(lineNumber)$(line)"
    |> Str.joinWith "\n"
    |> Ok

findMatches : Config, Str, Str -> List { line : Str, index : U64 }
findMatches = \config, pattern, text ->
    Str.splitOn text "\n"
    |> List.mapWithIndex \line, index ->
        { line, index }
    |> List.keepIf \{ line } ->
        (lineToMatch, patternToMatch) =
            if config.ignoreCase then
                (toLower line, toLower pattern)
            else
                (line, pattern)

        matches =
            if config.matchFullLines then
                lineToMatch == patternToMatch
            else
                Str.contains lineToMatch patternToMatch

        # Using != is equivalent to xor which inverts `matches`
        config.invertResults != matches

toLower : Str -> Str
toLower = \str ->
    Str.toUtf8 str
    |> List.map \byte ->
        if 'A' <= byte && byte <= 'Z' then
            byte - 'A' + 'a'
        else
            byte
    |> Str.fromUtf8
    |> Result.withDefault ""

Config : {
    displayLineNumbers : Bool,
    displayFileNames : Bool,
    ignoreCase : Bool,
    matchFullLines : Bool,
    invertResults : Bool,
}

parseFlags : List Str -> Result Config _
parseFlags = \flags ->
    defaultConfig = {
        displayLineNumbers: Bool.false,
        displayFileNames: Bool.false,
        ignoreCase: Bool.false,
        matchFullLines: Bool.false,
        invertResults: Bool.false,
    }
    List.walkTry flags defaultConfig \config, flag ->
        when flag is
            "-l" -> Ok { config & displayFileNames: Bool.true }
            "-n" -> Ok { config & displayLineNumbers: Bool.true }
            "-i" -> Ok { config & ignoreCase: Bool.true }
            "-x" -> Ok { config & matchFullLines: Bool.true }
            "-v" -> Ok { config & invertResults: Bool.true }
            _ -> Err (UnknownFlag flag)

collectFiles : List Str -> Result (List { name : Str, text : Str }) _
collectFiles = \names ->
    List.mapTry names \name ->
        when name is
            "midsummer-night.txt" -> Ok { name: "midsummer-night.txt", text: midsummerNight }
            "iliad.txt" -> Ok { name: "iliad.txt", text: iliad }
            "paradise-lost.txt" -> Ok { name: "paradise-lost.txt", text: paradiseLost }
            _ -> Err (FileNotFound name)
