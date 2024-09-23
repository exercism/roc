def to_robot(robot, with_defaults):
    x = robot["position"]["x"]
    y = robot["position"]["y"]
    direction = robot["direction"]
    fields = []
    if x != 0 or not with_defaults:
        fields.append(f"x : {x}")
    if y != 0 or not with_defaults:
        fields.append(f"y : {y}")
    if direction != "north" or not with_defaults:
        fields.append(f"direction : {direction.capitalize()}")
    content = ", ".join(fields)
    return f"{{{content}}}"
