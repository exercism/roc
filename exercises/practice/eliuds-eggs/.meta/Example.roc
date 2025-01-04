module [egg_count]

egg_count : U64 -> U64
egg_count = \number ->
    help = \count, remaining ->
        if remaining == 0 then
            count
        else
            digit = Num.rem remaining 2
            help (count + digit) (remaining // 2)

    help 0 number
