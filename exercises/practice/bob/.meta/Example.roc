Bob :: {}.{
	response : Str -> Str
	response = |hey_bob| {
		trimmed = hey_bob.trim()
		if trimmed == "" {
			"Fine. Be that way!"
		} else {
			is_q = is_question(trimmed)
			is_y = is_yelling(trimmed)
			if is_q and is_y {
				"Calm down, I know what I'm doing!"
			} else if is_q {
				"Sure."
			} else if is_y {
				"Whoa, chill out!"
			} else {
				"Whatever."
			}
		}
	}
}

is_question = |hey_bob| {
	hey_bob.ends_with("?")
}

is_yelling = |hey_bob| {
	is_lower = |c| {
		c >= 'a' and c <= 'z'
	}
	is_upper = |c| {
		c >= 'A' and c <= 'Z'
	}
	chars = hey_bob.to_utf8()
	(chars.any(is_upper)) and !(chars.any(is_lower))
}
