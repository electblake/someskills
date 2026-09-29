---
name: setup-python
description: Additive setup for Python project folders using the Setup Environment mise defaults plus Python 3.12.9. Use when Codex is asked to set up, re-run, augment, update, or repair the preferred mise.toml/pyproject.toml/.venv baseline, or reproduce the user's standard `mise use powershell@latest`, `mise use uv`, `mise use python`, `mise trust`, `uv venv --seed`, and `uv init --bare --python .\.venv\Scripts\python.exe` workflow. This skill must not inspect, edit, delete, or infer from project files outside its strict manifest.
---

# Setup Python

Set up or augment the current Codex project folder as a Python project using the user's preferred mise and uv workflow while obeying a strict project-file manifest.

## Strict Manifest

Only these project paths may be inspected, created, or updated:

```text
mise.toml
.venv
pyproject.toml
```

Do not list the project directory. Do not read README files, source files, lock files, git metadata, hidden config, or any other path. Do not delete project paths. Do not add files to the manifest unless the user explicitly updates the skill.

Skill-internal files under this skill folder may be read or executed as needed.

## Additive Behavior

- Re-running this skill should be safe for projects that are already set up.
- Start from the Setup Environment `mise.toml` defaults: `mise use powershell@latest` and `mise use uv`.
- Add Python on top with `mise use python@3.12.9`.
- Create `.venv` only when `.venv` is missing.
- Create `pyproject.toml` only when `pyproject.toml` is missing.
- Leave existing `.venv` and `pyproject.toml` in place. Treat them as project-owned opinions unless the user explicitly asks for a targeted repair.
- Do not discard, clear, replace, or take ownership of existing project setup.

## Workflow

1. Treat the current working directory as the target project folder unless the user explicitly names another folder.
2. Read `references/powershell-mise-uv.md` when running from PowerShell, debugging command invocation, or explaining why path and native-command handling are strict.
3. Read `references/uv-init-pyproject.md` when changing, checking, fixing, installing, or updating `pyproject.toml` setup behavior.
4. Execute `scripts/setup_python_project.py` from this skill folder instead of hand-editing project files.
5. Do not run additional discovery commands in the target folder before or after the script.

Recommended invocation from PowerShell:

```powershell
python "<skill-folder>\scripts\setup_python_project.py" --target "<project-folder>"
```

If `python` resolves to a stub or unavailable interpreter, use an already-known Python executable. Do not search the target project for one.

## Expected Setup

The script performs the equivalent of:

```powershell
mise use powershell@latest
mise use uv
mise use python@3.12.9
mise trust .
mise exec -- uv venv --python 3.12.9 --seed
mise exec -- uv init --bare --name "<normalized-folder-name>" --description "" --no-pin-python --no-workspace --python ".\.venv\Scripts\python.exe"
```

On non-Windows platforms, use `./.venv/bin/python` for the `uv init --python` argument.

Skip the `uv venv` command when `.venv` already exists. Skip the `uv init` command when `pyproject.toml` already exists.

When `pyproject.toml` is missing, `uv init --bare` creates a minimal project baseline like:

```toml
[project]
name = "<normalized-folder-name>"
version = "0.1.0"
description = ""
requires-python = ">=3.12"
dependencies = []
```

## Failure Rules

- If `mise`, mise-managed `uv`, or Python cannot run, report the failing command and stop.
- If a manifest path cannot be safely resolved inside the target folder, stop.
- If `.venv` exists, leave it in place.
- If `pyproject.toml` exists, leave it in place.
- If the user reports error or corruption, make the narrowest targeted repair possible and ask before deleting or replacing any manifest path.
- Never clean, normalize, format, inspect, or mention unrelated project files.
