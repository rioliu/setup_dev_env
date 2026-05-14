# Claude Code Setup for macOS Dev Environment

## Summary

Add Claude Code installation, configuration, and MCP server setup to the dev environment bootstrap repo. DeepSeek V4 is the default backend; GLM is available as a profile-switchable alternative.

## Files to create

```
macOS/claude_code/
├── install.sh              # brew install claude-code + 3 plugins
├── settings.json            # permissions, plugins, DeepSeek env (default)
├── mcp.json                 # GitHub MCP server
└── profiles/
    └── glm.json             # GLM backend env override
```

## install.sh

- `brew install claude-code` (idempotent)
- Installs 3 plugins: superpowers, context7, skill-creator (all from `claude-plugins-official`)

## settings.json

Shared config + DeepSeek as default backend:

- **Permissions**: read-only bash command allow list matching existing setup (echo, ls, cat, head, tail, find, grep, wc, sort, uniq, which, date, pwd, env, printenv, whoami, uname, hostname, stat, file, du, df, diff, jq, man, ps, type, cut, tr, awk, sed, xargs, tee, git, curl)
- **enabledPlugins**: superpowers, context7, skill-creator
- **env block**: DeepSeek Anthropic-compatible endpoint
  - `ANTHROPIC_BASE_URL`: `https://api.deepseek.com/anthropic`
  - `ANTHROPIC_AUTH_TOKEN`: `${DEEPSEEK_API_KEY}` (from shell env)
  - Models: deepseek-v4-pro (Opus/Sonnet/Subagent), deepseek-v4-flash (Haiku/SmallFast)
  - `API_TIMEOUT_MS`: `3000000`
  - `CLAUDE_CODE_ATTRIBUTION_HEADER`: `0`
- **model**: `deepseek-v4-pro`

## mcp.json

GitHub MCP server (`github.com/github/github-mcp-server`), auth via `env:GITHUB_TOKEN`.

## profiles/glm.json

Override backend to GLM:

- `ANTHROPIC_BASE_URL`: `https://open.bigmodel.cn/api/anthropic`
- `ANTHROPIC_AUTH_TOKEN`: `${ZHIPU_API_KEY}`
- Models: glm-5.1 (Opus), glm-5-turbo (Sonnet), glm-4.5-air (Haiku), glm-4.7 (default)
- `API_TIMEOUT_MS`: `3000000`
- `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC`: `1`

Usage: `claude --settings ~/.claude/settings.json --settings profiles/glm.json`

## Shell setup

Only two API key exports in zprofile; all model config moved into settings.json:

```bash
export DEEPSEEK_API_KEY="sk-..."
export ZHIPU_API_KEY="..."
```

## README

Add Claude Code section referencing install script, config files, and profile switching.
