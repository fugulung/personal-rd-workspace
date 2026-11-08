# Personal-RD-Workspace Mini

[English](README.md) | **繁體中文**

給個人開發者搭配 [Claude Code](https://claude.com/claude-code) 使用的極簡、可攜式 **AI 研發工作流**：共用規範、三位 Agent（PO／Engineer／QA）、兩個 Skill（`/ana` 需求分析、`/hub` 開源技術研究）、少量已驗證的知識庫，以及一行指令建立新專案的範本。

優先順序：**功能好用 → UI/UX 美觀直覺 → 基礎安全。**
定位為個人、非商用的效率工具研發。本套件**不含任何產品程式碼**與私人資料。

> 本專案與 Anthropic 無隸屬或背書關係。「Claude」、「Claude Code」為 Anthropic 的商標。

## 內容

| 項目 | 說明 |
|---|---|
| `CLAUDE.md` | 最上層工作準則（L0）：需要你同意的決策、QA 分級、未授權不 Commit／Push 或做破壞性操作、節省 Token 的習慣 |
| `.claude/agents/` | `po`、`engineer`、`qa` 精簡角色定義 |
| `.claude/skills/` | `/ana`（需求分析與技術分流）、`/hub`（開源技術研究） |
| `Projects/CLAUDE.md` | 所有產品專案共用的規範（L1） |
| `Shared/Tech/` | 索引與少量已驗證、可重用的技術文件（每份都標註測試環境） |
| `Shared/Templates/Project-Template/` | 新專案範本與 `New-Project.ps1` |
| `docs/` | `SETUP.md`（安裝、連結、建立專案）、`ARCHITECTURE.md`、`MANIFEST.txt`（每個檔案的 SHA-256） |

## 快速開始（Windows）

1. 從 Releases 下載 `Personal-RD-Workspace-Workflow-v3.1.0.zip`，解壓縮到你選的上層資料夾，會得到 `Personal-RD-Workspace/`。
2. 建立第一個專案：
   ```powershell
   cd Personal-RD-Workspace\Shared\Templates\Project-Template
   .\New-Project.ps1 -Name MyTool -Purpose "一句話用途"
   ```
3. 用 VS Code 開啟 `Projects\MyTool` 並啟動 Claude Code，它會讀根目錄 `CLAUDE.md` 與專案 `README.md`。

環境變數、在新電腦重建 Skill 連結等細節：[docs/SETUP.md](docs/SETUP.md)。結構與設計：[docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)。

## 需求

Windows 10／11、PowerShell 5.1 以上、Git（建議）、Claude Code（自行登入）。僅在 Windows 11 驗證；腳本是 PowerShell，macOS／Linux 需手動調整（見 SETUP）。

## 語言說明

Agent、Skill 與規範檔以**繁體中文**撰寫（作者的工作語言），為保留已驗證的行為而未更動；英文 README 與文件供快速理解。歡迎提供忠實的英文版本。

## 安全與隱私

- 套件由允許清單打包，並掃描過機密、主機／使用者識別、絕對路徑、IP／MAC、產品名稱與非必要檔案類型。
- 知識文件已去識別化，結論與測試環境標註不變；數據只在各文件標註的環境成立。
- 工作流在未經你授權時不會 Commit、Push 或執行破壞性指令；`New-Project.ps1` 最多只做 `git init`，不會 commit。

## 致謝

`Shared/Tech/References/UX-UI/ux-design-principles.md` 以 Jakob Nielsen 的十大易用性啟發式準則（Nielsen Norman Group）為架構，說明與範例為作者自己的文字。

## 授權

MIT。Copyright (c) 2026 Ryanlung。詳見 [LICENSE](LICENSE)。
