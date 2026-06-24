# GitHub Branch Protection 設定紀錄

**日期**: 2026-06-23
**倉庫**: https://github.com/IGS-ARCADE-DIVISION-RD4-GAME/Common_Client_Settings
**分支**: Prod

## 已設定的規則

| 規則 | 設定值 |
|------|--------|
| 禁止直接 push 到 Prod | ✅ 必須透過 PR |
| PR 至少需要 reviewer 批准數 | 1 |
| 過期的 review 自動撤銷 | ✅ |
| 管理員也受規則約束 | ✅ |
| 可合併到 Prod 的團隊 (restrictions) | ACD_RD4_GameTeam_Client、ACD_RD4_Acewin_Client |
| Bypass PR 審核的人 | 無（已清空） |
| Force push | ❌ 禁止 |
| 刪除分支 | ❌ 禁止 |

## 備註

- 目前任何有 read 權限的人的 approve 都算數（不限於指定的兩個團隊）
- 若要限制「只有特定團隊的 approve 才有效」，需設定 CODEOWNERS + 開啟 require_code_owner_reviews（尚未設定）
- Rulesets 可達到同等效果，但目前使用的是舊版 Branch Protection Rules
