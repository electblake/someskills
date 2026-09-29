#!/usr/bin/env python3
"""Strict Python project setup for the setup-python skill."""

from __future__ import annotations

import argparse
import os
import re
import shutil
import subprocess
from pathlib import Path


PYTHON_VERSION = "3.12.9"
DEFAULT_MISE_TOOLS = ("powershell@latest", "uv")
MANIFEST = ("mise.toml", ".venv", "pyproject.toml")


def normalize_project_name(folder_name: str) -> str:
    name = re.sub(r"[^A-Za-z0-9]+", "-", folder_name.strip().lower()).strip("-")
    return name or "python-project"


def resolve_target(path_text: str) -> Path:
    target = Path(path_text).expanduser().resolve()
    if not target.exists() or not target.is_dir():
        raise SystemExit(f"Target folder does not exist or is not a directory: {target}")
    return target


def manifest_paths(target: Path) -> dict[str, Path]:
    paths: dict[str, Path] = {}
    for rel in MANIFEST:
        candidate = (target / rel).resolve(strict=False)
        try:
            candidate.relative_to(target)
        except ValueError as exc:
            raise SystemExit(f"Manifest path escapes target folder: {rel}") from exc
        paths[rel] = candidate
    return paths


def require_tools() -> None:
    missing = [tool for tool in ("mise",) if shutil.which(tool) is None]
    if missing:
        raise SystemExit("Missing required command(s): " + ", ".join(missing))


def run_command(args: list[str], target: Path) -> None:
    print("+ " + " ".join(args), flush=True)
    completed = subprocess.run(args, cwd=str(target), text=True)
    if completed.returncode != 0:
        raise SystemExit(f"Command failed with exit code {completed.returncode}: {' '.join(args)}")


def venv_python_arg() -> str:
    if os.name == "nt":
        return r".\.venv\Scripts\python.exe"
    return "./.venv/bin/python"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Strictly set up or refresh a Python project folder.")
    parser.add_argument("--target", default=".", help="Target project folder. Defaults to current directory.")
    parser.add_argument("--python-version", default=PYTHON_VERSION, help="Python version to configure.")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    target = resolve_target(args.target)
    paths = manifest_paths(target)

    require_tools()

    project_name = normalize_project_name(target.name)
    for tool in DEFAULT_MISE_TOOLS:
        run_command(["mise", "use", tool], target)
    run_command(["mise", "use", f"python@{args.python_version}"], target)
    run_command(["mise", "trust", "."], target)

    if paths[".venv"].exists():
        print("= .venv already exists; leaving it in place", flush=True)
    else:
        run_command(["mise", "exec", "--", "uv", "venv", "--python", args.python_version, "--seed"], target)

    if paths["pyproject.toml"].exists():
        print("= pyproject.toml already exists; leaving it in place", flush=True)
    else:
        run_command(
            [
                "mise",
                "exec",
                "--",
                "uv",
                "init",
                "--bare",
                "--name",
                project_name,
                "--description",
                "",
                "--no-pin-python",
                "--no-workspace",
                "--python",
                venv_python_arg(),
            ],
            target,
        )

    print("Applied strict Python project setup manifest:")
    for rel, path in paths.items():
        state = "present" if path.exists() else "missing"
        print(f"- {rel}: {state}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
