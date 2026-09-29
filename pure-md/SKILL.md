---
name: pure-md
description: Fetch web content as markdown via pure.md REST API. Use when downloading web pages, documentation, RFCs, specs, or any URL as markdown for project references. Triggers on requests to save/download/fetch a URL, cache web content, or add external documentation to references.
---

# pure-md

REST API that lets AI agents reliably access web content.

## Requirements

```powershell
Install-Module powershell-yaml -Scope CurrentUser
```

## Endpoints

| Method | Path | Description | Auth |
|--------|------|-------------|------|
| GET | `/:url` | Fetch as markdown | Optional |
| POST | `/:url` | Fetch + extract JSON | Required |
| GET | `/search?q=` | Web search | Required |
| POST | `/search?q=` | Search + extract | Required |

See [openapi.json](openapi.json) for full API spec.

## Script Usage

```powershell
.\Invoke-PureMd.ps1 -Uri "https://example.com/doc.html"
```

**Parameters:**
- `-Uri` (required): URL to fetch
- `-OutputDir`: Base directory (default: `./references`)
- `-Filename`: Override auto-generated filename
- `-ApiToken`: For higher rate limits
- `-Force`: Overwrite without prompting

**Output structure:**
```
references/
  <fqdn>/
    ID_TITLE.md
```

## Filename Convention

Files named with ID prefix for sorting:
- `RFC8878_Zstandard Compression.md`
- `IEEE802_Ethernet Standard.md`
- `ISO9001_Quality Management.md`

Script auto-detects ID patterns from URL path. Falls back to page title when no ID found.

## Rate Limits

| Tier | Requests/min |
|------|--------------|
| Anonymous | 6 |
| Logged in | 10 |
| Starter | 60 |
| Growth | 600 |
| Business | 3000 |

## Overwrite Behavior

Script checks if file exists before writing:
1. If exists: prompts for confirmation
2. Use `-Force` to skip prompt
3. Never auto-overwrites

Always use the script for downloads to ensure consistent behavior.
