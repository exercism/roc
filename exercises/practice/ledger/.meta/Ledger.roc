Ledger :: {}.{
	Currency : [Usd, Eur]
	Locale : [EnUs, NlNl]
	Entry : { date : Str, description : Str, amount_in_cents : I64 }

	format_entries : { currency : Currency, locale : Locale, entries : List(Entry) } -> Try(Str, [InvalidDateFormat, ..])
	format_entries = |{ currency, locale, entries }| {
		rows = entries.sort_with(compare_entries).map_try(
			|entry| {
				date = format_date(entry.date, locale)?
				description = format_description(entry.description)
				amount = format_amount(entry.amount_in_cents, currency, locale)
				Ok("${date} | ${description} | ${amount}")
			},
		)?
		heading = match locale {
			EnUs => "Date       | Description               | Change       "
			NlNl => "Datum      | Omschrijving              | Verandering  "
		}
		Ok([heading].concat(rows) |> Str.join_with("\n"))
	}
}

compare_entries : Ledger.Entry, Ledger.Entry -> [Before, Same, After]
compare_entries = |a, b| match compare_text(a.date, b.date) {
	Same => match compare_text(a.description, b.description) {
		Same => a.amount_in_cents.order_relative_to(b.amount_in_cents)
		order => order
	}
	order => order
}

compare_text : Str, Str -> [Before, Same, After]
compare_text = |a, b| {
	compare_bytes = |left, right| match (left, right) {
		([], []) => Same
		([], _) => Before
		(_, []) => After
		([x, .. as xs], [y, .. as ys]) => match x.order_relative_to(y) {
			Same => compare_bytes(xs, ys)
			order => order
		}
	}
	compare_bytes(a.to_utf8(), b.to_utf8())
}

format_date : Str, Ledger.Locale -> Try(Str, [InvalidDateFormat, ..])
format_date = |date, locale| match date.split_on("-") {
	[year, month, day] if year.to_utf8().len() == 4 and month.to_utf8().len() == 2 and day.to_utf8().len() == 2 => {
		digits = year.concat(month).concat(day).to_utf8()
		if !digits.all(|byte| byte >= '0' and byte <= '9') {
			return Err(InvalidDateFormat)
		}
		Ok(
			match locale {
				EnUs => "${month}/${day}/${year}"
				NlNl => "${day}-${month}-${year}"
			},
		)
	}
	_ => Err(InvalidDateFormat)
}

character_count : Str -> U64
character_count = |text| text.to_utf8().keep_if(|byte| byte < 128 or byte >= 192).len()

format_description : Str -> Str
format_description = |description| {
	length = character_count(description)
	if length <= 25 {
		description.concat(" ".repeat(25 - length))
	} else {
		prefix = description.to_utf8().fold(
			{ count: 0, bytes: [] },
			|acc, byte| {
				count = if byte < 128 or byte >= 192 {
					acc.count + 1
				} else {
					acc.count
				}
				{
					count,
					bytes: if count <= 22 {
						acc.bytes.append(byte)
					} else {
						acc.bytes
					},
				}
			},
		)
		Str.from_utf8_lossy(prefix.bytes).concat("...")
	}
}

group_digits : Str, Str -> Str
group_digits = |digits, separator| {
	bytes = digits.to_utf8()
	bytes.map_with_index(
		|byte, index| {
			digit = Str.from_utf8_lossy([byte])
			if index > 0 and (bytes.len() - index) % 3 == 0 {
				separator.concat(digit)
			} else {
				digit
			}
		},
	)
		|> Str.join_with("")
}

format_amount : I64, Ledger.Currency, Ledger.Locale -> Str
format_amount = |amount, currency, locale| {
	symbol = match currency {
		Usd => "$"
		Eur => "€"
	}
	magnitude = if amount < 0 {
		-amount.to_i128()
	} else {
		amount.to_i128()
	}
	(group_separator, decimal_separator) = match locale {
		EnUs => (",", ".")
		NlNl => (".", ",")
	}
	whole = group_digits((magnitude // 100).to_str(), group_separator)
	fraction = (magnitude % 100).to_str()
	cents = "0".repeat(2 - fraction.to_utf8().len()).concat(fraction)
	number = "${whole}${decimal_separator}${cents}"
	formatted = match locale {
		EnUs => if amount < 0 {
			"(${symbol}${number})"
		} else {
			"${symbol}${number} "
		}
		NlNl => if amount < 0 {
			"${symbol} -${number} "
		} else {
			"${symbol} ${number} "
		}
	}
	" ".repeat((13).minus_saturated(character_count(formatted))).concat(formatted)
}
