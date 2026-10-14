##
## Example solution
##

# Refactoring log:
# - Split sorting, date, description, and amount formatting into focused helpers.
# - Shared digit grouping and replaced manual UTF-8 handling with Grapheme.split.
# - Replaced mutable state and flags with expressions, maps, and folds.
# - Used clearer names for dates, amounts, and comparison results.
# - Reduced nesting and duplication in currency and locale formatting.
# - Matched currencies and locales explicitly instead of relying on fallbacks.
# - Replaced the empty-string error sentinel with Try and error propagation.
# - Used isodate.Date for date parsing and formatting.
# - Preserved the public API; keep combining accents and emoji together when truncating.

import isodate.Date
import unicode.Grapheme

Ledger :: {}.{
	Currency : [Usd, Eur]
	Locale : [EnUs, NlNl]
	Entry : { date : Str, description : Str, amount_in_cents : I64 }

	format_entries : { currency : Currency, locale : Locale, entries : List(Entry) } -> Try(Str, [InvalidDateFormat])
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

format_date : Str, Ledger.Locale -> Try(Str, [InvalidDateFormat])
format_date = |date, locale| {
	parsed = Date.from_iso_str(date)?
	if parsed.to_iso_str() != date {
		return Err(InvalidDateFormat)
	}
	pattern = match locale {
		EnUs => "{MM}/{DD}/{YYYY}"
		NlNl => "{DD}-{MM}-{YYYY}"
	}
	Ok(parsed.format(pattern))
}

format_description : Str -> Str
format_description = |description| {
	graphemes = Grapheme.split(description)
	length = graphemes.len()
	if length <= 25 {
		description.concat(" ".repeat(25 - length))
	} else {
		prefix = graphemes.take_first(22) |> Str.join_with("")
		prefix.concat("...")
	}
}

format_number : I128, { group_separator : Str, decimal_separator : Str } -> Str
format_number = |cents, { group_separator, decimal_separator }| {
	group_whole = |whole| {
		if whole < 1000 {
			whole.to_str()
		} else {
			prefix = group_whole(whole // 1000)
			last_group = (whole % 1000).to_str()
			padded = "0".repeat(3 - last_group.to_utf8().len()).concat(last_group)
			"${prefix}${group_separator}${padded}"
		}
	}
	whole = group_whole(cents // 100)
	fraction = (cents % 100).to_str()
	padded = "0".repeat(2 - fraction.to_utf8().len()).concat(fraction)
	"${whole}${decimal_separator}${padded}"
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
	number = magnitude |> format_number({ group_separator, decimal_separator })
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
	length = (13).minus_saturated(Grapheme.split(formatted).len())
	" ".repeat(length).concat(formatted)
}
