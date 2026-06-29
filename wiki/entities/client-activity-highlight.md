---
type: entity
created: 2026-06-24
updated: 2026-06-29
sources: [conversations.md, tasks.md, preferences.md, session-2026-06-12.md, reminder.md]
tags: [project, cocos-creator, game]
---

# Client_Activity_Highlight

Cocos Creator 3.8.8 專案，一鍵分享/精華回放功能模組。

## 專案路徑

`C:\Users\kongwang\Documents\CocosCreator\IGS-ARCADE-DIVISION-RD4-IG\Client_Activity_Highlight`

## 分支

- develop（最新 commit: 11c6571）

## 已完成功能

### UI 面板
- **TopWinsPanel**：WINS/MULTIPLIERS 分頁排行榜
- **HighlightPanel**：精華回放列表（日期/獎級/金額/倍率/Recap/Share/Fav）
- **ForceOpenPanel**：強制開啟面板
- **RecapView**：回放檢視

### 一鍵分享報獎分享圖
- `ShareRewardCard.ts`：自動建 Camera + RenderTexture 截圖
- 整合到 `HighlightPanel.onCellShareClick`

### BitmapFont
- `sharewin_num.fnt`：紅金色數字 size=304
- `sharewin_numblue.fnt`：藍色數字+x size=196

### 多語系
- 7 種語系 JSON（zh-tw, zh-cn, en-us, th-th, vi-vn, ms-my, es-es）
- CSV → `python convert.py` → JSON
- Label 掛 `UIMultiLang` 組件

### Info 彈窗
- 點 InfoButton 開啟，點任意位置關閉

### Server 串接
- `GET_SUPERWIN_TOP_BOARD` 完整串接
- `C2S_SetFavorite.Action`：`'set'|'remove'`
- `TopWinsDimension`：`'score'|'odds'`

## 測試

- 78 tests, 6 suites, all passed
- `HighlightAutoLoader`：Mock 測試載入器

## Bug 修復（2026-06-29）

### 收藏超過 5 個上限
- **根本原因**：依賴 Server 回傳的 `IsFavorite`（可能為 null/undefined），且有競態視窗
- **修法**：`FavoriteManager.ts` 改用本地 `Set<number>` 追蹤收藏狀態
  - 新增 `localFavoriteGameNos: Set<number>`
  - `addFavorite` 改用 `set.size >= 5` 判斷，立即 `set.add()`（樂觀更新）
  - `removeFavorite` 立即 `set.delete()`
  - `getFavoriteCount()` 回傳 `set.size`
  - `syncFavorites(replays)` 每次 GetReplay 回來後重建 Set

### 多語系 Label 顯示 key 名稱（HIGHLIGHTS_TITLE 等）
- **根本原因 1**：`UIMultiLang.ts` 只有 `key` 屬性，但 Prefab JSON 存的是 `langKey`，導致 `key` 永遠是空字串
- **根本原因 2**：`HighlightData.loadMultiLang` 只填 `HighlightData.multiLang`，但 `UIMultiLang` 讀的是 `window['GameTextDict']`，兩者是不同資料來源
- **修法**：
  - `UIMultiLang.ts`：新增 `@property langKey`，`onEnable` 改用 `this.key || this.langKey`
  - `HighlightData.ts`：`loadMultiLang` 載入後同時呼叫 `MultiLangHandler.addGameTextDict(dict)`

## 待辦

- [ ] 確認多語系修復生效（需在 Cocos 預覽確認 console 有 `[HighlightData] loadMultiLang OK`）
- [ ] 確認 CDN 路徑（gameIconUrl / vendorLogoUrl）
- [ ] 正式環境測試分享流程
- [ ] 分享截圖 Prefab（背景、Logo、QR Code）

## 相關

- [[Kiro-CLI]]（透過 cocos-mcp-server 建 UI）
- [[SuperAceWinDX]]
