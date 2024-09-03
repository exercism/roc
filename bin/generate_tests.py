#!/usr/bin/env python3
"""
Generates exercise test suites using an exercise's canonical-data.json
(found in problem-specifications) and $exercise/.meta/template.j2.
If either does not exist, generation will not be attempted.

Usage:
    generate_tests.py           Generates tests for all exercises
    generate_tests.py two-fer   Generates tests for two-fer exercise
    generate_tests.py t*        Generates tests for all exercises matching t*

    generate_tests.py --check           Checks if test files are out of sync with templates
    generate_tests.py --check two-fer   Checks if two-fer test file is out of sync with template
"""

# Credit: this code was copied from the Python track and adapted for Roc.

import sys

_py = sys.version_info
if _py.major < 3 or (_py.major == 3 and _py.minor < 7):
    print("Python version must be at least 3.7")
    sys.exit(1)

# flake8: noqa: E402 # ignore the fact that these imports are not at the top
import argparse
from datetime import datetime
from datetime import timezone
import difflib
import filecmp
import importlib.util
import json
import logging
from pathlib import Path, PureWindowsPath
import re
import shutil
from itertools import repeat
from string import punctuation, whitespace
import subprocess
from tempfile import NamedTemporaryFile
from textwrap import wrap
from typing import Any, Dict, List, NoReturn, Union

# Tomli was subsumed into Python 3.11.x, but was renamed to to tomllib.
# This avoids ci failures for Python < 3.11.2.
try:
    import tomllib
except ModuleNotFoundError:
    import tomli as tomllib

from jinja2 import Environment, FileSystemLoader, TemplateNotFound, UndefinedError
from dateutil.parser import parse

from data import TestsTOML

VERSION = "0.3.0"
GENERATED_ON_PREFIX = "# File last updated on "


TypeJSON = Dict[str, Any]

PROBLEM_SPEC_REPO = "https://github.com/exercism/problem-specifications.git"
DEFAULT_SPEC_LOCATION = Path(".problem-specifications")
RGX_WORDS = re.compile(r"[-_\s]|(?=[A-Z])")

logging.basicConfig()
logger = logging.getLogger("generator")
logger.setLevel(logging.WARN)


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
        return "\n".join(
            ["", '"""'] + [escape_roc_string_content(line) for line in lines] + ['"""']
        ).replace("$(", "\\$(")


def to_roc_tuple(values: Any):
    list_content = ", ".join([to_roc(v) for v in tuple(values)])
    return f"({list_content})"


def to_roc_bool(value: bool):
    return "Bool.true" if value else "Bool.false"


def to_roc_list(values: Any):
    list_content = ", ".join([to_roc(v) for v in list(values)])
    return f"[{list_content}]"


def to_roc_float(value: Union[int, float]):
    value = float(value)
    return f"{value!r}f64".replace("+", "")


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


def filter_test_cases(cases: List[TypeJSON], opts: TestsTOML) -> List[TypeJSON]:
    """
    Returns a filtered copy of `cases` where only cases whose UUID is marked True in
    `opts` are included.
    """
    filtered = []
    for case in cases:
        if "uuid" in case:
            uuid = case["uuid"]
            case_opts = opts.cases.get(uuid, None)
            if case_opts is not None and case_opts.include:
                filtered.append(case)
            else:
                logger.debug(f"uuid {uuid} either missing or not marked for include")
        elif "cases" in case:
            subfiltered = filter_test_cases(case["cases"], opts)
            if subfiltered:
                case_copy = dict(case)
                case_copy["cases"] = subfiltered
                filtered.append(case_copy)
    return filtered


def load_canonical(exercise: str, spec_path: Path, test_opts: TestsTOML) -> TypeJSON:
    """
    Loads the canonical data for an exercise as a nested dictionary
    """
    full_path = spec_path / "exercises" / exercise / "canonical-data.json"
    with full_path.open() as f:
        spec = json.load(f)
    spec["cases"] = filter_test_cases(spec["cases"], test_opts)
    spec["properties"] = get_tested_properties(spec)
    return spec


