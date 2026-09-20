def to_roc_tree(tree):
    result = {"id": tree.get('id', tree.get('recordId'))}
    children = tree.get('children', [])
    if children:
        result["children"] = [to_roc_tree(child) for child in children]
    return result

def to_roc_records(records):
    return [
        {"id": record["recordId"], "parent_id": record["parentId"]}
        for record in records
    ]

