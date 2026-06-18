def to_robot(robot):
    x = robot["position"]["x"]
    y = robot["position"]["y"]
    direction = robot["direction"]
    return f"{{x : {x}, y : {y}, direction : {direction.capitalize()}}}"
