import re
from datetime import datetime
from itertools import repeat
from string import punctuation, whitespace
from textwrap import wrap
from typing import Any, Dict, List, Union

from dateutil.parser import parse

TypeJSON = Dict[str, Any]

def replace_all(string: str, chars: Union[str, List[str]], rep: str) -> str:
    """
    Replace any char in chars with rep, reduce runs and strip terminal ends.
    """
    trans = str.maketrans(dict(zip(chars, repeat(rep))))
    return re.sub("{0}+".format(re.escape(rep)), rep, string.translate(trans)).strip(
        rep
    )


def to_snake(string: str, wordchars_only: bool = False) -> str:
    """
    Convert pretty much anything to snake_case.

    By default whitespace and punctuation will be converted
    to underscores as well, pass wordchars_only=True to preserve these as is.
    """
    clean = re.sub("(.)([A-Z][a-z]+)", r"\1_\2", string)
    clean = re.sub("([a-z0-9])([A-Z])", r"\1_\2", clean).lower()
    return (
        clean if wordchars_only else replace_all(clean, whitespace + punctuation, "_")
    )


def to_kebab(string: str, wordchars_only: bool = False) -> str:
    """
    Convert pretty much anything to kebab-case.

    By default whitespace and punctuation will be converted
    to dashes as well, pass wordchars_only=True to preserve these as is.
    """
    return to_snake(string, wordchars_only).replace("_", "-")


def to_pascal(string: str) -> str:
    """
    Convert pretty much anything to PascalCase.
    """
    return "".join(w.title() for w in to_snake(string).split("_"))


def to_camel(string: str) -> str:
    """
    Convert pretty much anything to CamelCase.
    """
    pascal = to_pascal(string)
    return pascal[0].lower() + pascal[1:]


ESCAPE_ROC_STRING = re.compile(r'[\x00-\x1f\\"\b\f\n\r\t]')
ESCAPE_MAP = {
    "\\": "\\\\",
    '"': '\\"',
    "\b": "\\b",
    "\f": "\\f",
    "\n": "\\n",
    "\r": "\\r",
    "\t": "\\t",
}
for i in range(0x20):
    ESCAPE_MAP.setdefault(chr(i), f"\\u({i:04x})")
del i


def escape_roc_string_content(string: str):
    """
    Return a Roc representation of a Python string without the surrounding quotes
    """
    return ESCAPE_ROC_STRING.sub(lambda match: ESCAPE_MAP[match.group(0)], string)


def to_roc_string(string: str) -> str:
    """
    Return a Roc representation of a Python string
    """
    return ('"' + escape_roc_string_content(string) + '"').replace("$(", "\\$(")


def to_roc_multiline_string(lines: Union[str, List[str]]) -> str:
    """
    Return a multiline Roc representation of a Python multiline string or list
    of lines
    """
    if isinstance(lines, str):
        lines = lines.split("\n")
    if len(lines) == 0:
        return '""'
    elif len(lines) == 1:
        return to_roc_string(lines[0])
    else:
        return "\n" + "\n".join(
            [r'\\' + escape_roc_string_content(line) for line in lines]
        ).replace("${", r"\${") + "\n"


def to_roc_tuple(values: Any):
    list_content = ", ".join([to_roc(v) for v in tuple(values)])
    return f"({list_content})"


def to_roc_record(obj: Dict[str, Any]):
    items = []
    for key, value in obj.items():
        snake_key = to_snake(key)
        roc_value = to_roc(value)
        items.append(f"{snake_key}: {roc_value}")

    return "{ " + ", ".join(items) + " }"


def to_roc_bool(value: bool):
    return "Bool.True" if value else "Bool.False"


def to_roc_list(values: Any):
    list_content = ", ".join([to_roc(v) for v in list(values)])
    return f"[{list_content}]"

def to_roc_dict(values: Dict):
    if values is None or values == {}:
        return "Dict.empty()"
    elif len(values) == 1:
        k, v = next(iter(values.items()))
        return f"Dict.single({to_roc(k)}, {to_roc(v)})"
    else:
        items = ",\n".join([f"({to_roc(k)}, {to_roc(v)})" for k, v in values.items()])
        return f"Dict.from_list([\n{items},\n])"


class RocDict:
    def __init__(self, dictionary={}):
        self.dictionary = dictionary

    def __repr__(self):
        return to_roc_dict(self.dictionary)


def to_roc_tag_name(name: str) -> str:
    """
    Convert a string to a valid Roc tag name.
    """
    return to_pascal(name).replace("-", "").replace("_", "")


