# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/ledger/canonical-data.json
# File last updated on 2026-09-27
app [] {
	isodate: "https://github.com/ageron/roc-isodate/releases/download/v0.8.4/8nYCkCKi8sCi2poruWpkdqTp7W4jnEpKHRK84xKUrmJo.tar.zst",
	unicode: "https://github.com/roc-lang/unicode/releases/download/4.2.0/4W8SHzvwet9hH9qZewJ1J1CVQoH7YKA6zyijWFTB3y1w.tar.zst",
}

import Ledger exposing [format_entries]

## empty ledger
expect {
	result = format_entries({
		currency: Usd,
		locale: EnUs,
		entries: [],
	})?
	result == "Date       | Description               | Change       "
}

## one entry
expect {
	result = format_entries({
		currency: Usd,
		locale: EnUs,
		entries: [
			{
				date: "2015-01-01",
				description: "Buy present",
				amount_in_cents: -1000,
			},
		],
	})?
	result ==
		\\Date       | Description               | Change       
		\\01/01/2015 | Buy present               |      ($10.00)
}

## credit and debit
expect {
	result = format_entries({
		currency: Usd,
		locale: EnUs,
		entries: [
			{
				date: "2015-01-02",
				description: "Get present",
				amount_in_cents: 1000,
			},
			{
				date: "2015-01-01",
				description: "Buy present",
				amount_in_cents: -1000,
			},
		],
	})?
	result ==
		\\Date       | Description               | Change       
		\\01/01/2015 | Buy present               |      ($10.00)
		\\01/02/2015 | Get present               |       $10.00 
}

## final order tie breaker is change
expect {
	result = format_entries({
		currency: Usd,
		locale: EnUs,
		entries: [
			{
				date: "2015-01-01",
				description: "Something",
				amount_in_cents: 0,
			},
			{
				date: "2015-01-01",
				description: "Something",
				amount_in_cents: -1,
			},
			{
				date: "2015-01-01",
				description: "Something",
				amount_in_cents: 1,
			},
		],
	})?
	result ==
		\\Date       | Description               | Change       
		\\01/01/2015 | Something                 |       ($0.01)
		\\01/01/2015 | Something                 |        $0.00 
		\\01/01/2015 | Something                 |        $0.01 
}

## overlong description is truncated
expect {
	result = format_entries({
		currency: Usd,
		locale: EnUs,
		entries: [
			{
				date: "2015-01-01",
				description: "Freude schoner Gotterfunken",
				amount_in_cents: -123456,
			},
		],
	})?
	result ==
		\\Date       | Description               | Change       
		\\01/01/2015 | Freude schoner Gotterf... |   ($1,234.56)
}

## euros
expect {
	result = format_entries({
		currency: Eur,
		locale: EnUs,
		entries: [
			{
				date: "2015-01-01",
				description: "Buy present",
				amount_in_cents: -1000,
			},
		],
	})?
	result ==
		\\Date       | Description               | Change       
		\\01/01/2015 | Buy present               |      (€10.00)
}

## Dutch locale
expect {
	result = format_entries({
		currency: Usd,
		locale: NlNl,
		entries: [
			{
				date: "2015-03-12",
				description: "Buy present",
				amount_in_cents: 123456,
			},
		],
	})?
	result ==
		\\Datum      | Omschrijving              | Verandering  
		\\12-03-2015 | Buy present               |   $ 1.234,56 
}

## Dutch locale and euros
expect {
	result = format_entries({
		currency: Eur,
		locale: NlNl,
		entries: [
			{
				date: "2015-03-12",
				description: "Buy present",
				amount_in_cents: 123456,
			},
		],
	})?
	result ==
		\\Datum      | Omschrijving              | Verandering  
		\\12-03-2015 | Buy present               |   € 1.234,56 
}

## Dutch negative number with 3 digits before decimal point
expect {
	result = format_entries({
		currency: Usd,
		locale: NlNl,
		entries: [
			{
				date: "2015-03-12",
				description: "Buy present",
				amount_in_cents: -12345,
			},
		],
	})?
	result ==
		\\Datum      | Omschrijving              | Verandering  
		\\12-03-2015 | Buy present               |    $ -123,45 
}

## American negative number with 3 digits before decimal point
expect {
	result = format_entries({
		currency: Usd,
		locale: EnUs,
		entries: [
			{
				date: "2015-03-12",
				description: "Buy present",
				amount_in_cents: -12345,
			},
		],
	})?
	result ==
		\\Date       | Description               | Change       
		\\03/12/2015 | Buy present               |     ($123.45)
}

