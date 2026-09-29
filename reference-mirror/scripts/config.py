from __future__ import annotations

from pathlib import Path

DEFAULT_REFERENCE_ROOT = Path(".agents/references")
FIXTURES_DIRNAME = "fixtures"
STANDARD_FILES = {
    "README.md",
    "SOURCE_URLS.md",
    "REFERENCE_SUMMARY.md",
    "REFERENCE_INDEX.md",
}


def mirror_base_dir(bundle: Path) -> Path:
    return bundle
