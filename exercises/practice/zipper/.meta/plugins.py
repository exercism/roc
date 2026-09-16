import roc_utils


NAVIGATION_OPERATIONS = {"left", "right", "up"}
TREE_OPERATIONS = {"set_left", "set_right"}


def to_roc_tree(tree):
    fields = [f"value: {roc_utils.to_roc(tree['value'])}"]

    for child in ("left", "right"):
        if tree.get(child) is not None:
            fields.append(f"{child}: {to_roc_tree(tree[child])}")

    return "{ " + ", ".join(fields) + " }"


def operation_chain(operations, propagate_final_error=True):
    calls = []
    final_index = len(operations) - 1

    for index, operation in enumerate(operations):
        name = operation["operation"]

        if name in NAVIGATION_OPERATIONS:
            propagate = propagate_final_error or index != final_index
            calls.append(f".{name}(){'?' if propagate else ''}")
        elif name == "set_value":
            calls.append(f".set_value({roc_utils.to_roc(operation['item'])})")
        elif name in TREE_OPERATIONS:
            if operation["item"] is None:
                calls.append(f".remove_{name[4:]}()")
            else:
                calls.append(f".{name}({to_roc_tree(operation['item'])})")
        elif name in {"to_tree", "value", "remove_left", "remove_right"}:
            calls.append(f".{name}()")
        else:
            raise ValueError(f"Unsupported zipper operation: {name}")

    return "".join(calls)


def is_error_expected(expected):
    return expected.get("type") == "zipper" and expected.get("value") is None


def description(case):
    for operation in case["input"].get("operations", []):
        if (
            operation["operation"] in TREE_OPERATIONS
            and operation.get("item") is None
        ):
            return f"remove {operation['operation'][4:]} child"

    return case["description"]
