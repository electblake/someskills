# Playwright Web Search

## Use

- Use only after MCP options fail.

## Steps

1. Open a browser page.
2. Go to `https://www.google.com/` unless user specifies an engine.
3. Enter query and run search.
4. Collect top relevant organic results.
5. Open results and verify.
6. Return verified links.

## Rules

- Respect user-specified search engine if provided.
- Skip ads.
- If blocked (captcha/consent), report blocker and stop.
- Keep output short.
