# macOS defaults 設定まとめ

`mac-defaults.bash` の内容から、このMacに適用した(する)設定をコマンド単位でまとめたもの。
値は「スクリプトに書かれている内容」であり、`defaults read` で実機の現在値を確認したものではない。

## 1. キーボード・ポインタ

| コマンド | 挙動 |
|---|---|
| `defaults write -g com.apple.keyboard.fnState -bool true` | F1〜F12 を標準のファンクションキーとして使う。メディアキー機能(輝度・音量など)は Fn を押しながら。 |
| `defaults write com.apple.HIToolbox AppleFnUsageType -int 0` | Fn(🌐)キーを押しても何も起きない(入力ソースの切り替えをしない)。反映にはログアウトが必要。 |
| `defaults write com.apple.universalaccess cursorFill -dict red 1 green 0 blue 0 alpha 1` | マウスポインタの塗りを赤にする。 |
| `defaults write com.apple.universalaccess cursorOutline -dict red 1 green 1 blue 1 alpha 1` | ポインタの輪郭を白にする。 |
| `defaults write com.apple.universalaccess cursorIsCustomized -bool true` | 上の塗り・輪郭の色設定を有効にする。 |
| `defaults write com.apple.universalaccess mouseDriverCursorSize -float 1.5` | ポインタサイズを標準の1.5倍にする。 |
| `defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 2` | 内蔵トラックパッドで3本指タップ = 「調べる/データ検出」。 |
| `defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -int 2` | Bluetooth トラックパッドでも同じく3本指タップ = 「調べる/データ検出」。 |

## 2. 外観・ウィンドウ管理

| コマンド | 挙動 |
|---|---|
| `defaults write com.apple.dock expose-group-apps -bool true` | Mission Control で「ウインドウをアプリケーションごとにグループ化」をオン。AeroSpace の推奨設定。 |
| `defaults write com.apple.spaces spans-displays -bool true` | 「ディスプレイごとに個別のSpaces」をオフ(Spaces が全ディスプレイにまたがる)。AeroSpace の推奨設定。 |
| `defaults write com.apple.dock autohide -bool true` | Dock を自動で隠す。 |
| `defaults write com.apple.dock autohide-delay -float 1000` | Dock が出るまでの待ち時間を1000秒にする。実質、マウスを画面端に置いても Dock は出てこない。 |
| `defaults write NSGlobalDomain _HIHideMenuBar -bool true` | メニューバーを常に隠す(カーソルを上端に持っていくと表示)。反映にはログアウトが必要な場合あり。 |
| `defaults write com.apple.universalaccess reduceTransparency -bool true` | 「透明度を下げる」をオン。 |
| `defaults write com.apple.universalaccess reduceMotion -bool true` | 「視差効果を減らす」をオン(アニメーションを抑える)。 |

## 3. Finder

| コマンド | 挙動 |
|---|---|
| `defaults write com.apple.finder FXDefaultSearchScope -string SCcf` | Finder の検索範囲の既定を「現在のフォルダ」にする(`SCcf` = Current Folder)。 |
| `defaults write com.apple.finder ShowPathbar -bool true` | Finder ウィンドウ下部にパスバーを表示する。 |

## 4. Kitty

| コマンド | 挙動 |
|---|---|
| `defaults write net.kovidgoyal.kitty SecureKeyboardEntry -bool false` | Kitty の Secure Keyboard Entry をオフ。Kitty にフォーカスがある間も AeroSpace のキー操作が効くようにするため。 |

## 5. OS全体の FeatureFlags(オプトイン)

`--system-feature-flags` を付けて実行したときだけ適用される。既定では**適用されない**。`sudo` が必要で、非公式のキーのため macOS のバージョンによって変わる/消える可能性がある。
以下の説明はキー名からの推測を含む。

| コマンド | 挙動 |
|---|---|
| `sudo defaults write /Library/Preferences/FeatureFlags/Domain/InputMethod.plist CapsuleIndicator -dict-add Enabled -bool false` | 入力ソース切り替え時のカプセル型インジケータを無効化する。 |
| `sudo defaults write /Library/Preferences/FeatureFlags/Domain/UIKit.plist redesigned_text_cursor -dict-add Enabled -bool false` | 再設計されたテキストカーソルを無効化し、従来の見た目に戻す。 |

### 元に戻す方法(CapsLock などのインジケータを再度有効にする)

`/Library/Preferences/FeatureFlags/Domain/` は一般ユーザーでは中身が読めない(`Permission denied`)。確認・削除には `sudo` が必要。

1. 現在の設定を確認する。

   ```bash
   sudo /usr/libexec/PlistBuddy -c "Print" /Library/Preferences/FeatureFlags/Domain/UIKit.plist
   sudo /usr/libexec/PlistBuddy -c "Print" /Library/Preferences/FeatureFlags/Domain/InputMethod.plist
   ```

2. そのファイルに無効化のキーしか入っていなければ、ファイルごと削除する(一番確実)。

   ```bash
   sudo rm /Library/Preferences/FeatureFlags/Domain/UIKit.plist
   sudo rm /Library/Preferences/FeatureFlags/Domain/InputMethod.plist
   ```

   他のキーも入っている場合は、該当キーだけ消す。

   ```bash
   sudo /usr/libexec/PlistBuddy -c "Delete :redesigned_text_cursor" /Library/Preferences/FeatureFlags/Domain/UIKit.plist
   sudo /usr/libexec/PlistBuddy -c "Delete :CapsuleIndicator" /Library/Preferences/FeatureFlags/Domain/InputMethod.plist
   ```

   消さずに有効へ戻すだけなら、`Set` を使う。

   ```bash
   sudo /usr/libexec/PlistBuddy -c "Set :redesigned_text_cursor:Enabled true" /Library/Preferences/FeatureFlags/Domain/UIKit.plist
   ```

3. **再起動**する。反映には再起動が必要。

実機での確認結果(2026-09-21、macOS 26.6.2):

- `UIKit.plist` には `redesigned_text_cursor = Dict { Enabled = false }` だけが入っていた。このスクリプトで適用されていたことを確認済み。
- `InputMethod.plist` は未確認。
- `defaults write kCFPreferencesAnyApplication TSMLanguageIndicatorEnabled 0` 系の古い設定は、この Mac には存在しなかった。

## 6. 適用後の再起動

設定を書き込んだ後、次のプロセスが起動していれば `killall` で再起動する。

- `cfprefsd` — 設定キャッシュの再読み込み
- `Dock`
- `Finder`
- `SystemUIServer` — メニューバー関連

メニューバーと入力ソース関連(`_HIHideMenuBar`、`AppleFnUsageType`)は、ログアウトまたは再起動で確実に反映される。

## 補足: スクリプトでエラーが出やすい箇所

- `com.apple.universalaccess` への書き込み(カーソル色・サイズ、透明度、視差効果)は、新しい macOS では、ターミナルにフルディスクアクセスを与えていないと失敗することがある。
- スクリプトが `set -Eeuo pipefail` なので、どれか1つが失敗するとそこで全体が止まり、以降の設定が適用されない。
- 実機で反映済みか確認するには、たとえば `defaults read com.apple.dock autohide` のように各キーを読む。
