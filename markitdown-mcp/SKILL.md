---
name: markitdown-mcp
description: Use Microsoft's MarkItDown MCP server to convert files, web URLs, data URIs, and other supported inputs into Markdown. Use when Codex needs document-to-Markdown conversion through the bundled markitdown MCP server.
---

# MarkItDown MCP

Use this skill when document conversion should happen through the configured MarkItDown MCP server rather than through ad hoc parsing.

## Server

The official Microsoft MarkItDown MCP package is configured as:

```json
{
  "mcpServers": {
    "markitdown": {
      "command": "uvx",
      "args": ["markitdown-mcp"]
    }
  }
}
```

The server exposes `convert_to_markdown(uri)`.

Supported URI schemes from the official README:

- `http:`
- `https:`
- `file:`
- `data:`

## Safety

MarkItDown-MCP runs with the privileges of the current process. Treat `file:` and remote URLs as sensitive inputs because the tool can read project files and network resources available to the user running the server. Keep HTTP/SSE transports bound to `localhost` if used.

## Official References

- https://github.com/microsoft/markitdown
- https://github.com/microsoft/markitdown/tree/main/packages/markitdown-mcp
- `../../references/puremd__markitdown-mcp.md`
