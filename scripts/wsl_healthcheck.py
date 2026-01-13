#!/usr/bin/env python3
"""Simple WSL healthcheck for common tools."""

from __future__ import annotations

import shutil
import sys


def which(cmd: str) -> bool:
    return shutil.which(cmd) is not None


def main() -> int:
    checks: list[tuple[str, bool]] = []

    checks.append(("git", which("git")))
    checks.append(("python3", which("python3")))
    checks.append(("pipx", which("pipx")))
    checks.append(("rg", which("rg")))

    fd_found = which("fdfind") or which("fd")
    checks.append(("fdfind/fd", fd_found))

    checks.append(("fzf", which("fzf")))
    checks.append(("tree", which("tree")))
    checks.append(("jq", which("jq")))
    checks.append(("ansible", which("ansible")))

    failed = 0
    for name, ok in checks:
        status = "PASS" if ok else "FAIL"
        print(f"{status}: {name}")
        if not ok:
            failed += 1

    if failed:
        print(f"\nFAILED: {failed} check(s)")
        return 1

    print("\nALL CHECKS PASSED")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