def load_additional_tests(exercise: Path) -> List[TypeJSON]:
    """
    Loads additional tests from .meta/additional_tests.json
    """
    full_path = exercise / ".meta/additional_tests.json"
    try:
        with full_path.open() as f:
            data = json.load(f)
        return data.get("cases", [])
    except FileNotFoundError:
        return []


def format_file(path: Path) -> NoReturn:
    """
    Runs roc format on file at path
    """
    subprocess.check_call(["roc", "format", path])


def drop_timestamp(lines):
    def drop(line):
        try:
            index = line.index(GENERATED_ON_PREFIX)
            return line[:index].rstrip()
        except ValueError:
            return line

    return [drop(line) for line in lines]


def check_template(slug: str, tests_path: Path, tmpfile: Path):
    """Generate a new test file and diff against existing file."""

    try:
        check_ok = True
        if not tmpfile.is_file():
            logger.debug(f"{slug}: tmp file {tmpfile} not found")
            check_ok = False
        if not tests_path.is_file():
            logger.debug(f"{slug}: tests file {tests_path} not found")
            check_ok = False
        if check_ok and not filecmp.cmp(tmpfile, tests_path):
            with tests_path.open() as f:
                current_lines = drop_timestamp(f.readlines())
            with tmpfile.open() as f:
                rendered_lines = drop_timestamp(f.readlines())

            diff = list(
                difflib.unified_diff(
                    current_lines,
                    rendered_lines,
                    fromfile=f"[current] {tests_path.name}",
                    tofile=f"[generated] {tmpfile.name}",
                    lineterm="\n",
                )
            )
            if not diff:
                check_ok = True
            else:
                logger.debug(f"{slug}: ##### DIFF START #####")
                for line in diff:
                    logger.debug(line.strip())
                logger.debug(f"{slug}: ##### DIFF END #####")
                check_ok = False
        if not check_ok:
            logger.error(
                f"{slug}: check failed; tests must be regenerated with bin/generate_tests.py"
            )
            return False
        logger.debug(f"{slug}: check passed")
    finally:
        logger.debug(f"{slug}: removing tmp file {tmpfile}")
        tmpfile.unlink()
    return True


def generate_exercise(
    env: Environment, spec_path: Path, exercise: Path, check: bool = False
):
    """
    Renders test suite for exercise and if check is:
    True: verifies that current tests file matches rendered
    False: saves rendered to tests file
    """
    slug = exercise.name
    meta_dir = exercise / ".meta"
    plugins_module = None
    plugins_name = "plugins"
    plugins_source = meta_dir / f"{plugins_name}.py"
    try:
        if plugins_source.is_file():
            plugins_spec = importlib.util.spec_from_file_location(
                plugins_name, plugins_source
            )
            plugins_module = importlib.util.module_from_spec(plugins_spec)
            sys.modules[plugins_name] = plugins_module
            plugins_spec.loader.exec_module(plugins_module)
        try:
            test_opts = TestsTOML.load(meta_dir / "tests.toml")
        except FileNotFoundError:
            logger.error(f"{slug}: tests.toml not found; skipping.")
            return True

        spec = load_canonical(slug, spec_path, test_opts)
        additional_tests = load_additional_tests(exercise)
        spec["additional_cases"] = additional_tests
        template_path = exercise.relative_to("exercises") / ".meta/template.j2"

        # See https://github.com/pallets/jinja/issues/767 for why this is needed on Windows systems.
        if "\\" in str(template_path):
            template_path = PureWindowsPath(template_path).as_posix()

        template = env.get_template(str(template_path))
        tests_path = exercise / f"{to_kebab(slug)}-test.roc"
        spec["has_error_case"] = has_error_case(spec["cases"])

        if plugins_module is not None:
            spec[plugins_name] = plugins_module
        logger.debug(f"{slug}: attempting render")
        rendered = template.render(**spec)
        with NamedTemporaryFile("w", suffix=".roc", delete=False) as tmp:
            logger.debug(f"{slug}: writing render to tmp file {tmp.name}")
            tmpfile = Path(tmp.name)
            tmp.write(rendered)
        try:
            logger.debug(f"{slug}: formatting tmp file {tmpfile}")
            format_file(tmpfile)
        except subprocess.CalledProcessError as e:
            return False

        if check:
            return check_template(slug, tests_path, tmpfile)
        else:
            logger.debug(f"{slug}: moving tmp file {tmpfile}->{tests_path}")
            shutil.move(tmpfile, tests_path)
            print(f"{slug} generated at {tests_path}")
    except (TypeError, UndefinedError, SyntaxError) as e:
        logger.debug(str(e))
        logger.error(f"{slug}: generation failed")
        return False
    except TemplateNotFound as e:
        logger.debug(str(e))
        logger.info(f"{slug}: no template found; skipping")
    except FileNotFoundError as e:
        logger.debug(str(e))
        logger.info(f"{slug}: no canonical data found; skipping")
    return True


