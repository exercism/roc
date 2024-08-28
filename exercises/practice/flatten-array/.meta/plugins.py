def to_nested(value, top_level=True):
    if value is None:
        return "Null"
    elif isinstance(value, int):
        return f"Value {value}"
    else:
        content = ", ".join([to_nested(elem, False) for elem in value])
        return f"NestedArray [\n{content}]"
