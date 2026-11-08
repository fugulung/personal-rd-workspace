# SETUP

[English](#english) | [繁體中文](#繁體中文)

---

## English

This package contains **only the AI R&D workflow** (L0 rules, agents, skills, knowledge notes, shared project rules, new-project template). It contains **no product code or data, no API keys/tokens/passwords, and no Hooks** (the workflow does not use any).

`<WORKSPACE_ROOT>` below is where you want the workspace; any location works, it does not need to match the original machine.

### 1. Requirements
- Windows 10/11 and PowerShell 5.1 or later (the built-in one is fine; PowerShell 7 also works).
- Git (recommended; the script runs `git init`, never `git commit`).
- Claude Code (VS Code extension or CLI); sign in yourself.

### 2. Restore the workflow
1. Pick a parent folder `<PARENT>`.
2. Extract the Workflow ZIP into it:
   ```powershell
   Expand-Archive -Path .\Personal-RD-Workspace-Workflow-v3.1.0.zip -DestinationPath <PARENT>
   ```
   You get `<PARENT>\Personal-RD-Workspace\` (= `<WORKSPACE_ROOT>`).
3. (Recommended) Verify integrity: `docs\MANIFEST.txt` lists the SHA-256 and size of every file. The release page also has `SHA256SUMS.txt` for the ZIP files themselves.
4. (Optional) Run `git init` in `<WORKSPACE_ROOT>`. The included `.gitignore` does not track product folders, only `Projects\PROJECT-INDEX.md`.
5. **Restoring into an existing workspace: do not overwrite.** Compare first and merge incrementally (keep your projects, Git history, and custom rules).

### 3. Environment variables
None are required. One optional variable:

| Variable | Purpose | Default |
|---|---|---|
| `RD_WORKSPACE` | Lets `New-Project.ps1` find the workspace without `-Workspace` | Computed three levels up when the script sits in `<WORKSPACE_ROOT>\Shared\Templates\Project-Template\` |

```powershell
[Environment]::SetEnvironmentVariable('RD_WORKSPACE', '<WORKSPACE_ROOT>', 'User')   # takes effect in new terminals
```
Product-specific variables (data folders, passwords) belong to each product; never put them in this workflow.

### 4. Create a new project
```powershell
cd <WORKSPACE_ROOT>\Shared\Templates\Project-Template
.\New-Project.ps1 -Name MyTool -Purpose "one-line purpose"
```
The script:
1. copies the template to `<WORKSPACE_ROOT>\Projects\MyTool\` (stops if it already exists; never overwrites);
2. creates Junctions `.claude\skills\ana` and `hub` pointing to `<WORKSPACE_ROOT>\.claude\skills\`;
3. adds a row to `Projects\PROJECT-INDEX.md`;
4. runs `git init` (no commit; add `-NoGit` to skip).

Then open `Projects\MyTool` (or the whole workspace) in VS Code and let Claude Code read `README.md` and the root `CLAUDE.md`.

### 5. Rebuilding links (Junction / Symlink)
The workflow has exactly one kind of link: **each project's `.claude\skills\<skill>` → the workspace's `.claude\skills\<skill>`**. Links are not packaged (to avoid duplicating content), so rebuild them on a new computer or after cloning an existing product.

- Easiest: `.\New-Project.ps1 -Name <existing project folder> -LinksOnly`
- Manual (PowerShell, no administrator rights needed):
  ```powershell
  New-Item -ItemType Directory -Force <WORKSPACE_ROOT>\Projects\<project>\.claude\skills | Out-Null
  New-Item -ItemType Junction -Path <WORKSPACE_ROOT>\Projects\<project>\.claude\skills\ana -Target <WORKSPACE_ROOT>\.claude\skills\ana
  New-Item -ItemType Junction -Path <WORKSPACE_ROOT>\Projects\<project>\.claude\skills\hub -Target <WORKSPACE_ROOT>\.claude\skills\hub
  ```
- Manual (cmd): `mklink /J "<link path>" "<target path>"`
- Symlinks instead: `New-Item -ItemType SymbolicLink` needs Developer Mode or administrator rights; on macOS/Linux use `ln -s <target> <link>`.
- Each project's `.gitignore` (the template includes this) must ignore `.claude/skills/`, otherwise Git treats the linked content as product files.

Agents (PO/Engineer/QA) need no links: they live in the workspace's `.claude\agents\` and `Projects\CLAUDE.md` references them by relative path.

### 6. Verify after restoring
- The root has `CLAUDE.md`, `.claude\agents\{po,engineer,qa}.md`, `.claude\skills\{ana,hub}\SKILL.md`.
- Every file listed in `Shared\Tech\README.md` exists; the relative links in `Projects\CLAUDE.md` (`..\CLAUDE.md`, `..\.claude\`, `..\Shared\Tech\README.md`) open.
- Starting Claude Code in a project folder recognizes `/ana` and `/hub`; if not, follow `Projects\CLAUDE.md` and read the `SKILL.md` directly.

### 7. Manual setup (not in the package)
- Claude Code sign-in; Git user name and email.
- Each project's `.claude\settings.json` permissions, for example denying edits to the folders that hold real data (the template's `deny` list is empty; add your own paths).
- User-level settings and Claude's auto-memory live in your user profile and are **not** included.
- Each product's dependencies, databases, test data, and any network-drive access.

### 8. Known limitations
- Verified on a single environment (Windows 11); macOS/Linux need adjustment (the script is PowerShell).
- Measurements in `Shared/Tech` hold only in the environment each note states.
- How Skills are auto-discovered may differ between Claude Code versions; for a product with its own Git repository, the Junction is what makes them discoverable.

---

## 繁體中文

本套件**只含 AI 研發工作流**（L0 規範、Agent、Skill、知識文件、專案共用說明、新專案範本）。**不含**任何產品程式與資料、API Key／Token／密碼，也**不含 Hooks**（原工作流沒有使用）。

下文的 `<WORKSPACE_ROOT>` 是你要放工作區的資料夾；任何位置皆可，不需與原電腦相同。

### 1. 需要的工具
- Windows 10／11、PowerShell 5.1 以上（內建即可；PowerShell 7 也可）。
- Git（建議；腳本只會 `git init`，不會 commit）。
- Claude Code（VS Code 擴充或 CLI），自行登入帳號。

### 2. 還原工作流
1. 選定上一層資料夾 `<PARENT>`。
2. 解壓縮 Workflow ZIP：
   ```powershell
   Expand-Archive -Path .\Personal-RD-Workspace-Workflow-v3.1.0.zip -DestinationPath <PARENT>
   ```
   會得到 `<PARENT>\Personal-RD-Workspace\`（即 `<WORKSPACE_ROOT>`）。
3. （建議）核對完整性：`docs\MANIFEST.txt` 列出每個檔案的 SHA-256 與大小；Release 頁面另有 ZIP 本身的 `SHA256SUMS.txt`。
4. （可選）在 `<WORKSPACE_ROOT>` 執行 `git init`。內附 `.gitignore` 不追蹤各產品資料夾，只追蹤 `Projects\PROJECT-INDEX.md`。
5. **還原到已有內容的工作區時不要直接覆蓋**：先比較差異，再增量合併（保留既有專案、Git 歷史、自訂規則）。

### 3. 環境變數
不需要任何環境變數。唯一可選的：

| 變數 | 用途 | 預設 |
|---|---|---|
| `RD_WORKSPACE` | 讓 `New-Project.ps1` 不必每次指定 `-Workspace` | 腳本位於 `<WORKSPACE_ROOT>\Shared\Templates\Project-Template\` 時自動推算上三層 |

```powershell
[Environment]::SetEnvironmentVariable('RD_WORKSPACE', '<WORKSPACE_ROOT>', 'User')   # 重開終端機生效
```
各產品自己的環境變數（資料目錄、密碼等）屬於產品，不要寫進工作流。

### 4. 建立新專案
```powershell
cd <WORKSPACE_ROOT>\Shared\Templates\Project-Template
.\New-Project.ps1 -Name MyTool -Purpose "一句話用途"
```
腳本會：
1. 在 `<WORKSPACE_ROOT>\Projects\MyTool\` 複製範本（已存在則停止，不覆蓋）；
2. 建立 `.claude\skills\ana`、`hub` 的 Junction，指向 `<WORKSPACE_ROOT>\.claude\skills\`；
3. 在 `Projects\PROJECT-INDEX.md` 補一列；
4. `git init`（不 commit；不想要加 `-NoGit`）。

之後用 VS Code 開啟 `Projects\MyTool`（或整個工作區），讓 Claude Code 讀 `README.md` 與根目錄 `CLAUDE.md`。

### 5. 連結（Junction／Symlink）重建
工作流只有一種連結：**每個專案的 `.claude\skills\<skill>` → 工作區根目錄的 `.claude\skills\<skill>`**。連結不會被打包（避免重複內容），在新電腦或 clone 既有產品後要重建。

- 最簡單：`.\New-Project.ps1 -Name <既有專案資料夾名稱> -LinksOnly`
- 手動（PowerShell，不需系統管理員）：
  ```powershell
  New-Item -ItemType Directory -Force <WORKSPACE_ROOT>\Projects\<專案>\.claude\skills | Out-Null
  New-Item -ItemType Junction -Path <WORKSPACE_ROOT>\Projects\<專案>\.claude\skills\ana -Target <WORKSPACE_ROOT>\.claude\skills\ana
  New-Item -ItemType Junction -Path <WORKSPACE_ROOT>\Projects\<專案>\.claude\skills\hub -Target <WORKSPACE_ROOT>\.claude\skills\hub
  ```
- 手動（cmd）：`mklink /J "<連結路徑>" "<目標路徑>"`
- 符號連結替代：`New-Item -ItemType SymbolicLink` 需要開發人員模式或系統管理員權限；macOS／Linux 用 `ln -s <目標> <連結>`。
- 專案的 `.gitignore`（範本已含）要忽略 `.claude/skills/`，否則 Git 會把連結內容當成產品檔案。

Agent（PO／Engineer／QA）不需要連結：它們在工作區根目錄的 `.claude\agents\`，`Projects\CLAUDE.md` 以相對路徑引用。

### 6. 還原後驗證
- 根目錄有 `CLAUDE.md`、`.claude\agents\{po,engineer,qa}.md`、`.claude\skills\{ana,hub}\SKILL.md`。
- `Shared\Tech\README.md` 列出的文件都存在；`Projects\CLAUDE.md` 的相對連結（`..\CLAUDE.md`、`..\.claude\`、`..\Shared\Tech\README.md`）能開啟。
- 在專案資料夾啟動 Claude Code，輸入 `/ana`、`/hub` 能被辨識；不能時，依 `Projects\CLAUDE.md` 的說明直接讀 `SKILL.md`。

### 7. 必須人工設定的項目（不在套件內）
- Claude Code 帳號登入、Git 使用者名稱與電子郵件。
- 各專案 `.claude\settings.json` 的權限限制，例如禁止修改真實資料所在的資料夾（範本的 `deny` 清單是空的，請加入自己的路徑）。
- 使用者層設定與 Claude 的自動記憶位於使用者目錄，**不在**套件內。
- 各產品的相依套件、資料庫、測試素材與網路磁碟連線。

### 8. 已知限制
- 僅在單一環境（Windows 11）驗證；macOS／Linux 需調整（腳本為 PowerShell）。
- `Shared/Tech` 內的實測數據只在各文件標註的環境成立。
- Skill 的自動發現行為可能因 Claude Code 版本而異；產品有自己的 Git 時，靠 Junction 才會被發現。
