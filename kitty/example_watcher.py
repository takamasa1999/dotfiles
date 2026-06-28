import re
import subprocess
from pathlib import Path
from typing import Any

from kitty.boss import Boss
from kitty.window import Window

sessions_dir = Path.home() / "dotfiles" / "kitty" / "sessions"


def session_file_name(session_name: str) -> str:
    path = Path(session_name)
    if path.suffix == ".kitty-session":
        return session_name
    return f"{session_name}.kitty-session"


def applescript_string(value: str) -> str:
    return '"' + value.replace("\\", "\\\\").replace('"', '\\"') + '"'


def notify(message: str) -> None:
    script = (
        f"display notification {applescript_string(message)} "
        f"with title {applescript_string('Kitty')}"
    )
    subprocess.Popen(["osascript", "-e", script])


def on_quit(boss: Boss, window: Window, data: dict[str, Any]) -> None:
    # on_quit is called before and after quit confirmation. Save before the
    # confirmation dialog is shown; the post-confirmation pass is too late for
    # reliable session snapshots.
    if data.get("confirmed") == False:
        return

    try:
        session_names = sorted(set(boss.all_loaded_session_names))

        for session_name in session_names:
            if not session_name:
                continue

            boss.save_as_session(
                "--base-dir",
                str(sessions_dir),
                f"--match=session:^{re.escape(session_name)}$",
                "--save-only",
                "--use-foreground-process",
                session_file_name(session_name),
            )

        notify("Saved all kitty sessions")
    except Exception as err:
        data["aborted"] = True
        notify(f"Failed to save kitty sessions: {err}")
