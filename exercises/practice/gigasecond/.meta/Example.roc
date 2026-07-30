import isodate.DateTime

Gigasecond :: {}.{
	add : Str -> Str
	add = |moment| {
		match future_datetime(moment) {
			Ok(string) => string
			Err(_) => "Unexpected error"
		}
	}
}

future_datetime : Str -> Try(Str, [InvalidDateTimeFormat, ..])
future_datetime = |moment| {
	nanos = DateTime.from_iso_str(moment)?.to_nanos_since_epoch()
	new_nanos = nanos
		.div_trunc_by(1_000_000_000.I128) # nanos to seconds
		.plus(1_000_000_000.I128) # add a gigasecond
		.times(1_000_000_000.I128) # back to nanos
	DateTime.from_nanos_since_epoch(new_nanos).to_iso_str()->Ok()
}
