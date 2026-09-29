# Web Search Orchestrator

## Web Search Order

1. `openai-websearch-mcp`
2. `web_search` (kagimcp)
3. `playwright-web-search`

## URL Fetch Order

Use this ranking when the task is to fetch, verify, or inspect a known URL rather than discover new URLs:

1. `fetcher` (`fetcher-mcp`)
2. `mcp-web-fetch` (`mcp-web-fetch`)
3. `powershell-webrequest`
4. `curl-fetch`
5. `python-requests-fetch`
6. `playwright-web-search`

## Commands

- For web search, run the web search order first.
- For URL fetch or verification, run the URL fetch order first.
- Prefer MCP fetch servers over CLI-based fetch skills.
- Use CLI-based fetch skills in this order: PowerShell `Invoke-WebRequest`, curl, then Python `requests`.
- Use Playwright only when MCP and CLI fetch paths fail or when browser execution is required.

## Output Rules

- Return verified links only.
- Fetch each cited URL before output.
- Keep output short.
