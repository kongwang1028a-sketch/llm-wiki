---
type: concept
created: 2026-06-24
updated: 2026-06-24
sources: [MG-Spin-Protocol比對紀錄.md]
tags: [protocol, server, slot]
---

# MG Spin Protocol

Slot 遊戲的 MG（Main Game）Spin 封包規格。

## 結構

外層：`{ Code, result, ts, data }` — 注意：其他遊戲多包 `cmd_data` + `cmd_sn`

## feature_wheels 步驟組合

| 機制 | 步驟 |
|------|------|
| 基本 combo | `combo_info` |
| Lasso | `trans_symbol → trans_multi → combo_info` |
| Lasso + Shield | `trans_symbol → trans_multi → combo_info` |
| Shield + Rewin | `trans_symbol → trans_multi → spray_multi → combo_info` |
| 全機制 | `trans_symbol → trans_multi → spray_multi → combo_info` |

## 跨遊戲差異

- `current_lines` vs `current_costs`（命名不一致）
- `balance`：MG 用 int，其他用 float
- `asset`：MG 用空字串，其他用 list<dict>
- 其他遊戲多了 `gte_max_win`, `ProbId`, `ProbGroupName`, `IsChanceFromDb`
- `extra_info` 各遊戲自訂（正常）

## 相關

- [[Client_Activity_Highlight]]
