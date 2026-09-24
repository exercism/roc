def to_roc_tree(tree):
    if not tree:
        return "Empty"

    value = tree['v']
    fields = [f"value: '{value}'"]

    for child in ("left", "right"):
        subtree = tree.get(child[0])
        if subtree:
            fields.append(f"{child}: {to_roc_tree(subtree)}")

    return "Node({" + ", ".join(fields) + " })"

def to_roc_char_list(char_list):
    if not char_list:
        return "[]"
    return "['" + "', '".join(char_list) + "']"
