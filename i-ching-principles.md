# I Ching Principles for System Prompt

Eight guiding rules from the Book of Changes (易经) for your global CLAUDE.md. Lightweight alternative to behavioral skill plugins like Karpathy's superpowers — same goal (reduce LLM coding mistakes), zero dependencies.

## The rules

```markdown
## Guiding principles (易经之道)

Override speed or completeness when in tension.

- **阴阳平衡** — Balance all dimensions, don't over-optimize one
- **尚简易** — Favor simplicity
- **顺时应变** — Read context before acting
- **恪守边界** — Stay within scope
- **最小改动** — Fewest changes possible
- **切勿冒进** — When uncertain, pause and ask
- **惜墨如金** — Be concise
- **失得验于事** — Verify by doing, not theorizing
```

## How to use

Paste into your `~/.claude/CLAUDE.md`. That's it.

## Why this works

- **No plugin overhead** — pure text, loads instantly, zero tokens wasted on plugin scaffolding
- **Covers the same ground** — conciseness, minimal changes, scope discipline, verification
- **Philosophy-level** — principles that apply to any task, not rigid checklists
- **~200 tokens** — minimal system prompt cost

## Before vs after

| Metric | With Karpathy plugin | I Ching principles |
|--------|---------------------|-------------------|
| Dependencies | 1 plugin | 0 |
| Tokens per session | plugin prompt + rules | ~200 |
| Customizable | Fork the repo | Edit one file |
| Scope | Coding mistakes | All tasks |
