module [add]

import isodate.DateTime

future_datetime : Str -> Result Str [InvalidDateTimeFormat]
future_datetime = |moment|
    Ok(
        (
            DateTime.from_iso_str(moment)?
            |> DateTime.to_nanos_since_epoch
            |> Num.div_trunc(1_000_000_000) # nanos to seconds
            |> Num.add(1_000_000_000) # add a gigasecond
            |> Num.mul(1_000_000_000) # back to nanos
            |> DateTime.from_nanos_since_epoch
            |> DateTime.to_iso_str
        ),
    )

add : Str -> Str
add = |moment|
    when future_datetime(moment) is
        Ok(string) -> string
        Err(_) -> "Unexpected error"
