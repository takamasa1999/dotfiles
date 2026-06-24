#!/usr/bin/env bash
SESSION_DIR="$HOME/dotfiles/kitty/sessions"
cd "$SESSION_DIR" || exit

# fzfでセッションファイルを選択
TARGET=$(ls -1 | fzf --prompt="Manage Session> " --layout=reverse)
[ -z "$TARGET" ] && exit 0

echo "Selected: $TARGET"
echo "1) Rename  2) Delete  3) Cancel"
read -p "Select action [1-3]: " ACTION

case $ACTION in
1)
	read -p "New session name (without extension): " NEW_NAME
	[ -n "$NEW_NAME" ] && mv "$TARGET" "${NEW_NAME}.kitty-session"
	;;
2)
	rm "$TARGET"
	;;
*)
	exit 0
	;;
esac
