# uv init Pyproject Setup

Use this reference when changing, checking, fixing, installing, or updating this skill's `pyproject.toml` setup behavior.

## Required Sequence

Run `uv init` only after `.venv` exists and only when `pyproject.toml` is missing:

```powershell
mise use powershell@latest
mise use uv
mise use python@3.12.9
mise trust .
mise exec -- uv venv --python 3.12.9 --seed
mise exec -- uv init --bare --name "<normalized-folder-name>" --description "" --no-pin-python --no-workspace --python ".\.venv\Scripts\python.exe"
```

Use `./.venv/bin/python` for the `--python` argument on non-Windows platforms.

## Manifest Rules

- Use `mise use uv`, not `mise install uv`, when the project `mise.toml` must record the uv runtime.
- Use `mise exec -- uv ...` for uv commands so mise-managed uv is used even when `uv` is not already on `PATH`.
- Skip `uv venv` when `.venv` already exists.
- Skip `uv init` when `pyproject.toml` already exists.
- Use `uv init --bare` so uv creates only `pyproject.toml`.
- Use `--no-pin-python` so uv does not create `.python-version`.
- Keep `--description ""` so the generated baseline remains aligned with the previous minimal project file.
- Never allow `uv init` to create README, source, package, VCS, lock, or workspace files in this strict skill.
- Never clear, replace, or delete an existing `.venv` or `pyproject.toml` unless the user explicitly asks for that exact repair.
