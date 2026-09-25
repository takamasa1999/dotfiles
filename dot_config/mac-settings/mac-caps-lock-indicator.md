# macOS の CapsLock インジケータを無効化 / 有効化する

## 元ネタ

Reddit: [Oh No! Can I please turn off the new caps lock?](https://www.reddit.com/r/MacOS/comments/16vmjfc/oh_no_can_i_please_turn_off_the_new_caps_lock/)(r/MacOS)

chudsp87 さんのコメント(投稿当時から約3年前のもの)より引用:

> if you're still looking for a solution, here it is:
>
> 1. create directory `sudo mkdir -p /Library/Preferences/FeatureFlags/Domain`
> 2. create .plist file that disables ShittyNewArrowFeature `sudo /usr/libexec/PlistBuddy -c "Add 'redesigned_text_cursor:Enabled' bool false" /Library/Preferences/FeatureFlags/Domain/UIKit.plist`
> 3. reboot
>
> all together in a single command (will reboot immediately): ...

(最後の一行コマンドは、スクリーンショットで切れていたため省略。上の1〜3を順に実行すれば同じ。)

## 無効化する(インジケータを消す)

```bash
sudo mkdir -p /Library/Preferences/FeatureFlags/Domain
sudo /usr/libexec/PlistBuddy -c "Add 'redesigned_text_cursor:Enabled' bool false" /Library/Preferences/FeatureFlags/Domain/UIKit.plist
```

その後、**再起動**する。

`defaults` で書く場合も、結果は同じ。

```bash
sudo defaults write /Library/Preferences/FeatureFlags/Domain/UIKit.plist redesigned_text_cursor -dict-add Enabled -bool false
```

## 現在の状態を確認する

`/Library/Preferences/FeatureFlags/Domain/` は一般ユーザーでは中身が読めない(`Permission denied`)ので、`sudo` が必要。

```bash
sudo /usr/libexec/PlistBuddy -c "Print" /Library/Preferences/FeatureFlags/Domain/UIKit.plist
```

無効化されていると、次のように出る。

```
Dict {
    redesigned_text_cursor = Dict {
        Enabled = false
    }
}
```

## 有効に戻す(インジケータを再び出す)

ファイルに `redesigned_text_cursor` しか入っていなければ、ファイルごと消すのが一番確実。

```bash
sudo rm /Library/Preferences/FeatureFlags/Domain/UIKit.plist
```

他のキーも入っている場合は、そのキーだけ消す。

```bash
sudo /usr/libexec/PlistBuddy -c "Delete :redesigned_text_cursor" /Library/Preferences/FeatureFlags/Domain/UIKit.plist
```

消さずに `true` へ戻すだけでもよい。

```bash
sudo /usr/libexec/PlistBuddy -c "Set :redesigned_text_cursor:Enabled true" /Library/Preferences/FeatureFlags/Domain/UIKit.plist
```

その後、**再起動**する。

## メモ

- 非公式(undocumented)の feature flag。macOS のバージョンによって効かなくなる可能性がある。
- 2026-09-21、macOS 26.6.2 で `UIKit.plist` に上の `Enabled = false` が入っていることは確認した。ただし、Tahoe でこの flag が実際に効くかどうかまでは確認していない。
- 関連: 入力ソース切り替え時のインジケータは `InputMethod.plist` の `CapsuleIndicator` でも制御している(`mac-defaults.md` のセクション5)。
