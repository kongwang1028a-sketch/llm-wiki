---
type: entity
created: 2026-06-24
updated: 2026-06-24
sources: [conversations.md, 2026-06-15-工作紀錄.md, preferences.md]
tags: [tool, ai, environment]
---

# Kiro CLI

Kiro CLI 是使用者日常的 AI 程式助手，透過終端機互動。

## 基本資訊

- 可執行檔：`C:\Kiro-Cli\kiro-cli.exe`
- 正確啟動方式：`kiro-cli.exe chat --legacy-ui --trust-all-tools`（或 `-a`）
- 推薦啟動：`D:\Kiro\start-kiro-wt.bat`（Windows Terminal）
- 工作目錄：`D:\Kiro`

## 記憶系統

- agentSpawn hook 載入 `preferences.md`（全文）+ `conversations.md`（末 50 行）
- 對話結束時追加摘要到 `conversations.md`
- Agent 定義：`~/.kiro/agents/kiro_default.json`
- Hook：`~/.kiro/hooks/load-memory.ps1`

## MCP 設定

設定檔：`C:\Users\kongwang\.kiro\settings\mcp.json`

允許目錄：
1. `D:\Kiro`
2. `C:\Users\kongwang\Documents\CocosCreator`
3. `C:\Users\kongwang\telegram-todo-bot`
4. `C:\Users\kongwang\.kiro`
5. `C:\Users\kongwang\AppData\Local\Kiro-Cli`

MCP Servers：
- filesystem（@modelcontextprotocol/server-filesystem）
- kiro-memory（D:\Kiro\mcp-memory\server.mjs）

## 歷史問題與解法

| 問題 | 解法 |
|------|------|
| v2/TUI 工具不執行 | 用 `--legacy-ui --trust-all-tools` |
| ExecutionPolicy 阻擋 npx | `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser` |
| Kiro App 報 Cannot find module 'cli.js' | 重新安裝 Kiro |

## 相關

- [[My-Agent]]（使用 kiro provider）
- [[Client_Activity_Highlight]]（透過 cocos-mcp-server）
