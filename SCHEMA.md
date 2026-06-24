# LLM Wiki Schema

基於 Karpathy 的 LLM Wiki 模式建立的個人知識庫系統。

## 架構三層

```
raw/       ← 原始資料（不可變，LLM 只讀不寫）
wiki/      ← LLM 生成的維基頁面（LLM 全權維護）
SCHEMA.md  ← 本文件，定義結構與規則
```

## 目錄結構

```
llm-wiki/
├── SCHEMA.md              # 本文件：結構定義與操作規範
├── raw/                   # 原始資料（唯讀）
│   ├── assets/            # 圖片等附件
│   └── (你的原始資料檔案)
├── wiki/
│   ├── index.md           # 內容索引（按分類整理）
│   ├── log.md             # 操作日誌（按時間排列）
│   ├── overview.md        # 全局總覽與核心論點
│   ├── sources/           # 每個來源的摘要頁
│   ├── entities/          # 實體頁（人物、組織、工具等）
│   ├── concepts/          # 概念頁（主題、理論、模式等）
│   └── synthesis/         # 綜合分析頁（比較、結論等）
```

## 頁面格式

每個 wiki 頁面使用以下 YAML frontmatter：

```yaml
---
type: source | entity | concept | synthesis
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources: []        # 引用的原始資料
tags: []
---
```

正文使用 Markdown，使用 `[[wikilinks]]` 互相連結。

## 操作流程

### Ingest（攝入）

1. 使用者將原始資料放入 `raw/`
2. 告訴 LLM「請攝入 raw/xxx.md」
3. LLM 流程：
   - 閱讀原始資料
   - 與使用者討論重點
   - 在 `wiki/sources/` 建立摘要頁
   - 更新相關的 entity/concept 頁面
   - 更新 `wiki/index.md`
   - 在 `wiki/log.md` 記錄本次操作

### Query（查詢）

1. 使用者提問
2. LLM 先讀 `wiki/index.md` 找到相關頁面
3. 深入閱讀相關頁面後綜合回答
4. 有價值的回答可存入 `wiki/synthesis/` 作為新頁面

### Lint（健康檢查）

定期請 LLM 檢查：
- 頁面之間的矛盾
- 被新資料取代的舊結論
- 孤立頁面（無入站連結）
- 被提及但尚未建立的概念
- 缺失的交叉引用

## 規則

1. **raw/ 永遠不修改** — 這是事實來源
2. **wiki/ 完全由 LLM 維護** — 使用者只讀
3. **每次修改都記錄到 log.md**
4. **所有主張必須可追溯到 raw/ 來源**
5. **發現矛盾時明確標記，不要靜默覆蓋**
6. **使用 [[wikilinks]] 保持頁面互連**
