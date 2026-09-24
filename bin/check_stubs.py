#!/usr/bin/env python3
"""Compare Roc stub APIs with their configured example/exemplar solutions.

Run: python3 bin/check_stubs.py [exercise-glob ...]
Exits 0 on agreement, 1 on mismatches, and 2 on configuration/parse errors.

This is a lexical API checker, not a Roc type checker. It ignores whitespace,
comments, function bodies and example-only helpers. Parameter patterns are
compared literally (including destructuring and underscores). Type annotations
are compared literally except that `_` in a direct Try result's type arguments
may stand for a more specific type in the example; open tag unions may omit
additional example tags. Input types and `where` constraints must still match. Type declarations compare :: versus := (and :),
not their representations: opaque stubs intentionally omit internal fields.
"""

import argparse
from dataclasses import dataclass
import fnmatch
import json
from pathlib import Path
import re
import sys


TOKEN = re.compile(
    r'#[^\n]*|\\\\[^\n]*|"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\''
    r'|[A-Za-z_][A-Za-z_0-9!]*|::|:=|->|=>|\.\.|\|>|\?\?|\S',
    re.DOTALL,
)
OPEN = {"(": ")", "[": "]", "{": "}"}


@dataclass
class Token:
    text: str
    line: int


@dataclass
class Declaration:
    line: int
    kind: str
    signature: tuple = ()
    parameters: tuple | None = None
    defined: bool = False


def tokenize(source):
    result = []
    for match in TOKEN.finditer(source):
        text = match.group()
        if not text.startswith('#'):
            result.append(Token(text, source.count('\n', 0, match.start()) + 1))
    return result


def matching(tokens):
    stack, pairs = [], {}
    for i, token in enumerate(tokens):
        if token.text in OPEN:
            stack.append(i)
        elif token.text in OPEN.values():
            if not stack or OPEN[tokens[stack[-1]].text] != token.text:
                raise ValueError(f'line {token.line}: unbalanced delimiter')
            start = stack.pop()
            pairs[start] = i
    if stack:
        raise ValueError(f'line {tokens[stack[-1]].line}: unclosed delimiter')
    return pairs


def declarations(source):
    tokens = tokenize(source)
    pairs = matching(tokens)
    result = {}

    def scope(start, end, prefix):
        # Find declarations only at this scope's delimiter depth. Bodies and
        # parameter records are skipped, so local lambdas cannot shadow APIs.
        starts = []
        i = start
        while i < end:
            text = tokens[i].text
            first_on_line = i == start or tokens[i - 1].line < tokens[i].line
            if first_on_line and re.fullmatch(r'[A-Za-z_]\w*!?', text):
                op = i + 1
                if op < end and tokens[op].text == '(' and text[0].isupper():
                    op = pairs[op] + 1
                if op < end and tokens[op].text in (':', '::', ':=', '='):
                    starts.append((i, op))
            i = pairs[i] + 1 if i in pairs else i + 1
        for index, (begin, op) in enumerate(starts):
            stop = starts[index + 1][0] if index + 1 < len(starts) else end
            name = tokens[begin].text
            key = prefix + (name,)
            operator = tokens[op].text
            body = tokens[op + 1:stop]
            if name[0].isupper():
                if key in result:
                    raise ValueError(f'line {tokens[begin].line}: duplicate type {name}')
                result[key] = Declaration(tokens[begin].line, operator)
                i = op + 1
                while i < stop:
                    if tokens[i].text == '.' and i + 1 < stop and tokens[i + 1].text == '{':
                        scope(i + 2, pairs[i + 1], key)
                        break
                    i = pairs[i] + 1 if i in pairs else i + 1
            else:
                decl = result.setdefault(key, Declaration(tokens[begin].line, 'function'))
                if operator == ':':
                    if decl.signature:
                        raise ValueError(f'line {tokens[begin].line}: duplicate annotation {name}')
                    decl.signature = tuple(t.text for t in body)
                elif operator == '=':
                    if decl.defined:
                        raise ValueError(f'line {tokens[begin].line}: duplicate definition {name}')
                    decl.defined = True
                    if body and body[0].text == '|':
                        i = op + 2
                        while i < stop and tokens[i].text != '|':
                            i = pairs[i] + 1 if i in pairs else i + 1
                        if i == stop:
                            raise ValueError(f'line {tokens[begin].line}: unclosed lambda parameters')
                        decl.parameters = tuple(t.text for t in tokens[op + 2:i])

    scope(0, len(tokens), ())
    if not result:
        raise ValueError("no declarations found; expected formatted Roc source")
    return result


