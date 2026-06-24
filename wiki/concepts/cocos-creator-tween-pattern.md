---
type: concept
created: 2026-06-24
updated: 2026-06-24
sources: [SuperAceWinDX_Bug_Fix_Record.md]
tags: [cocos-creator, animation, pattern]
---

# Cocos Creator Tween Pattern

Cocos Creator 中 Tween 動畫的陷阱與最佳實踐。

## 核心知識

### Tween Target 與 stopAllByTarget

`Tween.stopAllByTarget(target)` **只停止 target 完全匹配的 tween**。

```typescript
// 這兩個 tween 的 target 不同！
tween<Node>(symbol.node)          // target = node
tween<UIOpacity>(comp)            // target = UIOpacity 組件
```

停止所有相關動畫需兩次呼叫：
```typescript
Tween.stopAllByTarget(symbol.node);
Tween.stopAllByTarget(symbol.node.getComponent(UIOpacity));
```

### Symbol 可見性雙軌控制

| 機制 | 控制對象 | API |
|------|----------|-----|
| active | node 是否存在於渲染 | `symbol.show()` / `symbol.hide()` |
| opacity | 透明度 | `UIOpacity.opacity` |

兩者獨立：`active=true` + `opacity=0` → 看不見但佔空間。

### 常見 Bug 模式

1. **外層 tween 被停，內層繼續** — 巢狀 tween 用不同 target 時
2. **Fire-and-forget async 設值** — 時序不確定，可能被後續覆蓋
3. **恢復呼叫在停止之前** — `setWheelActive(true)` 後被殘留 tween 覆蓋

## 相關

- [[SuperAceWinDX]]
