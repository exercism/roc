def to_roc_byte_list(byte_list):
    if not byte_list:
        return "[]"
    return "[" + ", ".join(byte_list) + "]"
