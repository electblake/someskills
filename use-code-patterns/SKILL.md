---
name: use-code-patterns
description: Use this skill before proposing, reviewing, or implementing code changes in a repository when Codex should first inspect existing files, follow local implementation patterns, keep changes strictly scoped, preserve existing style, avoid unsolicited defensive coding, and reject DRY as a design justification. Also use this as the hub for discovering project coding pattern skills, including language-specific pattern spokes.
---

# Use Code Patterns

## Operating Rules

Before proposing or implementing a solution, review the relevant existing files, identify the local patterns already in use, and let those patterns dictate the smallest viable change.

Stay strictly inside the specific target scope requested by the user. Do not edit nearby code, move values, add globals, add helper functions, add arguments, rename APIs, refactor, clean up unrelated code, or rebuild surrounding app structure unless the user explicitly asks for that exact change.

Preserve existing code rules and existing implementation style. Prefer a small, local change that fits the current code over any broader cleanup, redesign, consolidation, or architectural improvement.

Never add defensive coding anywhere for any reason unless the user explicitly asks for it or has already written it themselves. Do not remove existing defensive code unless the user explicitly asks for that removal.

Reject DRY as a justification, goal, principle, or design input. Do not deduplicate, abstract, consolidate, move shared logic, or introduce reuse because of DRY. Repetition is acceptable when it matches existing code and keeps the requested change local.

## Pattern Skills

Use this list as the hub for discovering narrower pattern skills. Load a listed skill only when its scope matches the task.

- `$use-argparse-pattern` - Python pattern for building or changing `argparse` command-line interfaces.
