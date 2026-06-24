---
type: entity
created: 2026-06-24
updated: 2026-06-24
sources: [conversations.md, session-2026-06-23.md]
tags: [project, cocos-creator, game]
---

# BakeBombanza

Slot 遊戲專案。

## 專案路徑

`C:\Users\kongwang\Documents\CocosCreator\IGS-ARCADE-DIVISION-RD4-SLOT\Slot_Client_BakeBombanza`

## 工作紀錄

### Info 視窗禁止水平滾動（2026-06-23）

- 檔案：`gameInfo/public/app.css`
- 嘗試 1：改 `max-width` + `width: 90%` → 排版跑掉
- 最終解法：僅在 `#__next`、`body`、`main` 加 `overflow-x: hidden`
- Commit：`dd5bcb06`

## 相關

- [[SuperAceWinDX]]
