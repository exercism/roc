module [two_fer]

two_fer : [Name Str, Anonymous] -> Str
two_fer = |name|
    when name is
        Anonymous -> "One for you, one for me."
        Name(n) -> "One for ${n}, one for me."
