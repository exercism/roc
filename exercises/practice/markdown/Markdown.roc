Markdown :: {}.{
	parse : Str -> Try(Str, _)
	parse = |markdown| {
		var $r = ""
		var $l = Bool.False
		for s in markdown.split_on("\n") {
			var $t = s
			var $h = 0.U64
			if s.starts_with("###### ") {
				$h = 6
				$t = s.drop_prefix("###### ")
			} else if s.starts_with("##### ") {
				$h = 5
				$t = s.drop_prefix("##### ")
			} else if s.starts_with("#### ") {
				$h = 4
				$t = s.drop_prefix("#### ")
			} else if s.starts_with("### ") {
				$h = 3
				$t = s.drop_prefix("### ")
			} else if s.starts_with("## ") {
				$h = 2
				$t = s.drop_prefix("## ")
			} else if s.starts_with("# ") {
				$h = 1
				$t = s.drop_prefix("# ")
			} else {
				if s.starts_with("* ") {
					$t = s.drop_prefix("* ")
				}
			}
			b = $t.to_utf8()
			var $i = 0.U64
			var $o = []
			while $i < b.len() {
				if (b.get($i) ?? 0) == '_' {
					var $n = 1.U64
					if (b.get($i + 1) ?? 0) == '_' {
						$n = 2
					}
					var $j = $i + $n
					while $j < b.len() and (b.get($j) ?? 0) != '_' {
						$j = $j + 1
					}
					if $j > $i + $n and $j < b.len() and ($n == 1 or (b.get($j + 1) ?? 0) == '_') {
						if $n == 2 {
							$o = $o.concat("<strong>".to_utf8())
						} else {
							$o = $o.concat("<em>".to_utf8())
						}
						$o = $o.concat(b.sublist({ start: $i + $n, len: $j - $i - $n }))
						if $n == 2 {
							$o = $o.concat("</strong>".to_utf8())
						} else {
							$o = $o.concat("</em>".to_utf8())
						}
						$i = $j + $n
					} else {
						$o = $o.append('_')
						$i = $i + 1
					}
				} else {
					$o = $o.append(b.get($i) ?? 0)
					$i = $i + 1
				}
			}
			t = Str.from_utf8($o)?
			if $h > 0 {
				if $l {
					$r = $r.concat("</ul>")
					$l = Bool.False
				}
				$r = "${$r}<h${$h.to_str()}>${t}</h${$h.to_str()}>"
			} else {
				if s.starts_with("* ") {
					if !$l {
						$r = $r.concat("<ul>")
						$l = Bool.True
					}
					$r = "${$r}<li>${t}</li>"
				} else {
					if $l {
						$r = $r.concat("</ul>")
						$l = Bool.False
					}
					$r = "${$r}<p>${t}</p>"
				}
			}
		}
		if $l {
			$r = $r.concat("</ul>")
		}
		Ok($r)
	}
}
