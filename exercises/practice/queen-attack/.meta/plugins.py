def to_square(queen):
    rank = to_rank(queen["position"]["row"])
    file = to_file(queen["position"]["column"])
    return f"{file}{rank}"


def to_rank(row):
    return 8 - row


def to_file(column):
    return chr(column + ord("A"))
