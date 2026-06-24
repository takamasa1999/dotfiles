Done. Here's what was added and why each binding was chosen:

| Key           | Action                  | Notes                                                                                                                                                               |
| ------------- | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `cmd+shift+o` | `goto_session` (picker) | **O**pen — shows interactive menu of all `.kitty-session` files in `~/dotfiles/kitty/sessions/`                                                                     |
| `cmd+shift+s` | `save_as_session`       | **S**ave current layout + running programs (requires shell integration for `--use-foreground-process`); `--relocatable` uses relative paths so the file is portable |
| `cmd+shift+x` | `close_session`         | Close/e**x**it current session                                                                                                                                      |
| `cmd+t`       | `new_tab_with_cwd`      | Replaces default new tab — new tab opens in the same directory (session-aware)                                                                                      |
| `cmd+n`       | `new_window_with_cwd`   | **N**ew window in same directory                                                                                                                                    |

**To create your first session:** arrange your tabs/windows, then press `cmd+shift+s`. Kitty will open an editor with the generated `.kitty-session` file — save it into `~/dotfiles/kitty/sessions/`. Next time, `cmd+shift+o` brings up the picker to restore it.
