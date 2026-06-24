---
type: entity
created: 2026-06-24
updated: 2026-06-24
sources: [SuperAceWinDX_Bug_Fix_Record.md]
tags: [project, cocos-creator, game, bug-fix]
---

# SuperAceWinDX

Slot 遊戲專案，曾有 Symbol 消失 Bug。

## 專案路徑

`C:\Users\kongwang\Documents\CocosCreator\IGS-ARCADE-DIVISION-RD4-SLOT\Slot_Client_SuperAceWinDX`

## Bug 修復紀錄（2026-06-24）

### Bug 1：Golden Symbol Opacity 未恢復

- **症狀**：Spin 過程偶發某格 Symbol 永久消失
- **Root Cause**：`showCardBack()` 設 bingo_position=0 → `resetSymbol` 跳過 → opacity 留在 0
- **修復**：`symbol.hide()` 前加 `UIOpacity.opacity = 255`
- **Commit**：`08f80d8`

### Bug 2：Opening 動畫中斷導致透明

- **症狀**：開場動畫中快速按 Spin → Symbol 變透明
- **Root Cause**：`stopAllByTarget(node)` 不停 UIOpacity tween → opacity 被設為 0
- **修復**：增加 `stopAllByTarget(UIOpacity)` + 調整 `setWheelActive` 順序
- **Commit**：`62bad04`

## 關鍵知識

- `Tween.stopAllByTarget(node)` ≠ 停止所有相關 tween
- `tween<UIOpacity>(comp)` target 是組件不是 node
- 需兩次呼叫：`stopAllByTarget(node)` + `stopAllByTarget(node.getComponent(UIOpacity))`

## 相關

- [[Client_Activity_Highlight]]
- [[Cocos-Creator-Tween-Pattern]]
