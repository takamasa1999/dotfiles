#!/usr/bin/env bash
SESSION_DIR="$HOME/dotfiles/kitty/sessions"
cd "$SESSION_DIR" || exit

# fzfでキー入力を検知（Enterは空文字、Ctrl-r、Ctrl-dを取得）
FZF_OUT=$( (echo "[Create New Session]"; ls -1) | /opt/homebrew/bin/fzf --prompt="Manage Session> " --layout=reverse --expect=ctrl-r,ctrl-d )

# 出力から押下されたキーと選択されたターゲットを分離
KEY=$(echo "$FZF_OUT" | head -n1)
TARGET=$(echo "$FZF_OUT" | tail -n+2)

# キャンセル（Esc等）時は終了
[ -z "$TARGET" ] && exit 0

# 新規セッションの作成と起動
if [ "$TARGET" = "[Create New Session]" ]; then
	read -p "New session name (without extension): " NEW_NAME
	[ -z "$NEW_NAME" ] && exit 0
	
	NEW_FILE="${NEW_NAME}.kitty-session"
	touch "$NEW_FILE"
	kitten @ action goto_session "$SESSION_DIR/$NEW_FILE"
	exit 0
fi

# 押下されたキーに基づくアクションの実行
case "$KEY" in
	ctrl-r)
		# リネーム
		read -p "Rename '$TARGET' to (without extension): " NEW_NAME
		[ -n "$NEW_NAME" ] && mv "$TARGET" "${NEW_NAME}.kitty-session"
		;;
	ctrl-d)
		# 削除の確認と実行
		read -p "Delete '$TARGET'? [y/N]: " CONFIRM
		case "$CONFIRM" in
			[yY]) rm "$TARGET" ;;
			*) exit 0 ;;
		esac
		;;
	*)
		# デフォルトアクション（Enter押下時）：セッションの起動
		kitten @ action goto_session "$SESSION_DIR/$TARGET"
		;;
esac
