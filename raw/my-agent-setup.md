# My Agent 設定記錄

## 位置
`C:\Users\kongwang\Tools\my-agent`

## 狀態
- 已安裝完成（Python 後端 + Node.js 前端）
- Python 依賴用清華鏡像安裝（原始 PyPI 超時）
- 服務已啟動（2026-06-15）

## 服務埠
| 服務 | 埠 |
|------|-----|
| 後端 API | 13801 |
| 前端 Web UI | 13301 |
| Telegram Bot | 長輪詢 |

## 常用指令
```powershell
# 啟動
powershell -ExecutionPolicy Bypass -File "C:\Users\kongwang\Tools\my-agent\start.ps1"
# 停止
powershell -ExecutionPolicy Bypass -File "C:\Users\kongwang\Tools\my-agent\stop.ps1"
```

## 注意事項
- Cursor 已安裝在 `C:\Users\kongwang\AppData\Local\Programs\cursor\`
- 但 `cursor-agent` CLI 不存在（Cursor 版本可能太舊或尚未包含）
- Kiro 不提供外部可呼叫的模型 API，不能當 my-agent 的供應商
- 建議用 Anthropic API key 或 OpenAI API key 作為 LLM 後端

## 後台設定頁
http://localhost:13301/admin.html
