from roc_utils import RocTag

def to_alive_or_dead(cell):
    return RocTag("Alive") if cell == 1 else RocTag("Dead")

def to_matrix(matrix):
    return [
        [to_alive_or_dead(cell) for cell in row]
        for row in matrix
    ]
