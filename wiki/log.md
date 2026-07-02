---
type: log
---

# Wiki Log

操作日誌，按時間倒序排列。

## [2026-06-24] session | 對話紀錄

- 建立 LLM Wiki 系統（基於 Karpathy Gist）
- 初始化 git + push 到 GitHub
- 批次攝入 12 份 D:\Kiro 紀錄檔
- 建立 6 entity + 3 concept 頁面
- 設定 kiro-memory 確保跨 session 記憶

## [2026-06-24] ingest | 初始批次攝入 — 12 份原始紀錄

攝入 D:\Kiro 下所有 .md 紀錄檔（複製到 raw/），建立：
- 6 個 entity 頁面：Client_Activity_Highlight、SuperAceWinDX、BakeBombanza、Kiro-CLI、My-Agent、Telegram-TODO-Bot
- 3 個 concept 頁面：Cocos-Creator-Tween-Pattern、MG-Spin-Protocol、GitHub-Branch-Protection
- 更新 index.md

## [2026-06-24] init | 知識庫初始化

建立 LLM Wiki 知識庫系統，包含 SCHEMA.md、index.md、log.md。
基於 Karpathy 的 LLM Wiki 模式。

## [2026-06-25] session | 對話紀錄

- 電腦意外關機後恢復，查看 git log 與 wiki log 確認進度
- 專案最新 commit: d4fc2aa [新增] 新增按鈕（比 preferences 記錄的 11c6571 更新）
- 啟動 my-agent 服務（backend PID 7476, frontend PID 9068, bot PID 16260）
- 發現 Telegram Bot SSL 錯誤（CERTIFICATE_VERIFY_FAILED），未處理
- 網頁顯示的 WinError 206 為歷史訊息，非當前問題

## [2026-06-25] session | 對話紀錄（下午）

- 研四決定採購 Claude Team 方案（每人 25 USD），每人電腦需有本地 Agent
- 幫忙整理 Agent 回報問卷答案：
  - Q1: 202606
  - Q2: 自建/my-agent
  - Q3: 遊戲開發輔助/任務追蹤/Telegram Bot整合
  - Q4: 是
- 解說本地 Agent vs 雲端 CLI 工具（Kiro CLI）差異

## 2026-07-01 對話紀錄

### SuperWin Replay API 測試

- 執行 `test_superwin_replay.py`（Direct Command 模式，走 `/drtcmd`，不需 SSO 登入）
- Server: `https://macross-gke-slot-test.squestjourneypro.com`
- 前幾次測試 server 回 500（server 端暫時性問題），後來恢復正常
- **GET_SUPERWIN_REPLAY** ✅ 成功，回傳 96 筆 replay（ark_id=10013251, GameName=AltarRiches）
- **GET_SUPERWIN_REPLAY_DETAIL** 回 `not found`，因為腳本寫死的 GameNo 不在列表中
- 透過多種變體測試確認 500 是 server 端問題（簽章錯誤回 400、cmd_id 錯誤回 400，正常請求都回 500）
- 建議：腳本應改為自動從列表取第一筆 GameNo 來查 detail
- 提供了給 Server 人員的問題回報範本（已不需要，server 後來自行恢復）
