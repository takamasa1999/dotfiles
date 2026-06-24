use std::fs;
use std::io::{self, BufRead, Write};
use std::path::PathBuf;
use std::process::{Command, Stdio};

const FZF: &str = "/opt/homebrew/bin/fzf";
const CREATE_NEW: &str = "[+ New Session]";

fn session_dir() -> PathBuf {
    let home = std::env::var("HOME").expect("HOME not set");
    PathBuf::from(home).join("dotfiles/kitty/sessions")
}

fn list_sessions(dir: &PathBuf) -> Vec<String> {
    let mut sessions: Vec<String> = fs::read_dir(dir)
        .expect("Failed to read session directory")
        .filter_map(|e| e.ok())
        .filter_map(|e| {
            let name = e.file_name().to_string_lossy().into_owned();
            if name.ends_with(".kitty-session") {
                Some(name)
            } else {
                None
            }
        })
        .collect();
    sessions.sort();
    sessions
}

/// Run fzf with the given items. Returns (key_pressed, selected_item).
/// key_pressed is empty string on plain Enter.
fn run_fzf(items: &[String]) -> (String, String) {
    let input = items.join("\n");

    let mut child = Command::new(FZF)
        .args([
            "--prompt=Sessions> ",
            "--layout=reverse",
            "--border=rounded",
            "--height=40%",
            "--expect=ctrl-r,ctrl-d",
            "--header=enter:open  ctrl-r:rename  ctrl-d:delete",
        ])
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to launch fzf — is it installed at /opt/homebrew/bin/fzf?");

    // Write items to fzf stdin then close it
    if let Some(mut stdin) = child.stdin.take() {
        stdin.write_all(input.as_bytes()).ok();
    }

    let output = child.wait_with_output().expect("Failed to wait for fzf");

    let text = String::from_utf8_lossy(&output.stdout);
    let mut lines = text.lines();

    let key = lines.next().unwrap_or("").to_string();
    let target = lines.next().unwrap_or("").to_string();

    (key, target)
}

fn prompt(msg: &str) -> String {
    print!("{}", msg);
    io::stdout().flush().ok();
    let stdin = io::stdin();
    let mut line = String::new();
    stdin.lock().read_line(&mut line).ok();
    line.trim().to_string()
}

fn goto_session(dir: &PathBuf, session: &str) {
    let path = dir.join(session);
    let status = Command::new("kitten")
        .args(["@", "action", "goto_session", path.to_str().unwrap()])
        .status();
    if status.map(|s| !s.success()).unwrap_or(true) {
        eprintln!("Warning: goto_session failed for '{}'", session);
    }
}

fn create_session(dir: &PathBuf) {
    let name = prompt("New session name: ");
    if name.is_empty() {
        return;
    }
    let filename = format!("{}.kitty-session", name);
    let path = dir.join(&filename);
    if path.exists() {
        eprintln!("Session '{}' already exists.", filename);
        return;
    }
    fs::write(&path, "").expect("Failed to create session file");
    println!("Created '{}'", filename);
    goto_session(dir, &filename);
}

fn rename_session(dir: &PathBuf, session: &str) {
    let new_name = prompt(&format!("Rename '{}' to: ", session));
    if new_name.is_empty() {
        return;
    }
    let new_filename = format!("{}.kitty-session", new_name);
    let new_path = dir.join(&new_filename);
    if new_path.exists() {
        eprintln!("'{}' already exists.", new_filename);
        return;
    }

    let old_stem = session.trim_end_matches(".kitty-session");
    let old_path = dir.join(session);

    // 1. Save current session state to the old file so it can be restored under new name.
    Command::new("kitten")
        .args([
            "@", "action",
            "save_as_session",
            "--base-dir", dir.to_str().unwrap(),
            "--save-only",
            "--use-foreground-process",
            old_stem,
        ])
        .status()
        .ok();

    // 2. Rename the file on disk.
    fs::rename(&old_path, &new_path).expect("Failed to rename session file");

    // 3. Open the renamed session — kitty restores the saved tabs under the new name.
    goto_session(dir, &new_filename);

    // 4. Close all tabs still belonging to the old session name.
    Command::new("kitten")
        .args(["@", "close-tab", "--match", &format!("session:{}", old_stem)])
        .status()
        .ok();
}

fn delete_session(dir: &PathBuf, session: &str) {
    let confirm = prompt(&format!("Delete '{}'? [y/N]: ", session));
    if confirm.eq_ignore_ascii_case("y") {
        fs::remove_file(dir.join(session)).expect("Failed to delete session");
        println!("Deleted '{}'", session);
    }
}

fn main() {
    let dir = session_dir();

    loop {
        let sessions = list_sessions(&dir);
        let mut items = vec![CREATE_NEW.to_string()];
        items.extend(sessions);

        let (key, target) = run_fzf(&items);

        if target.is_empty() {
            break;
        }

        match key.as_str() {
            "ctrl-r" => {
                if target != CREATE_NEW {
                    rename_session(&dir, &target);
                }
                // Loop back to show the picker again
            }
            "ctrl-d" => {
                if target != CREATE_NEW {
                    delete_session(&dir, &target);
                }
                // Loop back
            }
            _ => {
                // Plain Enter
                if target == CREATE_NEW {
                    create_session(&dir);
                } else {
                    goto_session(&dir, &target);
                }
                break;
            }
        }
    }
}
