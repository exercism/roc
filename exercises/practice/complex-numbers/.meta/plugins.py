float_map = {
    "e": "2.718281828459045.F64",
    "ln(2)": "0.6931471805599453.F64",
    "ln(2)/2": "0.6931471805599453.F64 / 2",
    "pi": "3.141592653589793.F64",
    "pi/4": "3.141592653589793.F64 / 4",
}


def to_roc(value):
    if isinstance(value, str):
        return float_map[value]
    else:
        return f"{value}"


def to_complex_number(value):
    if isinstance(value, list):
        assert len(value) == 2
        re = to_roc(value[0])
        im = to_roc(value[1])
    else:
        re = to_roc(value)
        im = 0
    return f"complex({re}, {im})"
