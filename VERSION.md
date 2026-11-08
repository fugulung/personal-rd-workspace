# VERSION

| | |
|---|---|
| Release / 發佈版本 | **v3.1.0**（Personal-RD-Workspace Mini V3.1，Claude Code edition） |
| Build date / 建立日期 | 2026-11-09 |
| Type / 類型 | Portable workflow + new-project template / 可攜式工作流與新專案範本 |
| Files in the Workflow ZIP / 檔案數 | 35（SHA-256：`docs/MANIFEST.txt`） |
| Hooks | None / 無 |

## Required tools / 必要工具

| Tool | Requirement | Verified with / 驗證版本 |
|---|---|---|
| Windows | 10 / 11（Junction 為 NTFS 功能） | Windows 11 Pro |
| PowerShell | 5.1+ | 5.1 and 7.x |
| Git | Recommended / 建議 | 2.44 |
| Claude Code | VS Code extension or CLI; sign in yourself / 自行登入 | version not recorded / 版本未記錄 |

## Dependencies / 相依條件
Skills and rules reference each other by **relative paths only**. Projects must live in `Projects/<name>/`; each project's `.claude/skills/*` is a Junction to the root `.claude/skills/*` (see `docs/SETUP.md`).
Skill 與規範只用**相對路徑**互相引用；產品專案必須放在 `Projects/<名稱>/`，其 `.claude/skills/*` 以 Junction 指向根目錄的 `.claude/skills/*`。

## Compatibility / 相容性
Same directory structure as Mini V3.1. When restoring into an existing workspace, merge incrementally; do not overwrite.
目錄結構與 Mini V3.1 相同；還原到已有內容的工作區時請增量合併，不要覆蓋。

## Excluded on purpose / 刻意排除
Product code and data, user/host identifiers, secrets, caches/logs/temp files, Git history, Junction contents, user-level settings and auto-memory.
產品程式與資料、使用者／主機識別、機密、快取／Log／暫存、Git 歷史、Junction 實體內容、使用者層設定與自動記憶。
