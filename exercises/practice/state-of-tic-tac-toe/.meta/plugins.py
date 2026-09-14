roc_tags = {
    " ": "Empty",
    "X": "X",
    "O": "O",
}

def to_row(row):
    content = ", ".join([roc_tags[cell] for cell in row])
    return f"({content})"

def to_rows(board):
    content = ", ".join([to_row(row) for row in board])
    return f"({content})"
