---
type: concept
created: 2026-06-24
updated: 2026-06-24
sources: [conversations.md, github-branch-protection-record.md]
tags: [git, devops, team]
---

# GitHub Branch Protection

團隊 Git 分支保護規則的設定與實踐。

## Common_Client_Settings — Prod 分支

| 規則 | 值 |
|------|-----|
| 必須透過 PR | ✅ |
| 需 1 人 approve | ✅ |
| 過期 review 撤銷 | ✅ |
| 管理員受約束 | ✅ |
| 可合併團隊 | ACD_RD4_GameTeam_Client、ACD_RD4_Acewin_Client |
| Force push | ❌ |
| 刪除分支 | ❌ |

## 注意事項

- 目前任何有 read 權限的人的 approve 都算數
- 若需限制「只有特定團隊 approve 才有效」→ 設 CODEOWNERS + require_code_owner_reviews
- 使用的是舊版 Branch Protection Rules（非 Rulesets）

## 相關

- [[Kiro-CLI]]
