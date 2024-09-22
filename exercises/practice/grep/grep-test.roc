# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/grep/canonical-data.json
# File last updated on 2024-09-15
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import Grep exposing [grep]

# Test grepping a single file - One file, one match, no flags
expect
    result = grep "Agamemnon" [] ["iliad.txt"]
    result == Ok "Of Atreus, Agamemnon, King of men."

# Test grepping a single file - One file, one match, print line numbers flag
expect
    result = grep "Forbidden" ["-n"] ["paradise-lost.txt"]
    result == Ok "2:Of that Forbidden Tree, whose mortal tast"

# Test grepping a single file - One file, one match, case-insensitive flag
expect
    result = grep "FORBIDDEN" ["-i"] ["paradise-lost.txt"]
    result == Ok "Of that Forbidden Tree, whose mortal tast"

# Test grepping a single file - One file, one match, print file names flag
expect
    result = grep "Forbidden" ["-l"] ["paradise-lost.txt"]
    result == Ok "paradise-lost.txt"

# Test grepping a single file - One file, one match, match entire lines flag
expect
    result = grep "With loss of Eden, till one greater Man" ["-x"] ["paradise-lost.txt"]
    result == Ok "With loss of Eden, till one greater Man"

# Test grepping a single file - One file, one match, multiple flags
expect
    result = grep "OF ATREUS, Agamemnon, KIng of MEN." ["-n", "-i", "-x"] ["iliad.txt"]
    result == Ok "9:Of Atreus, Agamemnon, King of men."

# Test grepping a single file - One file, several matches, no flags
expect
    result = grep "may" [] ["midsummer-night.txt"]
    result
    == Ok
        """
        Nor how it may concern my modesty,
        But I beseech your grace that I may know
        The worst that may befall me in this case,
        """

# Test grepping a single file - One file, several matches, print line numbers flag
expect
    result = grep "may" ["-n"] ["midsummer-night.txt"]
    result
    == Ok
        """
        3:Nor how it may concern my modesty,
        5:But I beseech your grace that I may know
        6:The worst that may befall me in this case,
        """

# Test grepping a single file - One file, several matches, match entire lines flag
expect
    result = grep "may" ["-x"] ["midsummer-night.txt"]
    result == Ok ""

# Test grepping a single file - One file, several matches, case-insensitive flag
expect
    result = grep "ACHILLES" ["-i"] ["iliad.txt"]
    result
    == Ok
        """
        Achilles sing, O Goddess! Peleus' son;
        The noble Chief Achilles from the son
        """

# Test grepping a single file - One file, several matches, inverted flag
expect
    result = grep "Of" ["-v"] ["paradise-lost.txt"]
    result
    == Ok
        """
        Brought Death into the World, and all our woe,
        With loss of Eden, till one greater Man
        Restore us, and regain the blissful Seat,
        Sing Heav'nly Muse, that on the secret top
        That Shepherd, who first taught the chosen Seed
        """

# Test grepping a single file - One file, no matches, various flags
expect
    result = grep "Gandalf" ["-n", "-l", "-x", "-i"] ["iliad.txt"]
    result == Ok ""

# Test grepping a single file - One file, one match, file flag takes precedence over line flag
expect
    result = grep "ten" ["-n", "-l"] ["iliad.txt"]
    result == Ok "iliad.txt"

# Test grepping a single file - One file, several matches, inverted and match entire lines flags
expect
    result = grep "Illustrious into Ades premature," ["-x", "-v"] ["iliad.txt"]
    result
    == Ok
        """
        Achilles sing, O Goddess! Peleus' son;
        His wrath pernicious, who ten thousand woes
        Caused to Achaia's host, sent many a soul
        And Heroes gave (so stood the will of Jove)
        To dogs and to all ravening fowls a prey,
        When fierce dispute had separated once
        The noble Chief Achilles from the son
        Of Atreus, Agamemnon, King of men.
        """

# Test grepping multiples files at once - Multiple files, one match, no flags
expect
    result = grep "Agamemnon" [] ["iliad.txt", "midsummer-night.txt", "paradise-lost.txt"]
    result == Ok "iliad.txt:Of Atreus, Agamemnon, King of men."

# Test grepping multiples files at once - Multiple files, several matches, no flags
expect
    result = grep "may" [] ["iliad.txt", "midsummer-night.txt", "paradise-lost.txt"]
    result
    == Ok
        """
        midsummer-night.txt:Nor how it may concern my modesty,
        midsummer-night.txt:But I beseech your grace that I may know
        midsummer-night.txt:The worst that may befall me in this case,
        """

# Test grepping multiples files at once - Multiple files, several matches, print line numbers flag
expect
    result = grep "that" ["-n"] ["iliad.txt", "midsummer-night.txt", "paradise-lost.txt"]
    result
    == Ok
        """
        midsummer-night.txt:5:But I beseech your grace that I may know
        midsummer-night.txt:6:The worst that may befall me in this case,
        paradise-lost.txt:2:Of that Forbidden Tree, whose mortal tast
        paradise-lost.txt:6:Sing Heav'nly Muse, that on the secret top
        """