def tree(tokens):
    """Group delimiters so a wildcard matches one whole type, not a substring."""
    result, i = [], 0
    while i < len(tokens):
        token = tokens[i]
        if token in OPEN:
            depth, j = 1, i + 1
            while depth:
                if tokens[j] == token:
                    depth += 1
                elif tokens[j] == OPEN[token]:
                    depth -= 1
                j += 1
            result.append((token, tree(tokens[i + 1:j - 1])))
            i = j
        else:
            result.append(token)
            i += 1
    return tuple(result)


def split(items, separator):
    parts = [[]]
    for item in items:
        if item == separator:
            parts.append([])
        else:
            parts[-1].append(item)
    return [tuple(part) for part in parts]


def generalizes(stub, example):
    if stub == ('_',):
        return bool(example)
    if len(stub) != len(example):
        return False
    for left, right in zip(stub, example):
        if isinstance(left, tuple) and isinstance(right, tuple):
            if left[0] != right[0]:
                return False
            a, b = split(left[1], ','), split(right[1], ',')
            if left[0] == '[' and ('..',) in a:
                required = [tag for tag in a if tag != ('..',)]
                if not all(any(generalizes(tag, candidate) for candidate in b) for tag in required):
                    return False
            elif len(a) != len(b) or not all(generalizes(x, y) for x, y in zip(a, b)):
                return False
        elif left != right:
            return False
    return True


def normalized(tokens):
    return tuple(token for i, token in enumerate(tokens)
                 if not (token == "," and (i + 1 == len(tokens) or tokens[i + 1] in (")", "]", "}"))))


def signatures_match(stub, example):
    stub, example = normalized(stub), normalized(example)
    if stub == example:
        return True
    a, b = tree(stub), tree(example)
    arrows_a = [i for i, t in enumerate(a) if t in ('->', '=>')]
    arrows_b = [i for i, t in enumerate(b) if t in ('->', '=>')]
    if len(arrows_a) != len(arrows_b) or len(arrows_a) > 1:
        return False
    i = arrows_a[0] + 1 if arrows_a else 0
    j = arrows_b[0] + 1 if arrows_b else 0
    if a[:i] != b[:j]:
        return False
    a, b = a[i:], b[j:]
    # Only relax a direct Try return, retaining any following where clause.
    if len(a) < 2 or len(b) < 2 or a[0] != 'Try' or b[0] != 'Try':
        return False
    if not isinstance(a[1], tuple) or not isinstance(b[1], tuple):
        return False
    return a[2:] == b[2:] and generalizes(a[:2], b[:2])


def format_parameters(parameters):
    return "<no lambda>" if parameters is None else "| " + " ".join(parameters) + " |"


def compare(stub, example):
    errors = []
    for name, decl in stub.items():
        label = '.'.join(name)
        other = example.get(name)
        if other is None:
            errors.append((decl.line, f'{label}: missing from example'))
            continue
        if decl.kind != other.kind:
            errors.append((decl.line, f'{label}: type declaration {decl.kind} != {other.kind}'))
            continue
        if decl.kind != 'function':
            continue
        if not signatures_match(decl.signature, other.signature):
            errors.append((decl.line, f'{label}: type spec differs\n    stub: {" ".join(decl.signature) or "<missing>"}\n    example: {" ".join(other.signature) or "<missing>"}'))
        if (None if decl.parameters is None else normalized(decl.parameters)) != (
            None if other.parameters is None else normalized(other.parameters)
        ):
            errors.append((decl.line, f'{label}: parameters differ\n    stub: {format_parameters(decl.parameters)}\n    example: {format_parameters(other.parameters)}'))
        if decl.defined != other.defined:
            errors.append((decl.line, f'{label}: explicit/default implementation differs'))
    return errors


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('exercises', nargs='*', help='exercise slug globs (default: all)')
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1], help='track root')
    args = parser.parse_args()
    count = mismatches = failures = 0
    for config in sorted((args.root / 'exercises').glob('*/*/.meta/config.json')):
        folder = config.parent.parent
        if not any(fnmatch.fnmatchcase(folder.name, pattern) for pattern in args.exercises or ['*']):
            continue
        count += 1
        try:
            files = json.loads(config.read_text())['files']
            solutions = files['solution']
            examples = files.get('exemplar', files.get('example', []))
            if not solutions or len(solutions) != len(examples):
                raise ValueError('solution and example/exemplar file lists must be nonempty and have equal length')
            for solution, example in zip(solutions, examples):
                path = folder / solution
                errors = compare(declarations(path.read_text()), declarations((folder / example).read_text()))
                for line, message in errors:
                    print(f'{path.relative_to(args.root)}:{line}: {message}')
                mismatches += len(errors)
        except (OSError, ValueError, KeyError, IndexError) as error:
            print(f'{config}: {error}', file=sys.stderr)
            failures += 1
    if not count:
        parser.error('no matching exercises found')
    print(f'Checked {count} exercises: {mismatches} mismatches, {failures} errors.')
    return 2 if failures else 1 if mismatches else 0


if __name__ == '__main__':
    sys.exit(main())
