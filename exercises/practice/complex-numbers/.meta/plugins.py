float_map = {
    "e": "Num.e",
    "ln(2)": "Num.log(2f64)",
    "ln(2)/2": "Num.log(2f64) / 2",
    "pi": "Num.pi",
    "pi/4": "Num.pi / 4",
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
    return f"{{ re: {re}, im: {im} }}"
