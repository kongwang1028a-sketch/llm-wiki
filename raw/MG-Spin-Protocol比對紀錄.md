# MG-Spin-Protocol 假資料 vs 雅典娜Protocol.xlsx 比對紀錄

日期: 2026-06-24

## 檔案位置
- MG-Spin-Protocol: `D:\Kiro\a\MG-Spin-Protocol\`
- 雅典娜Protocol: `D:\Kiro\a\雅典娜假封包範例\雅典娜Protocol.xlsx`

## 比對結果：MG-Spin-Protocol vs 雅典娜Protocol.xlsx

**所有 7 個假資料檔案結構完全符合 spin 封包規格 ✅**

| 檔案 | win_type | this_win | feature_wheels 步驟 |
|------|----------|----------|-------------------|
| combo0_no_win | 0 | 0 | 無 |
| combo1 | 2 | 250 | combo_info |
| combo2 | 2 | 650 | combo_info |
| combo3_lasso | 2 | 6,300 | trans_symbol → trans_multi → combo_info |
| combo6_lasso_shield | 2 | 13,650 | trans_symbol → trans_multi → combo_info |
| combo6_shield_rewin3_to9 | 2 | 79,200 | trans_symbol → trans_multi → spray_multi → combo_info |
| combo9_all_mechanics | 2 | 62,700 | trans_symbol → trans_multi → spray_multi → combo_info |

---

## 比對結果：MG-Spin-Protocol vs 其他遊戲 spin 封包

### 主要差異

1. **❌ 外層封裝不同** — 其他遊戲多包了 `cmd_data` + `cmd_sn`，MG 直接是 `{ Code, result, ts, data }`
2. **⚠️ `current_lines` vs `current_costs`** — 命名不一致
3. **⚠️ `game_state` 缺少欄位** — 其他遊戲省略了 `current_sg_id` 和 `current_lines`
4. **⚠️ `balance` 類型** — MG 用 int，其他遊戲用 float
5. **⚠️ `asset` 類型** — MG 用空字串，其他遊戲用 list<dict>
6. **⚠️ 其他遊戲多了** `gte_max_win`, `ProbId`, `ProbGroupName`, `IsChanceFromDb`
7. **⚠️ `combo_info` 內欄位排列順序不同**（JSON無序，但需留意）

### extra_info 差異（各遊戲自訂，屬正常）
- 雅典娜: `multi` (list<int>)
- 其他遊戲: `mystery_symbol`, `scatter_win`, `bomb_multi`, `Collect`