# Test grepping multiples files at once - Multiple files, one match, print file names flag
expect
    result = grep "who" ["-l"] ["iliad.txt", "midsummer-night.txt", "paradise-lost.txt"]
    result
    == Ok
        """
        iliad.txt
        paradise-lost.txt
        """

# Test grepping multiples files at once - Multiple files, several matches, case-insensitive flag
expect
    result = grep "TO" ["-i"] ["iliad.txt", "midsummer-night.txt", "paradise-lost.txt"]
    result
    == Ok
        """
        iliad.txt:Caused to Achaia's host, sent many a soul
        iliad.txt:Illustrious into Ades premature,
        iliad.txt:And Heroes gave (so stood the will of Jove)
        iliad.txt:To dogs and to all ravening fowls a prey,
        midsummer-night.txt:I do entreat your grace to pardon me.
        midsummer-night.txt:In such a presence here to plead my thoughts;
        midsummer-night.txt:If I refuse to wed Demetrius.
        paradise-lost.txt:Brought Death into the World, and all our woe,
        paradise-lost.txt:Restore us, and regain the blissful Seat,
        paradise-lost.txt:Sing Heav'nly Muse, that on the secret top
        """

# Test grepping multiples files at once - Multiple files, several matches, inverted flag
expect
    result = grep "a" ["-v"] ["iliad.txt", "midsummer-night.txt", "paradise-lost.txt"]
    result
    == Ok
        """
        iliad.txt:Achilles sing, O Goddess! Peleus' son;
        iliad.txt:The noble Chief Achilles from the son
        midsummer-night.txt:If I refuse to wed Demetrius.
        """

# Test grepping multiples files at once - Multiple files, one match, match entire lines flag
expect
    result = grep "But I beseech your grace that I may know" ["-x"] ["iliad.txt", "midsummer-night.txt", "paradise-lost.txt"]
    result == Ok "midsummer-night.txt:But I beseech your grace that I may know"

# Test grepping multiples files at once - Multiple files, one match, multiple flags
expect
    result = grep "WITH LOSS OF EDEN, TILL ONE GREATER MAN" ["-n", "-i", "-x"] ["iliad.txt", "midsummer-night.txt", "paradise-lost.txt"]
    result == Ok "paradise-lost.txt:4:With loss of Eden, till one greater Man"

# Test grepping multiples files at once - Multiple files, no matches, various flags
expect
    result = grep "Frodo" ["-n", "-l", "-x", "-i"] ["iliad.txt", "midsummer-night.txt", "paradise-lost.txt"]
    result == Ok ""

# Test grepping multiples files at once - Multiple files, several matches, file flag takes precedence over line number flag
expect
    result = grep "who" ["-n", "-l"] ["iliad.txt", "midsummer-night.txt", "paradise-lost.txt"]
    result
    == Ok
        """
        iliad.txt
        paradise-lost.txt
        """

# Test grepping multiples files at once - Multiple files, several matches, inverted and match entire lines flags
expect
    result = grep "Illustrious into Ades premature," ["-x", "-v"] ["iliad.txt", "midsummer-night.txt", "paradise-lost.txt"]
    result
    == Ok
        """
        iliad.txt:Achilles sing, O Goddess! Peleus' son;
        iliad.txt:His wrath pernicious, who ten thousand woes
        iliad.txt:Caused to Achaia's host, sent many a soul
        iliad.txt:And Heroes gave (so stood the will of Jove)
        iliad.txt:To dogs and to all ravening fowls a prey,
        iliad.txt:When fierce dispute had separated once
        iliad.txt:The noble Chief Achilles from the son
        iliad.txt:Of Atreus, Agamemnon, King of men.
        midsummer-night.txt:I do entreat your grace to pardon me.
        midsummer-night.txt:I know not by what power I am made bold,
        midsummer-night.txt:Nor how it may concern my modesty,
        midsummer-night.txt:In such a presence here to plead my thoughts;
        midsummer-night.txt:But I beseech your grace that I may know
        midsummer-night.txt:The worst that may befall me in this case,
        midsummer-night.txt:If I refuse to wed Demetrius.
        paradise-lost.txt:Of Mans First Disobedience, and the Fruit
        paradise-lost.txt:Of that Forbidden Tree, whose mortal tast
        paradise-lost.txt:Brought Death into the World, and all our woe,
        paradise-lost.txt:With loss of Eden, till one greater Man
        paradise-lost.txt:Restore us, and regain the blissful Seat,
        paradise-lost.txt:Sing Heav'nly Muse, that on the secret top
        paradise-lost.txt:Of Oreb, or of Sinai, didst inspire
        paradise-lost.txt:That Shepherd, who first taught the chosen Seed
        """

