# PowerShell, mise, and uv Reference

This reference is a compact skill-local summary derived from this repo's `mise-with-powershell.md` and `ps7_quickstart.md` references.

## Source Bundle

- `plugins/btec-environments-plugin/skills/mise-use/references/mise-with-powershell.md`
- `plugins/btec-powershell-plugin/skills/powershell-7-expert/references/ps7_quickstart.md`

## Operational Rules

- Use PowerShell-native path handling when constructing paths: `Join-Path`, `Resolve-Path`, or a script's own path logic.
- Quote native command arguments that contain spaces. Prefer argument arrays in scripts over shell-composed command strings.
- For this skill, avoid broad PowerShell discovery commands such as `Get-ChildItem` in the target project folder because the project manifest is intentionally limited.
- `mise use powershell@latest` installs the Setup Environment default PowerShell runtime and writes it to the project `mise.toml`.
- `mise use uv` installs the Setup Environment default uv tool through mise when needed and writes it to the project `mise.toml`.
- `mise use python@3.12.9` writes the project `mise.toml` tool version for Python.
- `mise trust .` trusts the current project configuration after `mise.toml` is created or updated.
- `uv venv --python 3.12.9 --seed` creates `.venv` and seeds pip when `.venv` is missing.
- `uv init --bare --python ".\.venv\Scripts\python.exe"` creates only `pyproject.toml` when `pyproject.toml` is missing and aligns the project metadata to the just-created virtual environment's interpreter. Add `--no-pin-python` so uv does not create `.python-version`.
- Existing `.venv` and `pyproject.toml` are project-owned. Leave them in place during normal re-runs.
- Treat a mise trust error as a setup blocker. Do not work around it by editing user-level mise config from this skill.

## PowerShell Invocation Pattern

Prefer direct native-command invocation:

```powershell
mise use powershell@latest
mise use uv
mise use python@3.12.9
mise trust .
mise exec -- uv venv --python 3.12.9 --seed
mise exec -- uv init --bare --name "<normalized-folder-name>" --description "" --no-pin-python --no-workspace --python ".\.venv\Scripts\python.exe"
```

For scripted use, let Python `subprocess.run([...], cwd=target)` pass each argument separately. This avoids quoting bugs and keeps the target project file access constrained to the strict manifest. Skip the uv commands for existing `.venv` or `pyproject.toml` instead of forcing replacement.
