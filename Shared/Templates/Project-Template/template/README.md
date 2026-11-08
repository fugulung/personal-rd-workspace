# {{NAME}}

- 用途：{{PURPOSE}}
- 主要功能：
- 平台與限制：
- 真實資料／權限注意事項：

## 工作方式（L1 入口）
- 開發遵循上層 `Projects/CLAUDE.md` 與根目錄 `CLAUDE.md`；PO、Engineer、QA 在上層 `.claude/agents/`，`/ana`、`/hub` 透過本專案 `.claude/skills/` 的連結使用（連結遺失時執行 `New-Project.ps1 -Name {{NAME}} -LinksOnly` 重建）。
- 產品專屬的已驗證知識、決定與待辦寫在 `docs/KNOWLEDGE.md`；跨產品可重用的知識才放上層 `Shared/Tech/`。
- 專屬的設定與權限限制放在 `.claude/settings.json`（例如禁止修改真實資料所在的資料夾）。
- 建立日期：{{DATE}}
