import roc_utils

def prepare_jigsaw_data(jigsaw_data):
    format = jigsaw_data.get("format")
    if format is not None:
        jigsaw_data["format"] = roc_utils.RocTag(format)
    return jigsaw_data
