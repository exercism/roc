Ledger :: {}.{
	Currency : [Usd, Eur]
	Locale : [EnUs, NlNl]
	Entry : { date : Str, description : Str, amount_in_cents : I64 }

	format_entries : { currency : Currency, locale : Locale, entries : List(Entry) } -> Try(Str, [InvalidDateFormat, ..])
	format_entries = |{ currency, locale, entries }| {
		cmp = |a, b| {
			cmp_bytes = |a_bytes, b_bytes| match (a_bytes, b_bytes) {
				([], []) => Same
				([], _) => Before
				(_, []) => After
				([x, .. as xs], [y, .. as ys]) => if x == y {
					cmp_bytes(xs, ys)
				} else {
					x.order_relative_to(y)
				}
			}
			cmp_bytes(a.to_utf8(), b.to_utf8())
		}
		sorted = entries.sort_with(
			|a, b| {
				d = cmp(a.date, b.date)
				if d == Same {
					e = cmp(a.description, b.description)
					if e == Same {
						a.amount_in_cents.order_relative_to(b.amount_in_cents)
					} else {
						e
					}
				} else {
					d
				}
			},
		)
		var $text = if locale == EnUs {
			"Date       | Description               | Change       "
		} else {
			"Datum      | Omschrijving              | Verandering  "
		}
		for entry in sorted {
			date = match entry.date.split_on("-") {
				[y, m, d] if y.to_utf8().len() == 4 and m.to_utf8().len() == 2 and d.to_utf8().len() == 2 => {
					if !y.concat(m).concat(d).to_utf8().all(|b| b >= '0' and b <= '9') {
						return Err(InvalidDateFormat)
					}
					if locale == EnUs {
						"${m}/${d}/${y}"
					} else {
						"${d}-${m}-${y}"
					}
				}
				_ => return Err(InvalidDateFormat)
			}
			var $n = 0.U64
			var $bytes = []
			for b in entry.description.to_utf8() {
				if b < 128 or b >= 192 {
					$n = $n + 1
				}
				if $n <= 22 {
					$bytes = $bytes.append(b)
				}
			}
			var $description = entry.description
			if $n > 25 {
				$description = Str.from_utf8_lossy($bytes).concat("...")
			} else {
				$description = $description.concat(" ".repeat(25 - $n))
			}
			a = entry.amount_in_cents.to_i128()
			p = if a < 0 {
				-a
			} else {
				a
			}
			ds = (p // 100).to_str().to_utf8()
			var $number = ""
			for (b, i) in ds.map_with_index(|b, i| (b, i)) {
				if i > 0 and (ds.len() - i) % 3 == 0 {
					if locale == EnUs {
						$number = $number.concat(",")
					} else {
						$number = $number.concat(".")
					}
				}
				$number = $number.concat(Str.from_utf8_lossy([b]))
			}
			if locale == EnUs {
				$number = $number.concat(".")
			} else {
				$number = $number.concat(",")
			}
			if p % 100 < 10 {
				$number = $number.concat("0")
			}
			$number = $number.concat((p % 100).to_str())
			var $money = ""
			if locale == EnUs {
				if currency == Usd {
					if a < 0 {
						$money = "($${$number})"
					} else {
						$money = "$${$number} "
					}
				} else {
					if a < 0 {
						$money = "(€${$number})"
					} else {
						$money = "€${$number} "
					}
				}
			} else {
				if currency == Usd {
					if a < 0 {
						$money = "$ -${$number} "
					} else {
						$money = "$ ${$number} "
					}
				} else {
					if a < 0 {
						$money = "€ -${$number} "
					} else {
						$money = "€ ${$number} "
					}
				}
			}
			var $width = 0.U64
			for b in $money.to_utf8() {
				if b < 128 or b >= 192 {
					$width = $width + 1
				}
			}
			while $width < 13 {
				$money = " ".concat($money)
				$width = $width + 1
			}
			$text = "${$text}\n${date} | ${$description} | ${$money}"
		}
		Ok($text)
	}
}
