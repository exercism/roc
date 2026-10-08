SwiftScheduling :: {}.{
	Delivery : [Now, Asap, Eow, Month(U8), Quarter(U8)]

	delivery_date : { meeting_start : Str, delivery : Delivery } -> Try(Str, _)
	delivery_date = |{ meeting_start, delivery }| {
		crash "Please implement the 'delivery_date' function"
	}
}
