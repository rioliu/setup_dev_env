# Claude Code Setup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add Claude Code install script, settings (DeepSeek default + GLM profile), GitHub MCP, and README section to the macOS dev environment bootstrap repo.

**Architecture:** Four static config files and one idempotent shell script under `macOS/claude_code/`. DeepSeek env lives in settings.json as the default; GLM overrides sit in `profiles/glm.json` for `--settings`-based switching. No runtime logic — pure config + a trivial install script.

**Tech Stack:** Bash, JSON, Homebrew

---

### Task 1: Create directory structure

**Files:**
- Create: `macOS/claude_code/` (directory)
- Create: `macOS/claude_code/profiles/` (directory)

- [ ] **Step 1: Create directories**

```bash
mkdir -p macOS/claude_code/profiles
```

- [ ] **Step 2: Commit**

```bash
git add macOS/claude_code/
git commit -m "scaffold claude_code directory structure"
```

---

### Task 2: Create install.sh

**Files:**
- Create: `macOS/claude_code/install.sh`

- [ ] **Step 1: Write install.sh**

```bash
#!/bin/bash
set -e

echo "Installing Claude Code..."
brew install claude-code 2>/dev/null || echo "claude-code already installed"

echo "Installing plugins..."
claude plugins install superpowers@claude-plugins-official 2>/dev/null || echo "superpowers already installed"
claude plugins install context7@claude-plugins-official 2>/dev/null || echo "context7 already installed"
claude plugins install skill-creator@claude-plugins-official 2>/dev/null || echo "skill-creator already installed"

echo "Done. Next: copy macOS/claude_code/settings.json to ~/.claude/settings.json"
echo "       copy macOS/claude_code/mcp.json to ~/.claude/mcp.json"
```

- [ ] **Step 2: Make it executable**

```bash
chmod +x macOS/claude_code/install.sh
```

- [ ] **Step 3: Verify script is syntactically valid**

```bash
bash -n macOS/claude_code/install.sh
```

- [ ] **Step 4: Commit**

```bash
git add macOS/claude_code/install.sh
git commit -m "add claude code install script (brew + plugins)"
```

---

### Task 3: Create settings.json

**Files:**
- Create: `macOS/claude_code/settings.json`

- [ ] **Step 1: Write settings.json**

```json
{
  "enabledPlugins": {
    "superpowers@claude-plugins-official": true,
    "context7@claude-plugins-official": true,
    "skill-creator@claude-plugins-official": true
  },
  "theme": "dark",
  "autoCompactEnabled": true,
  "model": "deepseek-v4-pro",
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.deepseek.com/anthropic",
    "ANTHROPIC_AUTH_TOKEN": "${DEEPSEEK_API_KEY}",
    "ANTHROPIC_MODEL": "deepseek-v4-pro",
    "ANTHROPIC_SMALL_FAST_MODEL": "deepseek-v4-flash",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "deepseek-v4-pro",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "deepseek-v4-pro",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "deepseek-v4-flash",
    "CLAUDE_CODE_SUBAGENT_MODEL": "deepseek-v4-flash",
    "API_TIMEOUT_MS": "3000000",
    "CLAUDE_CODE_ATTRIBUTION_HEADER": "0",
    "CLAUDE_CODE_EFFORT_LEVEL": "max",
    "CLAUDE_CODE_MAX_OUTPUT_TOKENS": "32000",
    "CLAUDE_CODE_AUTO_COMPACT_WINDOW": "200000",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  },
  "permissions": {
    "allow": [
      "Bash(echo *)",
      "Bash(ls *)",
      "Bash(cat *)",
      "Bash(head *)",
      "Bash(tail *)",
      "Bash(find *)",
      "Bash(grep *)",
      "Bash(wc *)",
      "Bash(sort *)",
      "Bash(uniq *)",
      "Bash(which *)",
      "Bash(date *)",
      "Bash(pwd *)",
      "Bash(env *)",
      "Bash(printenv *)",
      "Bash(whoami *)",
      "Bash(uname *)",
      "Bash(hostname *)",
      "Bash(stat *)",
      "Bash(file *)",
      "Bash(du *)",
      "Bash(df *)",
      "Bash(diff *)",
      "Bash(jq *)",
      "Bash(man *)",
      "Bash(ps *)",
      "Bash(type *)",
      "Bash(cut *)",
      "Bash(tr *)",
      "Bash(awk *)",
      "Bash(sed *)",
      "Bash(xargs *)",
      "Bash(tee *)",
      "Bash(git *)",
      "Bash(curl *)"
    ]
  }
}
```

- [ ] **Step 2: Validate JSON syntax**

```bash
python3 -m json.tool macOS/claude_code/settings.json > /dev/null && echo "Valid JSON"
```

- [ ] **Step 3: Commit**

```bash
git add macOS/claude_code/settings.json
git commit -m "add claude code settings.json with DeepSeek default backend"
```

---

### Task 4: Create mcp.json

**Files:**
- Create: `macOS/claude_code/mcp.json`

- [ ] **Step 1: Write mcp.json**

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/github-mcp-server"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

- [ ] **Step 2: Validate JSON syntax**

```bash
python3 -m json.tool macOS/claude_code/mcp.json > /dev/null && echo "Valid JSON"
```

- [ ] **Step 3: Commit**

```bash
git add macOS/claude_code/mcp.json
git commit -m "add GitHub MCP server config"
```

---

### Task 5: Create profiles/glm.json

**Files:**
- Create: `macOS/claude_code/profiles/glm.json`

- [ ] **Step 1: Write profiles/glm.json**

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://open.bigmodel.cn/api/anthropic",
    "ANTHROPIC_AUTH_TOKEN": "${ZHIPU_API_KEY}",
    "ANTHROPIC_MODEL": "glm-4.7",
    "ANTHROPIC_SMALL_FAST_MODEL": "glm-4.5-air",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "glm-5.1",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "glm-5-turbo",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "glm-4.5-air",
    "CLAUDE_CODE_SUBAGENT_MODEL": "glm-4.5-air",
    "API_TIMEOUT_MS": "3000000",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  }
}
```

- [ ] **Step 2: Validate JSON syntax**

```bash
python3 -m json.tool macOS/claude_code/profiles/glm.json > /dev/null && echo "Valid JSON"
```

- [ ] **Step 3: Commit**

```bash
git add macOS/claude_code/profiles/glm.json
git commit -m "add GLM backend profile for claude code switching"
```

---

### Task 6: Update README.md

**Files:**
- Modify: `README.md`

- [ ] **Step 1: Add Claude Code section to README**

Insert after the "install homebrew apps" section and before "Configure install software and env":

```markdown
* install and configure `Claude Code`

      ./setup_dev_env/macOS/claude_code/install.sh
      
  Copy config files to home directory:
      
      cp macOS/claude_code/settings.json ~/.claude/settings.json
      cp macOS/claude_code/mcp.json ~/.claude/mcp.json
      
  Default backend is DeepSeek V4. To switch to GLM:
      
      claude --settings ~/.claude/settings.json --settings macOS/claude_code/profiles/glm.json
      
  Required shell env vars (add to ~/.zprofile):
      
      export DEEPSEEK_API_KEY="sk-..."
      export ZHIPU_API_KEY="..."
      export GITHUB_TOKEN="ghp_..."
```

- [ ] **Step 2: Commit**

```bash
git add README.md
git commit -m "add Claude Code setup section to README"
```