class RocTag:
    def __init__(self, name, args=()):
        self.name = to_roc_tag_name(name)
        self.args = args

    def __repr__(self):
        if self.args:
            args = ", ".join([to_roc(arg) for arg in self.args])
            return f"{self.name}({args})"
        else:
            return self.name


def to_roc_tag(value: Union[RocTag, str]):
    if isinstance(value, str):
        return to_roc_tag_name(value)
    else:
        return repr(value)


def to_roc_float(value: Union[int, float]):
    value = float(value)
    return f"{value!r}.F64".replace("+", "")


def to_roc(value: Any) -> str:
    if isinstance(value, str):
        return to_roc_string(value)
    elif isinstance(value, float):
        return to_roc_float(value)
    elif isinstance(value, bool):
        return to_roc_bool(value)
    elif isinstance(value, list):
        return to_roc_list(value)
    elif isinstance(value, tuple):
        return to_roc_tuple(value)
    elif isinstance(value, RocTag):
        return repr(value)
    elif isinstance(value, RocDict):
        return repr(value)
    elif isinstance(value, dict):
        return to_roc_record(value)
    elif value is None:
        return "{}"
    else:
        return repr(value)


def wrap_overlong(string: str, width: int = 70) -> List[str]:
    """
    Break an overly long string literal into escaped lines.
    """
    return ["{0!r} \\".format(w) for w in wrap(string, width)]


def parse_datetime(string: str, strip_module: bool = False) -> datetime:
    """
    Parse a (hopefully ISO 8601) datestamp to a datetime object and
    return its repr for use in a jinja2 template.

    If used the template will need to import the datetime module.

        import datetime

    However if strip_module is True then the template will need to
    import the datetime _class_ instead.

        from datetime import datetime
    """
    result = repr(parse(string))
    if strip_module:
        return result.replace("datetime.", "", 1)
    return result


INVALID_ESCAPE_RE = re.compile(
    r"""
    \\(?!                           # a backslash NOT followed by
        newline                     # the literal newline
    |[                              # OR precisely one of
        \\                          # another backslash
        '                           # the single quote
        "                           # the double quote
        a                           # the ASCII bell
        b                           # the ASCII backspace
        f                           # the ASCII formfeed
        n                           # the ASCII linefeed
        r                           # the ASCII carriage return
        t                           # the ASCII horizontal tab
        v                           # the ASCII vertical tab
    ]|                              # OR
        o(?:[0-8]{1,3})             # an octal value
    |                               # OR
        x(?:[0-9A-Fa-f]{2})         # a hexadecimal value
    |                               # OR
        N                           # a unicode char name composed of
        \{                          # an opening brace
            [A-Z][A-Z\ \-]*[A-Z]    # uppercase WORD, WORDs (or WORD-WORDs)
        \}                          # and a closing brace
    |                               # OR
        u(?:[0-9A-Fa-f]{4})         # a 16-bit unicode char
    |                               # OR
        U(?:[0-9A-Fa-f]{8})         # a 32-bit unicode char
    )""",
    flags=re.VERBOSE,
)


def escape_invalid_escapes(string: str) -> str:
    """
    Some canonical data includes invalid escape sequences, which
    need to be properly escaped before template render.
    """
    return INVALID_ESCAPE_RE.sub(r"\\\\", string)


ALL_VALID = (
    r"\newline\\\'\"\a\b\f\n\r\t\v\o123" r"\xFF\N{GREATER-THAN SIGN}\u0394\U00000394"
)

assert ALL_VALID == escape_invalid_escapes(ALL_VALID)


def get_tested_properties(spec: TypeJSON) -> List[str]:
    """
    Get set of tested properties from spec. Include nested cases.
    """
    props = set()
    for case in spec["cases"]:
        if "property" in case:
            props.add(case["property"])
        if "cases" in case:
            props.update(get_tested_properties(case))
    return sorted(props)


def error_case(case: TypeJSON) -> bool:
    return (
        "expected" in case
        and isinstance(case["expected"], dict)
        and "error" in case["expected"]
    )


def has_error_case(cases: List[TypeJSON]) -> bool:
    cases = cases[:]
    while cases:
        case = cases.pop(0)
        if error_case(case):
            return True
        cases.extend(case.get("cases", []))
    return False


def regex_replace(s: str, find: str, repl: str) -> str:
    return re.sub(find, repl, s)


def regex_find(s: str, find: str) -> List[Any]:
    return re.findall(find, s)


def regex_split(s: str, find: str) -> List[str]:
    return re.split(find, s)

