---
type: entity
created: 2026-06-24
updated: 2026-06-24
sources: [conversations.md, my-agent-setup.md, 2026-06-15-工作紀錄.md]
tags: [tool, ai, telegram]
---

# My-Agent

本機工具型 Agent，提供 Web UI 和 Telegram Bot 介面。

## 基本資訊

- 位置：`C:\Users\kongwang\Tools\my-agent`
- 版本：1.0.3（2026-06-18 升級）
- 後端：Python（port 13801）
- 前端：Node.js（port 13301）
- Telegram：@IgsMoAssistantBot（長輪詢）
- Provider：kiro（kiro-cli with --trust-all-tools）

## 常用指令

```powershell
# 啟動
powershell -ExecutionPolicy Bypass -File "C:\Users\kongwang\Tools\my-agent\start.ps1"
# 停止
powershell -ExecutionPolicy Bypass -File "C:\Users\kongwang\Tools\my-agent\stop.ps1"
```

## 升級歷史

| 日期 | 版本 | 備註 |
|------|------|------|
| 06-15 | 1.0.0 | 初次安裝，清華鏡像裝 pip |
| 06-15 | 1.0.0 | 加入 --trust-all-tools、修復 WinError 206 |
| 06-18 | 1.0.3 | Expand-Archive 覆蓋升級 |

## 重要修復

- **WinError 206**：對話歷史超過 Windows 32K 命令列限制 → `_truncate_prompt()` 截斷
- **TG Bot 無法執行 shell**：kiro provider 加 `--trust-all-tools`
- **localhost 無法連線**：改用 `127.0.0.1:13301`

## 安全

- `allowed_users` 限制 Telegram 存取
- 未授權使用者靜默忽略

## 相關

- [[Kiro-CLI]]（作為 LLM provider）
- [[Telegram-TODO-Bot]]
