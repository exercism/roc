Prism := { id : U64, x : Dec, y : Dec, angle : Dec }.{
	Ray : { x : Dec, y : Dec, angle : Dec }

	find_sequence : { start : Ray, prisms : List(Prism) } -> List(U64)
	find_sequence = |{ start, prisms }| {
		help : { ray : Ray, sequence : List(U64) } -> List(U64)
		help = |{ ray, sequence }| {
			closest_prism_ahead = prisms
				.keep_if(
					|prism| {
						(prism.x != ray.x or prism.y != ray.y) and
							ray |> is_approx_heading_towards(prism)
					},
				)
				.sort_by(|prism| ray |> distance_squared(prism))
				.first()
			match closest_prism_ahead {
				Ok(prism) => {
					new_ray = { x: prism.x, y: prism.y, angle: ray |> angle_to(prism) |> add_angle(prism.angle) }
					new_sequence = sequence.append(prism.id)
					help({ ray: new_ray, sequence: new_sequence })
				}
				Err(ListWasEmpty) => sequence
			}
		}
		help({ ray: start, sequence: [] })
	}
}

angle_to : Ray, Prism -> Dec
angle_to = |ray, prism| {
	angle_radians = atan2({ x: prism.x - ray.x, y: prism.y - ray.y })
	angle_radians * 180 / Dec.pi # angle in degrees
}

distance_squared : Ray, Prism -> Dec
distance_squared = |prism1, prism2| {
	dx = prism1.x - prism2.x
	dy = prism1.y - prism2.y
	dx * dx + dy * dy
}

add_angle : Dec, Dec -> Dec
add_angle = |a, b| {
	sum = a + b
	if sum < -180 {
		sum + 2 * 180
	} else if sum >= 180 {
		sum - 2 * 180
	} else {
		sum
	}
}

is_approx_heading_towards : Ray, Prism -> Bool
is_approx_heading_towards = |ray, prism| {
	ray
		|> angle_to(prism)
		|> add_angle(-ray.angle)
		|> is_approx_eq(0, { atol: 1e-3 })
}

# The following functions should soon be available in Roc's builtins
is_approx_eq : Dec, Dec, { atol : Dec } -> Bool
is_approx_eq = |x, y, { atol }| {
	to_int : Dec -> Try(I64, [OutOfRange])
	to_int = |f| {
		(f / atol + 0.5).to_i64_try()
	}

	match (to_int(x), to_int(y)) {
		(Ok(xi), Ok(yi)) => (xi == yi)
		_ => Bool.False
	}
}

atan2 : { x : Dec, y : Dec } -> Dec
atan2 = |{ x, y }| {
	if x > 0 {
		(y / x).atan()
	} else if x < 0 {
		(y / x).atan() + if y > 0 {
			Dec.pi
		} else {
			-Dec.pi
		}
	} else if y > 0 {
		Dec.pi / 2
	} else if y < 0 {
		-Dec.pi / 2
	} else {
		0
	}
}
