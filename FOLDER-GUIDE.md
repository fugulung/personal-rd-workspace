# Personal-RD-Workspace Mini｜資料夾指南

```text
Personal-RD-Workspace/
├── CLAUDE.md                 # 最上層準則
├── README.md / README.zh-TW.md
├── LICENSE
├── VERSION.md
├── FOLDER-GUIDE.md
├── docs/                     # SETUP、ARCHITECTURE、MANIFEST
│
├── .claude/
│   ├── agents/               # 共用 Agent
│   │   ├── po.md
│   │   ├── engineer.md
│   │   └── qa.md
│   └── skills/               # 共用 Skill
│       ├── ana/SKILL.md      # /ana 需求分析（已建立）
│       └── hub/SKILL.md      # /hub 開源技術研究（已建立）
│
├── Shared/
│   ├── Templates/            # 範本：Project-Template/（含 New-Project.ps1）
│   └── Tech/
│       ├── README.md
│       ├── References/       # 參考文件
│       ├── Solutions/        # 已驗證、可重用解法
│       └── Snippets/         # 程式片段
│
└── Projects/                 # 所有產品及實驗專案直接放這裡
    ├── CLAUDE.md             # 各專案共用說明
    ├── PROJECT-INDEX.md      # 專案總索引（實際專案清單以此為準）
    └── <專案名稱>/           # 各產品專案
```

- **不再區分 Products、Prototypes、Archive。** 所有專案直接放 `Projects/<專案名稱>/`。
- 各產品可獨立使用 Git，並保留自己的程式、測試、資源與文件結構。
- 已存在的產品不強制搬動內部資料夾；移植時先分析路徑、資料與設定風險。
- `Shared/Tech` 只保存跨產品可重用的技術資產，按需讀取以節省 Token。
- 此範本不包含任何既有產品程式、資料庫或備份。

## 索引入口
- `Projects/PROJECT-INDEX.md`：專案總索引（依實際專案維護）。
- `Shared/Tech/README.md`：共用技術索引；UX/UI 參考位於 `References/UX-UI/`。
- AI 指示只做導引，依任務讀取，避免每次全面掃描。