## multiple entries on same date ordered by description
expect {
	result = format_entries({
		currency: Usd,
		locale: EnUs,
		entries: [
			{
				date: "2015-01-01",
				description: "Get present",
				amount_in_cents: 1000,
			},
			{
				date: "2015-01-01",
				description: "Buy present",
				amount_in_cents: -1000,
			},
		],
	})?
	result ==
		\\Date       | Description               | Change       
		\\01/01/2015 | Buy present               |      ($10.00)
		\\01/01/2015 | Get present               |       $10.00 
}

## empty Dutch ledger
expect {
	result = format_entries({
		currency: Eur,
		locale: NlNl,
		entries: [],
	})?
	result == "Datum      | Omschrijving              | Verandering  "
}

## dates sort across year boundaries
expect {
	result = format_entries({
		currency: Usd,
		locale: EnUs,
		entries: [
			{
				date: "2025-01-01",
				description: "New year",
				amount_in_cents: 100,
			},
			{
				date: "2024-12-31",
				description: "Year end",
				amount_in_cents: -100,
			},
		],
	})?
	result ==
		\\Date       | Description               | Change       
		\\12/31/2024 | Year end                  |       ($1.00)
		\\01/01/2025 | New year                  |        $1.00 
}

## descriptions of exactly 25 characters are not truncated
expect {
	result = format_entries({
		currency: Usd,
		locale: EnUs,
		entries: [
			{
				date: "2025-01-01",
				description: "1234567890123456789012345",
				amount_in_cents: 0,
			},
		],
	})?
	result ==
		\\Date       | Description               | Change       
		\\01/01/2025 | 1234567890123456789012345 |        $0.00 
}

## descriptions of 26 characters are truncated
expect {
	result = format_entries({
		currency: Usd,
		locale: EnUs,
		entries: [
			{
				date: "2025-01-01",
				description: "12345678901234567890123456",
				amount_in_cents: 0,
			},
		],
	})?
	result ==
		\\Date       | Description               | Change       
		\\01/01/2025 | 1234567890123456789012... |        $0.00 
}

## Unicode descriptions are padded by character count
expect {
	result = format_entries({
		currency: Eur,
		locale: NlNl,
		entries: [
			{
				date: "2025-01-01",
				description: "Café",
				amount_in_cents: -101,
			},
		],
	})?
	result ==
		\\Datum      | Omschrijving              | Verandering  
		\\01-01-2025 | Café                      |      € -1,01 
}

## truncation preserves complete Unicode characters
expect {
	result = format_entries({
		currency: Eur,
		locale: EnUs,
		entries: [
			{
				date: "2025-01-01",
				description: "éééééééééééééééééééééééééé",
				amount_in_cents: 101,
			},
		],
	})?
	result ==
		\\Date       | Description               | Change       
		\\01/01/2025 | éééééééééééééééééééééé... |        €1.01 
}

## full descriptions determine order before truncation
expect {
	result = format_entries({
		currency: Usd,
		locale: EnUs,
		entries: [
			{
				date: "2025-01-01",
				description: "AAAAAAAAAAAAAAAAAAAAAAAAAz",
				amount_in_cents: -100,
			},
			{
				date: "2025-01-01",
				description: "AAAAAAAAAAAAAAAAAAAAAAAAAa",
				amount_in_cents: 100,
			},
		],
	})?
	result ==
		\\Date       | Description               | Change       
		\\01/01/2025 | AAAAAAAAAAAAAAAAAAAAAA... |        $1.00 
		\\01/01/2025 | AAAAAAAAAAAAAAAAAAAAAA... |       ($1.00)
}

## large amounts use repeated grouping and expand the column
expect {
	result = format_entries({
		currency: Eur,
		locale: NlNl,
		entries: [
			{
				date: "2025-01-01",
				description: "Large amount",
				amount_in_cents: 1234567890123,
			},
		],
	})?
	result ==
		\\Datum      | Omschrijving              | Verandering  
		\\01-01-2025 | Large amount              | € 12.345.678.901,23 
}

## the smallest signed amount formats without overflow
expect {
	result = format_entries({
		currency: Usd,
		locale: EnUs,
		entries: [
			{
				date: "2025-01-01",
				description: "Minimum",
				amount_in_cents: -9223372036854775808,
			},
		],
	})?
	result ==
		\\Date       | Description               | Change       
		\\01/01/2025 | Minimum                   | ($92,233,720,368,547,758.08)
}

## invalid date formats return an error
expect {
	result = format_entries({
		currency: Usd,
		locale: EnUs,
		entries: [
			{
				date: "2025/01/01",
				description: "Invalid date",
				amount_in_cents: 1,
			},
		],
	})
	result.is_err()
}
