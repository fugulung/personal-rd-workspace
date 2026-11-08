# ARCHITECTURE

[English](#english) | [繁體中文](#繁體中文)

---

## English

A deliberately small design: plain Markdown files that Claude Code reads on demand, plus one PowerShell script. No servers, no dependencies.

### Two layers
- **L0 – workspace layer** (this repository root): `CLAUDE.md`, shared agents, shared skills, and the `Shared/Tech/` knowledge base.
- **L1 – product layer**: one folder per product under `Projects/<name>/`, with the product's own code, docs, and `docs/KNOWLEDGE.md`. A product may use its own Git repository. L1 may extend L0 but must not lower its safety or quality requirements.

```text
Personal-RD-Workspace/
├── CLAUDE.md                 L0 rules
├── README.md / README.zh-TW.md / VERSION.md
├── docs/                     SETUP, ARCHITECTURE, MANIFEST
├── .claude/
│   ├── agents/               po.md, engineer.md, qa.md
│   └── skills/               ana/, hub/
├── Shared/
│   ├── Tech/                 index + References / Solutions / Snippets
│   └── Templates/            Project-Template/ (+ New-Project.ps1)
└── Projects/
    ├── CLAUDE.md             rules shared by all products (L1)
    ├── PROJECT-INDEX.md      project list
    └── <product>/            your products (not part of this repository)
```

### How the pieces work together
- **Agents** are short role definitions, used only when needed: *PO* (requirements, priorities, risks, smallest deliverable), *Engineer* (design, implementation, self-testing, UX), *QA* (risk-graded verification: L1 light / L2 standard / L3 high-risk, with a maximum number of rounds, and PASS / FAIL / NOT VERIFIED reporting).
- **Skills**: `/ana` classifies a request as an ordinary or major change, lists risks and 2–5 verifiable steps, and runs the knowledge-closure step after QA. `/hub` researches open-source options for major or unfamiliar technology and never installs dependencies or touches real data while researching.
- **Knowledge loop**: only *verified, cross-product reusable* findings go to `Shared/Tech/` (References = principles and measurements, Solutions = verified fixes, Snippets = small reusable code). Check for duplicates first, label what was and was not verified, and state the test environment for any measurement. Candidates are listed for the owner to decide; nothing is added automatically.
- **Safety rules** (in `CLAUDE.md`): major product decisions, architecture changes, permission changes, and risky operations on real data need the owner's approval first; no commit or push without authorization; no destructive commands; deletion, network-drive, and database-migration work gets the strictest QA level.

### Links
A product that has its own Git repository is not scanned for the workspace's skills, so each product gets Windows Junctions `.claude/skills/<skill>` → the workspace's `.claude/skills/<skill>`. They are not packaged; `New-Project.ps1` creates them (`-LinksOnly` rebuilds them). Agents need no links, because `Projects/CLAUDE.md` references them with relative paths.

### New projects
`Shared/Templates/Project-Template/New-Project.ps1` copies `template/` (README, `docs/KNOWLEDGE.md`, `.claude/settings.json`, `.gitignore`, `.gitattributes`), creates the skill links, adds a row to `PROJECT-INDEX.md`, and runs `git init` (never `git commit`). It refuses to overwrite an existing project, validates the project name, and checks that the target really is a workspace.

### Design limits
Verified on Windows 11 only. The agent, skill, and rule files are in Traditional Chinese. There are no Hooks.

---

## 繁體中文

刻意保持精簡：純 Markdown 檔案由 Claude Code 按需讀取，加上一個 PowerShell 腳本。沒有伺服器、沒有相依套件。

### 兩個層級
- **L0 工作區層**（本儲存庫根目錄）：`CLAUDE.md`、共用 Agent、共用 Skill 與 `Shared/Tech/` 知識庫。
- **L1 產品層**：`Projects/<名稱>/` 每個產品一個資料夾，含自己的程式、文件與 `docs/KNOWLEDGE.md`；產品可有自己的 Git。L1 可擴充 L0，但不得降低 L0 的安全與品質要求。

目錄結構見上方英文段落的樹狀圖。

### 運作方式
- **Agent** 是精簡的角色定義，按需使用：*PO*（需求、優先順序、風險、最小交付）、*Engineer*（設計、實作、自測、UX）、*QA*（依風險分級驗證：L1 輕量／L2 標準／L3 高風險，有輪次上限，以 PASS／FAIL／NOT VERIFIED 回報）。
- **Skill**：`/ana` 判斷一般或重大更新、列出風險與 2～5 個可驗收的小步驟，並在 QA 後執行知識閉環；`/hub` 針對重大或未知技術研究開源方案，研究階段不安裝依賴、不碰真實資料。
- **知識閉環**：只有*已驗證、跨產品可重用*的內容才收進 `Shared/Tech/`（References＝原理與實測、Solutions＝已驗證解法、Snippets＝小型可重用程式）。先查重，標註已驗證與未驗證的範圍，量測數據要註明測試環境。候選先列給擁有者決定，不自動收錄。
- **安全規則**（在 `CLAUDE.md`）：重大產品決策、架構變更、權限調整與真實資料的高風險操作須先取得同意；未授權不 Commit／Push；不執行破壞性指令；刪除、網路磁碟、資料庫遷移採最嚴格的 QA 等級。

### 連結
有自己 Git 的產品不會被掃描到工作區的 Skill，因此每個產品用 Windows Junction 把 `.claude/skills/<skill>` 指向工作區的 `.claude/skills/<skill>`。連結不打包，由 `New-Project.ps1` 建立（`-LinksOnly` 重建）。Agent 不需要連結，因為 `Projects/CLAUDE.md` 以相對路徑引用。

### 新專案
`Shared/Templates/Project-Template/New-Project.ps1` 複製 `template/`（README、`docs/KNOWLEDGE.md`、`.claude/settings.json`、`.gitignore`、`.gitattributes`）、建立 Skill 連結、在 `PROJECT-INDEX.md` 補一列並 `git init`（不會 commit）。已存在的專案不覆蓋、會驗證專案名稱，並確認目標確實是工作區。

### 設計限制
僅在 Windows 11 驗證；Agent、Skill、規範檔為繁體中文；沒有 Hooks。
