module [add]

import isodate.DateTime

futureDatetime : Str -> Result Str [InvalidDateTimeFormat]
futureDatetime = \moment ->
    Ok
        (
            DateTime.fromIsoStr? moment
                |> DateTime.toNanosSinceEpoch
                |> Num.divTrunc 1_000_000_000 # nanos to seconds
                |> Num.add 1_000_000_000 # add a gigasecond
                |> Num.mul 1_000_000_000 # back to nanos
                |> DateTime.fromNanosSinceEpoch
                |> DateTime.toIsoStr
        )

add : Str -> Str
add = \moment ->
    when futureDatetime moment is
        Ok string -> string
        Err _ -> "Unexpected error"
