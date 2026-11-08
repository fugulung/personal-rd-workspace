# Personal-RD-Workspace Mini

**English** | [繁體中文](README.zh-TW.md)

A minimal, portable **AI-assisted R&D workflow** for a solo developer working with [Claude Code](https://claude.com/claude-code): shared rules, three agents (PO / Engineer / QA), two skills (`/ana` requirement analysis, `/hub` open-source research), a small verified knowledge base, and a one-command new-project template.

Priorities, in order: **useful features → pleasant and intuitive UI/UX → basic safety.**
It is meant for personal, non-commercial tooling work. It contains **no product code** and no private data.

> Not affiliated with or endorsed by Anthropic. "Claude" and "Claude Code" are trademarks of Anthropic.

## What you get

| Part | What it is |
|---|---|
| `CLAUDE.md` | Top-level working rules (L0): decisions that need your approval, QA levels, no commits/pushes or destructive actions without authorization, token-frugal habits |
| `.claude/agents/` | `po`, `engineer`, `qa` – short role definitions |
| `.claude/skills/` | `/ana` (requirement analysis and triage), `/hub` (open-source technology research) |
| `Projects/CLAUDE.md` | Shared rules for every product project (L1) |
| `Shared/Tech/` | Index plus a few verified, reusable technical notes (each states its test environment) |
| `Shared/Templates/Project-Template/` | New-project template and `New-Project.ps1` |
| `docs/` | `SETUP.md` (install, links, new project), `ARCHITECTURE.md`, `MANIFEST.txt` (SHA-256 of every file) |

## Quick start (Windows)

1. Download `Personal-RD-Workspace-Workflow-v3.1.0.zip` from the Releases page and extract it into a parent folder of your choice. You get `Personal-RD-Workspace/`.
2. Create your first project:
   ```powershell
   cd Personal-RD-Workspace\Shared\Templates\Project-Template
   .\New-Project.ps1 -Name MyTool -Purpose "one-line purpose"
   ```
3. Open `Projects\MyTool` in VS Code and start Claude Code. It reads the root `CLAUDE.md` and the project `README.md`.

Details, environment variables, and how to rebuild the skill links on a new computer: [docs/SETUP.md](docs/SETUP.md).
The structure and design: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

## Requirements

Windows 10/11, PowerShell 5.1 or later, Git (recommended), Claude Code (you sign in yourself). Verified on Windows 11 only; the script is PowerShell, so macOS/Linux need manual adjustment (see SETUP).

## Language note

The agent, skill, and rule files are written in **Traditional Chinese** (the author's working language) and were kept unchanged so the verified behavior is preserved. English READMEs and docs are provided for orientation. Contributions that add faithful English versions are welcome.

## Safety and privacy

- The package is built from an allow-list and scanned for secrets, host/user identifiers, absolute paths, IP/MAC addresses, product names, and non-essential file types.
- Knowledge notes were de-identified; their conclusions and test-environment labels were left unchanged. Measurements are valid only in the environment each note states.
- The workflow never commits, pushes, or runs destructive commands without your authorization; `New-Project.ps1` runs `git init` at most and never commits.

## Credits

`Shared/Tech/References/UX-UI/ux-design-principles.md` is organized around Jakob Nielsen's ten usability heuristics (Nielsen Norman Group). The descriptions and examples are the author's own wording.

## License

MIT. Copyright (c) 2026 Ryanlung. See [LICENSE](LICENSE).
