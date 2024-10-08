module [twoFer]

twoFer : [Name Str, Anonymous] -> Str
twoFer = \name ->
    when name is
        Anonymous -> "One for you, one for me."
        Name n -> "One for $(n), one for me."
