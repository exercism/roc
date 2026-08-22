import roc_utils
import re

def description_to_def(description):
    return re.sub(r"[\W_]+", "_", description.strip().lower())


def prepare_value(value):
    if isinstance(value, bool):
        return roc_utils.RocTag("True" if value else "False")
    elif isinstance(value, int):
        return roc_utils.RocTag("Int", (value,))
    else:
        return roc_utils.RocTag("Text", (value,))


def prepare_key(key):
    node1, node2 = key.split()  # key looks like "{a b}"
    return tuple(sorted([node1[1:], node2[:-1]]))


def expected_graph(expected):
    attributes = expected.get("attrs", {})
    title = attributes.pop("title", None)
    color = attributes.pop("color", None)
    nodes = expected.get("nodes", {})
    edges = expected.get("edges", {})
    result = {}
    result["nodes"] = roc_utils.RocDict({
        k: attributes_record(v) for k, v in nodes.items()
    })
    result["edges"] = roc_utils.RocDict({
        prepare_key(k): attributes_record(v) for k, v in edges.items()
    })
    if title is not None:
        result["title"] = title
    if color is not None:
        result["color"] = roc_utils.RocTag(color)
    result["custom_attributes"] = custom_attributes(attributes)
    return result

def attributes_record(attrs):
    label = attrs.pop("label", None)
    style = attrs.pop("style", None)
    color = attrs.pop("color", None)
    result = {}
    result["custom_attributes"] = custom_attributes(attrs)
    if label is not None:
        result["label"] = label
    if style is not None:
        result["style"] = roc_utils.RocTag(style)
    if color is not None:
        result["color"] = roc_utils.RocTag(color)
    return result

def custom_attributes(attributes):
    return roc_utils.RocDict({k: prepare_value(v) for k, v in attributes.items()})
