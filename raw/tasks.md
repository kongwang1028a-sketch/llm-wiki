# Client_Activity_Highlight 工作進度

## 專案路徑
C:\Users\kongwang\Documents\CocosCreator\IGS-ARCADE-DIVISION-RD4-IG\Client_Activity_Highlight

## 已完成工作 (2026-06-17)

### 1. Task 盤點
- 對照 big-win-replay tasks.md 盤點所有實作完成度
- 核心功能 28/33 完成，4 部分完成，1 未完成
- 可選 property tests (fast-check) 全部 15 個未實作

### 2. 補完 Test Account Filtering (Task 11.5)
- `ListSorter.ts`: 新增 `isTestAccount?: boolean` 至 `TopWinItem`
- `ListSorter.ts`: 新增 `filterTestAccounts()` static method
- `TopWinsPanel.ts`: `renderCurrentTab()` 排序前先過濾 test accounts
- `ListSorter.test.ts`: 新增 3 個 unit tests

### 3. 補完 Share Event Reporting (Task 10.3)
- `ShareHandler.ts`: 新增 `ShareEventType`, `ShareEventData` 型別
- `ShareHandler.ts`: 新增 `onShareEventReport` callback
- `ShareHandler.ts`: `dispatchShareResultEvent()` 實作靜默失敗

### 4. Server 欄位驗證與修正
連線 Server: macross-gke-slot-test.squestjourneypro.com
- `C2S_SetFavorite.Action`: 修正 `'Add'|'Remove'` → `'set'|'remove'`
- `S2C_GetReplayDetail`: 新增 `NickName`, `ArkID`, `Currency` optional 欄位
- 新增 `GET_SUPERWIN_TOP_BOARD` 完整串接:
  - `C2S_GetTopBoard`, `S2C_GetTopBoard`, `TopBoardItem` interfaces
  - `HighlightSystemCommand` 新增 CMD
  - `HighlightSystem` 新增 Send/Receive
  - `HighlightNetworkModule` 新增 type export
- `TopWinsDimension` enum 值改為 `'score'|'odds'`（對應 Server OrderBy）
- `TopBoardItem.OriginBet` 改為 nullable

### 5. Panel 事件串接稽核
- 所有 4 個 Panel (HighlightPanel, TopWinsPanel, ForceOpenPanel, RecapView) 事件已正確串接
- ForceOpenPanel 按鈕事件依賴 Prefab inspector 綁定（非程式碼 addEventListener）— 潛在風險

## 測試狀態
- 78 tests, 6 suites, all passed

## 待處理
- ForceOpenPanel 可考慮加程式碼層 addEventListener 確保按鈕綁定
- 可選 property tests (fast-check) 尚未實作
- Task 3.4 (統一 API facade) — 影響不大，已用 HighlightSystem 直接呼叫
