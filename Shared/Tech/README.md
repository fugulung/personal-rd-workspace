# 共用技術索引｜Shared Tech

只保存跨專案可重用的知識，按需閱讀；不強制每次開發寫文件。

| 類別 | 用途 | 入口 |
|---|---|---|
| References | 技術與設計參考 | [`References/`](References/) |
| UX/UI | 使用性與介面設計原則 | [`ux-design-principles.md`](References/UX-UI/ux-design-principles.md) |
| Solutions | 經驗證、可重用的問題解法 | [`Solutions/`](Solutions/) |
| Snippets | 可重用程式片段 | [`Snippets/`](Snippets/) |

## 目前收錄

| 文件 | 類別 | 內容 |
|---|---|---|
| [`windows-job-object-child-process-lifecycle.md`](Solutions/windows-job-object-child-process-lifecycle.md) | Solutions | Windows 上讓子程序（如 ffmpeg）隨父程序結束，避免孤兒程序占用檔案與顯卡 |
| [`video-encoding-bottleneck-analysis.md`](References/video-encoding-bottleneck-analysis.md) | References | 影片編碼瓶頸的判斷方法與實測（數據僅限標註的測試環境） |
| [`nas-media-metadata-persistent-cache.md`](References/nas-media-metadata-persistent-cache.md) | References | NAS 上大量媒體分析的瓶頸（小量隨機讀取）與獨立 SQLite 持久化快取做法、失效規則與實測（僅限標註環境） |
| [`windows-headless-ui-test-pitfalls.md`](References/windows-headless-ui-test-pitfalls.md) | References | Windows 保留連接埠造成測試伺服器綁定失敗，以及 Edge headless 虛擬時間不等伺服器真實耗時的處理方式 |

新增、移動或刪除共用技術資料時，才更新此索引。
