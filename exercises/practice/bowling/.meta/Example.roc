Bowling :: { frames : List(Frame) }.{
	new : Bowling
	new = { frames: [] }

	roll : Bowling, U64 -> Try(Bowling, [MoreThan10Pins, GameOver])
	roll = |game, pins| {
		if game.is_over() {
			Err(GameOver)
		} else {
			{ frames } = game
			last_frame = frames.last() ?? Ball2(0, 0)
			check_max_10_pins(last_frame, pins)?
			updated_frames = {
				match last_frame {
					Ball1(pins1) => {
						frames
							.drop_last(
								1,
							)
							.append(
								if pins1 + pins == 10 {
									Spare(pins1, pins)
								} else {
									Ball2(pins1, pins)
								},
							)
					}

					StrikeFill1(pins1) => {
						frames.drop_last(1).append(StrikeFill2(pins1, pins))
					}

					Ball2(_, _) | Spare(_, _) | Strike if frames.len() < 10 => {
						if pins == 10 {
							frames.append(Strike)
						} else {
							frames.append(Ball1(pins))
						}
					}

					Spare(_, _) => {
						frames.append(SpareFill(pins))
					}

					Strike => {
						frames.append(StrikeFill1(pins))
					}

					Ball2(_, _) | SpareFill(_) | StrikeFill2(_, _) => {
						crash "Impossible, an unfinished game cannot have these in the last frame after the 10th frame"
					}
				}
			}
			Ok({ frames: updated_frames })
		}
	}

	score : Bowling -> Try(U64, [GameIsNotOver])
	score = |game| {
		if game.is_over() {
			{ frames } = game
			points = {
				frames->map_triplets(
					|frame1, frame2, frame3| {
						match frame1 {
							Ball2(pins1, pins2) => {
								pins1 + pins2
							}
							Spare(pins1, pins2) => {
								pins1 + pins2 + first_pins(frame2)
							}
							Strike => {
								match frame2 {
									Strike => {
										10 + 10 + first_pins(frame3)
									}
									_ => {
										10 + total_pins(frame2)
									}
								}
							}
							SpareFill(_) => 0 # already counted in the Spare
							StrikeFill2(_, _) => 0 # already counter in the Strike
							Ball1(_) | StrikeFill1(_) => {
								crash "Impossible, unfinished frames should not exist in a finished game"
							}
						}
					},
				)
			}
			Ok(points.sum())
		}
			else {
				Err(GameIsNotOver)
			}
	}

	is_over : Bowling -> Bool
	is_over = |game| {
		{ frames } = game
		match frames {
			_ if frames.len() < 10 => Bool.False
			[.., Ball1(_)] | [.., Spare(_, _)] | [.., Strike] | [.., StrikeFill1(_)] => Bool.False
			[.., Ball2(_, _)] | [.., SpareFill(_)] | [.., StrikeFill2(_, _)] => Bool.True
			_ => Bool.False
		}
	}

}

Frame := [
	Ball1(U64), # unfinished frame
	Ball2(U64, U64),
	Spare(U64, U64),
	Strike,
	SpareFill(U64),
	StrikeFill1(U64), # unfinished frame
	StrikeFill2(U64, U64),
]

check_max_10_pins : Frame, U64 -> Try({}, [MoreThan10Pins, GameOver])
check_max_10_pins = |last_frame, pins| {
	match last_frame {
		Ball1(pins1) => if pins1 + pins > 10 {
			Err(MoreThan10Pins)
		} else {
			Ok({})
		}
		StrikeFill1(pins1) => {
			if pins > 10 or (pins1 < 10 and pins1 + pins > 10) {
				Err(MoreThan10Pins)
			} else {
				Ok({})
			}
		}
		Ball2(_, _) | Spare(_, _) | Strike => if pins > 10 {
			Err(MoreThan10Pins)
		} else {
			Ok({})
		}
		SpareFill(_) | StrikeFill2(_, _) => Err(GameOver)
	}
}

map_triplets : List(Frame), (Frame, Frame, Frame -> U64) -> List(U64)
map_triplets = |list, score_func| {
	get_or_0 = |index| {
		list.get(index) ?? Ball2(0, 0)
	}
	0.to(list.len()).map(
		|index| {
			score_func(get_or_0(index), get_or_0((index + 1)), get_or_0((index + 2)))
		},
	)->List.from_iter()
}

first_pins : Frame -> U64
first_pins = |frame| {
	match frame {
		Ball1(pins) | Ball2(pins, _) | Spare(pins, _) | SpareFill(pins) | StrikeFill1(pins) | StrikeFill2(pins, _) => pins
		Strike => 10
	}
}

total_pins : Frame -> U64
total_pins = |frame| {
	match frame {
		Ball2(pins1, pins2) | Spare(pins1, pins2) | StrikeFill2(pins1, pins2) => pins1 + pins2
		Ball1(pins) | SpareFill(pins) | StrikeFill1(pins) => pins
		Strike => 10
	}
}

# The following function should soon be available in Roc's builtins
fold_try : List(a), b, (b, a -> Try(b, err)) -> Try(b, err)
fold_try = |list, init, func| {
	list.fold_until(
		Ok(init),
		|state, item| {
			match state {
				Ok(internal_state) => {
					match func(internal_state, item) {
						Ok(new_state) => Continue(Ok(new_state))
						Err(final_err) => Break(Err(final_err))
					}
				}
				Err(_) => {
					crash "Unreachable"
				}
			}
		},
	)
}
