#!/usr/bin/env python3
"""Sort practice exercises in the root config.json by difficulty, then slug."""

import argparse
import json
from pathlib import Path
import sys


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--check", action="store_true", help="check ordering without changing files"
    )
    args = parser.parse_args()
    config_path = Path(__file__).resolve().parent.parent / "config.json"

    try:
        config = json.loads(config_path.read_text(encoding="utf-8"))
        exercises = config["exercises"]["practice"]
        ordered = sorted(exercises, key=lambda exercise: (
            exercise["difficulty"], exercise["slug"]
        ))
        if exercises == ordered:
            return 0
        if args.check:
            print(
                "Practice exercises are not sorted by difficulty, then slug. "
                "Run: bin/sort_exercises.py",
                file=sys.stderr,
            )
            return 1
        config["exercises"]["practice"] = ordered
        config_path.write_text(
            json.dumps(config, indent=2, ensure_ascii=False) + "\n", encoding="utf-8"
        )
    except (OSError, ValueError, KeyError, TypeError) as error:
        print(f"Cannot sort {config_path}: {error}", file=sys.stderr)
        return 2

    print("Sorted practice exercises by difficulty, then slug.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