def clone_or_update_specs(dir_path, specs_url=PROBLEM_SPEC_REPO):
    if dir_path.is_dir():
        try:
            subprocess.run(
                ["git", "pull"],
                cwd=dir_path,
                check=True,
                stdout=subprocess.DEVNULL,
            )
        except subprocess.CalledProcessError:
            logger.warning("Failed to update the problem-specifications", exc_info=True)
        return True
    else:
        try:
            subprocess.run(["git", "clone", specs_url, str(dir_path)], check=True)
            return True
        except subprocess.CalledProcessError:
            logger.error("Failed to clone problem-specifications", exc_info=True)
    return False


def generate(
    exercise_glob: str,
    spec_path: Path = DEFAULT_SPEC_LOCATION,
    stop_on_failure: bool = False,
    check: bool = False,
    **_,
):
    """
    Primary entry point. Generates test files for all exercises matching exercise_glob
    """
    loader = FileSystemLoader(["config", "exercises"])
    env = Environment(loader=loader, keep_trailing_newline=True)
    env.filters["to_snake"] = to_snake
    env.filters["to_pascal"] = to_pascal
    env.filters["to_camel"] = to_camel
    env.filters["to_roc"] = to_roc
    env.filters["to_roc_string"] = to_roc_string
    env.filters["to_roc_multiline_string"] = to_roc_multiline_string
    env.filters["to_roc_float"] = to_roc_float
    env.filters["to_roc_bool"] = to_roc_bool
    env.filters["to_roc_list"] = to_roc_list
    env.filters["to_roc_tuple"] = to_roc_tuple
    env.filters["wrap_overlong"] = wrap_overlong
    env.filters["regex_replace"] = regex_replace
    env.filters["regex_find"] = regex_find
    env.filters["regex_split"] = regex_split
    env.filters["zip"] = zip
    env.filters["parse_datetime"] = parse_datetime
    env.filters["escape_invalid_escapes"] = escape_invalid_escapes
    env.globals["current_date"] = datetime.now(tz=timezone.utc).date()
    env.tests["error_case"] = error_case
    result = True
    for exercise in sorted(Path("exercises/practice").glob(exercise_glob)):
        if not generate_exercise(env, spec_path, exercise, check):
            result = False
            if stop_on_failure:
                break
    if not result:
        sys.exit(1)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("exercise_glob", nargs="?", default="*", metavar="EXERCISE")
    parser.add_argument(
        "--version",
        action="version",
        version="%(prog)s {} for Python {}".format(VERSION, sys.version.split("\n")[0]),
    )
    parser.add_argument("-v", "--verbose", action="store_true")
    parser.add_argument(
        "-p",
        "--spec-path",
        default=DEFAULT_SPEC_LOCATION,
        type=Path,
        help=(
            "path to clone of exercism/problem-specifications " "(default: %(default)s)"
        ),
    )
    parser.add_argument("--stop-on-failure", action="store_true")
    parser.add_argument(
        "--check",
        action="store_true",
        help="check if tests are up-to-date, but do not modify test files",
    )
    opts = parser.parse_args()
    if opts.verbose:
        logger.setLevel(logging.DEBUG)

    clone_or_update_specs(opts.spec_path)
    sys.exit(generate(**opts.__dict__))
