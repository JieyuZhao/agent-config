# Claude Code Extras

Optional features and fun stuff. See [claude-code-tips.md](claude-code-tips.md) for workflows and [claude-code-reference.md](claude-code-reference.md) for lookup tables.

---

## Buddy / Companion

Run `/buddy` to hatch a terminal companion. The companion is **deterministic**: Claude Code hashes your user ID with a hardcoded salt (`friend-2026-401`) through a Mulberry32 PRNG to roll rarity, species, eyes, hat, and shiny status. Your account always produces the same companion.

**Rarity odds:**

| Rarity    | Chance |
|-----------|--------|
| Common    | 60%    |
| Uncommon  | 25%    |
| Rare      | 10%    |
| Epic      | 4%     |
| Legendary | 1%     |

Shiny is an independent 1% roll on top of rarity, making a shiny legendary a 1-in-10,000 outcome. Common companions cannot have hats.

### Forcing a specific companion with ccbuddyy

Since the companion is fully determined by the salt, changing the salt changes the result. [ccbuddyy](https://github.com/vibenalytics/ccbuddyy) patches the salt in the Claude Code binary to produce whatever companion you want.

```bash
# Interactive — browse pre-searched legendaries
npx ccbuddyy

# Specific build
npx ccbuddyy build -species dragon -rarity legendary -hat crown

# Shiny legendary (brute-forces salts, ~100x slower)
npx ccbuddyy build -species penguin -rarity legendary -shiny

# See current companion
npx ccbuddyy current

# Restore original binary
npx ccbuddyy restore
```

**Species:** duck, goose, blob, cat, dragon, octopus, owl, penguin, turtle, snail, ghost, axolotl, capybara, cactus, robot, rabbit, mushroom, chonk

**Hats:** crown, tophat, propeller, halo, wizard, beanie, tinyduck

**Eyes:** dot, star, x, circle, at, degree

Visual builder: [ccbuddy.dev](https://ccbuddy.dev)

**After Claude Code updates:** each update replaces the binary and resets the companion. Re-run `npx ccbuddyy` to re-patch.

---

## Plugins

Plugins extend Claude Code with bundled skills, hooks, MCP servers, and agents. Install from Anthropic's official marketplace (`claude-plugins-official`) or community sources.

### Commands

| Command                                | What it does                          |
|----------------------------------------|---------------------------------------|
| `/plugin`                              | Open the plugin manager UI            |
| `/plugin install name@marketplace`     | Install a plugin                      |
| `/plugin disable name@marketplace`     | Disable without uninstalling          |
| `/plugin uninstall name@marketplace`   | Remove a plugin                       |
| `/reload-plugins`                      | Apply changes without restarting      |

**Installation scopes:** user (all projects, default), project (shared with collaborators), or local (just you, this repo).

### How plugins activate

- **Language servers** (e.g., `pyright-lsp`): run automatically in the background, no invocation needed.
- **Skills** (e.g., `frontend-design`, `superpowers`): trigger automatically when your prompt matches their domain. You can also invoke explicitly via `/plugin-name:skill-name`.
- **Integrations** (e.g., `github`): add capabilities Claude uses automatically.

Note: some plugins (like `superpowers`) register skills, not slash commands. They do not appear in the `/` autocomplete menu. They trigger when Claude processes your prompt.

### Recommended plugins for academic ML/AI workflow

| Plugin                                        | Why                                                                 |
|-----------------------------------------------|---------------------------------------------------------------------|
| `frontend-design@claude-plugins-official`     | HTML mockups and demo pages for proposals and presentations         |
| `pyright-lsp@claude-plugins-official`         | Better code intelligence for Python/ML work                        |
| `github@claude-plugins-official`              | Deeper GitHub integration beyond `gh` CLI                           |
| `superpowers@claude-plugins-official`         | Structured workflows: brainstorm, plan, execute, review, debug      |

### superpowers workflow

The `superpowers` plugin enforces a think-before-you-code discipline. Skills trigger automatically based on your prompt:

| What you say | Skill that triggers |
|---|---|
| "Build a new feature for X" | `brainstorming` — explores intent and design first |
| "Plan the implementation for X" | `writing-plans` — step-by-step plan |
| "Execute the plan" | `executing-plans` — runs plan with checkpoints |
| "Review this code" | `requesting-code-review` |
| "Debug why X is failing" | `systematic-debugging` |
| "Is this done? Let us merge" | `finishing-a-development-branch` |

Useful for larger tasks; overkill for quick edits.

### Other official plugins

- **Code intelligence:** language servers for TypeScript, Rust, Go, C/C++, Java, etc.
- **Project management:** Jira, Asana, Linear, Notion
- **Infrastructure:** Vercel, Firebase, Supabase
- **Design:** Figma
- **Communication:** Slack
- **Monitoring:** Sentry
- **Workflow:** `commit-commands`, `pr-review-toolkit`, `agent-sdk-dev`, `plugin-dev`
- **Output styles:** `explanatory-output-style`, `learning-output-style`

### Docs

- Plugin discovery: https://code.claude.com/docs/en/discover-plugins.md
- Creating plugins: https://code.claude.com/docs/en/plugins.md
- Technical reference: https://code.claude.com/docs/en/plugins-reference.md
