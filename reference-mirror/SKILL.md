---
name: reference-mirror
description: Capture official documentation, API references, changelogs, and related sources into dated local reference bundles under `.agents/references`. Use when current source material should be preserved locally, when version or compatibility details need grounded references, or when saved references should be turned into a reusable skill.
---

# Reference Mirror

Capture authoritative external documentation into `.agents/references/` without touching plugin deployment files.

Use bundled resources selectively and keep command paths relative to this skill directory.

## Available Assets

- `assets/documentation-skill-template.md` - starting point when turning a completed reference bundle into a reusable documentation skill.

## Available Scripts

- `scripts/init_reference_bundle.py` - creates the standard dated reference bundle skeleton.
- `scripts/list_reference_bundles.py` - lists existing dated reference bundles so agents can discover the right project instead of guessing paths.
- `scripts/resolve_reference_bundle.py` - resolves the canonical bundle path for a topic and can create today's dated bundle when needed.
- `scripts/add_reference_fixture.py` - copies files or text into `fixtures/` with deterministic numbered names.
- `scripts/mirror_reference_sources.py` - mirrors official pages into `<domain>/`, checks each source domain for `/llms.txt`, and emits a JSON manifest.
- `scripts/sync_reference_bundle.py` - regenerates `SOURCE_URLS.md` and `REFERENCE_INDEX.md` from the actual mirrored files and fixtures.

Prerequisites:

- Python 3.8+.
- No third-party Python packages are required.
- Use `agents/openai.yaml` for Codex UI metadata only; do not treat it as workflow documentation.
- `scripts/config.py` is the single source of truth for root paths and folder names; update it first, then align scripts and instructions to match.

## Core Rules

- Prefer official vendor documentation, API references, changelogs, standards bodies, and official repositories in that order.
- Store references in `.agents/references/<website-or-topic>/<YYYY-MM-DD>/`.
- Save mirrored markdown under `<domain>/`.
- Preserve user-provided artifacts exactly under `fixtures/`.
- Never overwrite an existing reference bundle unless the user explicitly asks to refresh it.
- Keep "official source says" separate from "user runtime shows".

## Standard Layout

```text
.agents/references/<website-or-topic>/<YYYY-MM-DD>/
|- README.md
|- SOURCE_URLS.md
|- REFERENCE_SUMMARY.md
|- REFERENCE_INDEX.md
`- fixtures/
```

## Workflow

### 1. Scope the References

- Extract the topic from the user request.
- If the user asks for "latest" or "current", verify the exact version from official sources before writing anything.
- Pick a stable slug and date-stamped output folder.
- If existing references may already exist, resolve them first instead of guessing:

```bash
python scripts/list_reference_bundles.py --latest-only
python scripts/resolve_reference_bundle.py --topic "OpenAI Skills" --latest
```

- Prefer bootstrapping a new bundle with `python scripts/resolve_reference_bundle.py --topic "<topic>" --today --ensure` or `python scripts/init_reference_bundle.py <topic-slug>` from this skill directory rather than hand-creating the files.

### 2. Discover Sources

Use this priority order:

1. Official vendor documentation
2. Official API reference
3. Official changelog or release notes
4. Official repository documentation
5. Standards body specifications
6. User-provided artifacts

Source discovery rules:

- If the user provides official URLs, treat them as the seed pages for capture.
- For every official source domain, check `/llms.txt` before finalizing the page list.
- If `/llms.txt` exists, save it and mirror the linked pages alongside the explicitly requested URLs.
- If no page URLs are provided, passing the official docs domain is acceptable; use the site root plus any pages discovered from `/llms.txt`.
- For agent-skill references, `https://agentskills.io/llms.txt` and `https://developers.openai.com/codex/skills` are strong official starting points.

### 3. Mirror Faithful Markdown References

Resolve or initialize the bundle first, then use the mirroring script instead of ad hoc shell pipelines.

```bash
python scripts/resolve_reference_bundle.py --topic "OpenAI Skills" --today --ensure
python scripts/mirror_reference_sources.py --bundle .agents/references/openai-skills/2026-03-31 --url https://developers.openai.com/codex/skills
python scripts/mirror_reference_sources.py --bundle .agents/references/openai-skills/2026-03-31 --domain agentskills.io
```

The mirroring script automatically:

- checks `/llms.txt` for each source domain unless `--skip-llms` is used
- saves each discovered `llms.txt` under `<domain>/`
- mirrors requested pages and selected `llms.txt` pages as markdown under `<domain>/`
- writes progress to stderr and a JSON manifest to stdout

Store user-provided files with the fixture script instead of naming them manually.

```bash
python scripts/add_reference_fixture.py --bundle .agents/references/openai-skills/2026-03-31 --file notes.txt
python scripts/add_reference_fixture.py --bundle .agents/references/openai-skills/2026-03-31 --text "Observed mismatch in SDK behavior" --label runtime-note
```

### 4. Produce Curated Outputs

Always generate these files:

- `README.md`: bundle purpose and scope
- `SOURCE_URLS.md`: every official URL used
- `REFERENCE_SUMMARY.md`: key findings, versions, dates, and compatibility notes
- `REFERENCE_INDEX.md`: navigation hub for mirrored content

Use the sync script after mirroring or adding fixtures so the bundle inventory stays correct.

```bash
python scripts/sync_reference_bundle.py --bundle .agents/references/openai-skills/2026-03-31
```

## Output Standards

### Reference Summary

Include:

- Tool or platform name with exact version when available
- Reference date in `YYYY-MM-DD`
- Official sources used
- Key capabilities from official documentation
- Compatibility notes, version constraints, and breaking changes
- User context only when it is clearly labeled as runtime-specific

### Communication

- State the scope before capturing sources.
- Report the storage path early.
- Confirm official sources before mirroring when the request is ambiguous.
- Return the created file paths at the end.

## Safety

- Use `.agents/references/` only for reference artifacts.
- Do not modify plugin source, deployment files, or manifests during reference-only work.
- Do not infer version currency without verification.
- Do not collapse multiple version snapshots into one folder.
- Keep scripts non-interactive; pass inputs through flags.
- Prefer the bundle-management scripts over handwritten paths, filenames, or fixture numbering.

## Documentation Skill Generation

When the user asks to turn references into a reusable documentation skill:

1. Read `SOURCE_URLS.md`, `REFERENCE_SUMMARY.md`, `REFERENCE_INDEX.md`, and the needed `<domain>/` files.
2. Load `assets/documentation-skill-template.md` in this skill folder as the starting structure.
3. Extract the practical, high-value material into a self-contained `SKILL.md`.
4. Focus on setup, core APIs, examples, version information, and common workflows.
5. Keep the generated skill usable without requiring fresh external references.

## Quality Gates

- At least one official source was captured.
- `SOURCE_URLS.md` includes every verified URL used, including `llms.txt` when present.
- `REFERENCE_SUMMARY.md` records exact versions and dates when they were available.
- Mirrored markdown lives under `<domain>/`.
- User artifacts are preserved under `fixtures/`.
- Reference capture stays isolated from plugin runtime and deployment files.
