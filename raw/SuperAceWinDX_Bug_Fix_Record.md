# SuperAceWinDX Symbol 消失 Bug 修復紀錄

## 日期：2026-06-24

## 專案路徑
`C:\Users\kongwang\Documents\CocosCreator\IGS-ARCADE-DIVISION-RD4-SLOT\Slot_Client_SuperAceWinDX`

---

## Bug 1：Golden Symbol Opacity 未恢復

### 症狀
- Spin 過程中偶發某一格 Symbol 消失
- 消失後每次 Spin 該格都是空的
- 只有黃金 Symbol 落入時 Prefab 動畫會播放，但播完又不見

### Root Cause
`Drop.ts` 的 `showCardBack()` 把 golden 格子的 `bingo_position` 設為 0 並呼叫 `symbol.hide()`。之前 `split()` 已把該格 opacity 設為 0。後續 `resetSymbol(dropVal)` 只恢復 `dropVal !== 0` 的格子，golden 格被跳過。`playFlop` → `setSymbol` 是 fire-and-forget async，在某些時序條件下 opacity 沒有被正確恢復。

### 修復
`assets/Game/Scripts/Drop.ts` — `showCardBack()` 中 `symbol.hide()` 前加入：
```typescript
symbol.node.getComponent(UIOpacity).opacity = 255;
```

### Commit
```
08f80d8 fix: golden symbol opacity stuck at 0 after showCardBack [Kiro Auto model/Chat mode]
```

---

## Bug 2：Opening 動畫中斷導致 Symbol 透明

### 症狀
- 開場動畫播放時玩家快速按 Spin
- 部分 Symbol 變透明消失

### Root Cause
`Openning.ts` 的 `showGameIntro()` 用兩層 tween：
- 外層：`tween<Node>(symbol.node)` 控制延遲和順序
- 內層：`tween<UIOpacity>(symbol.node.getComponent(UIOpacity))` 操作 opacity

`Stop()` 呼叫 `Tween.stopAllByTarget(symbol.node)` 只停了外層 tween。內層 UIOpacity tween（target 是 UIOpacity 組件）不受影響繼續執行，把 opacity 設為 0。而原本應恢復 opacity=255 的第二段 tween 因外層被停了永遠不會啟動。

另外 `setWheelActive(true)` 在 `stopAllByTarget` 之前呼叫，設完 255 後會被殘留的 UIOpacity tween 覆蓋回 0。

### 修復
`assets/Game/Scripts/Openning.ts` — `Stop()` 中：
1. 增加 `Tween.stopAllByTarget(symbol.node.getComponent(UIOpacity))` 停掉 UIOpacity tween
2. `setWheelActive(true)` 移到 stopAllByTarget 之後，確保最終狀態正確

```typescript
public Stop(): void {
    SlotGDK.instance.eventPlayBgm.remove(this.Show, this);
    SlotGDK.instance.eventSpin.remove(this.onSpin, this);
    this.spine.clearTracks();
    this.anim.stop();
    this.node.active = false;
    this.wheelBlockController.wheelAry.forEach((wheel, wheelIndex) => {
      wheel.symbolAry.forEach((symbol, symbolIndex) => {
        Tween.stopAllByTarget(symbol.node);
        Tween.stopAllByTarget(symbol.node.getComponent(UIOpacity));
      });
    });
    this.setWheelActive(true);
    SlotGDK.event(DropSymbolPrefab.ShowOffClipping).notify();
}
```

### Commit
```
62bad04 fix: opening animation interrupted leaves symbol opacity at 0 [Kiro Auto model/Chat mode]
```

---

## 關鍵知識

### Symbol 可見性控制
- `symbol.show()` / `symbol.hide()` → 控制 `node.active`
- `setOpacity(node, val)` → 控制 `UIOpacity.opacity`
- 兩者獨立，`node.active = true` 時若 `opacity = 0` 仍然看不見

### Drop 流程中 opacity 的生命週期
1. `setClearEffect` → `symbolBreath` → setOpacity(0)（透過 safeTween）
2. `split(bingo_position)` → setOpacity(0)（直接設定）
3. `showCardBack` → 可能修改 bingo_position 為 0
4. `drop(bingo_position)` → `resetSymbol(dropVal)` → 只恢復 `dropVal !== 0`
5. `playFlop` → `setSymbol` → opacity=255（fire-and-forget async）

### Tween Target 注意事項
- `Tween.stopAllByTarget(node)` 只停 target=node 的 tween
- `tween<UIOpacity>(comp)` 的 target 是 UIOpacity 組件，不是 node
- 要完整停止需兩次呼叫：stopAllByTarget(node) + stopAllByTarget(node.getComponent(UIOpacity))
