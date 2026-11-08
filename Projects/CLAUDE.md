# Projects 共用說明

`Projects/` 下各專案隸屬於 `Personal-RD-Workspace`，為產品專案，各產品可獨立使用 Git。

- 開發時遵循上層 [`../CLAUDE.md`](../CLAUDE.md) 的共用準則。
- PO、Engineer、QA 優先參考上層 [`../.claude/agents/`](../.claude/agents/)；需求分析與技術研究使用上層 Skill `/ana`、`/hub`（[`../.claude/skills/`](../.claude/skills/)）。產品是獨立 Git，從產品目錄啟動時這些不一定被自動發現；不可用時直接讀對應的 `SKILL.md`／agent 檔，依其步驟執行。
- 共用技術資源依需求參考上層 [`../Shared/Tech/`](../Shared/Tech/README.md)。
- 知識收錄（結案知識閉環）細則以 [`../.claude/skills/ana/SKILL.md`](../.claude/skills/ana/SKILL.md) 的「結案知識閉環」為準；僅收錄已驗證且跨專案可重用的內容，不自動擴大。
- 專案專屬的設定與權限限制維持在各專案自己的 `.claude/settings.json`。
