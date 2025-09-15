**Commands**
- **Format**: Use `stylua` for Lua (`stylua .`) and `shfmt` for shell (`shfmt -w bin/`); format single file with `stylua <file.lua>` or `shfmt -w <file>`.
- **Lint**: Use `luacheck .` for Lua and `shellcheck bin/*` for shell scripts.
- **Syntax check**: Shell: `bash -n bin/<script>` or `zsh -n bin/<script>`; Lua: `luac -p <file.lua>`.
- **Run single test**: There are no tests here; example single-test commands if added: Python: `pytest tests/test_file.py::test_name`, Lua/busted: `busted -g 'pattern' spec/file_spec.lua`.
- **Run all tests**: Use language runner (e.g., `pytest`, `busted`, `go test`, `cargo test`) in repo root.
**Style**
- **Lua**: Use `local` for variables/functions, prefer `snake_case`, avoid globals; export modules via `return {}`.
- **Lua imports**: Use `local mod = require("mod")`; guard optional imports with `pcall(require, "mod")`.
- **Lua formatting**: Run `stylua`; editor uses `conform`/`stylua` via Neovim for on-save formatting.
- **Shell**: Start scripts with a shebang like `#!/usr/bin/env bash` or `#!/bin/zsh` and `set -euo pipefail`; quote variables and use `command -v` to check binaries.
- **Shell style**: Use lowercase with underscores for variables, prefer functions for complex logic, keep scripts POSIX-compatible where possible.
- **Naming**: Prefer lowercase file names with hyphens; use `snake_case` for functions/vars; keep plugin/config filenames descriptive.
- **Error handling**: Lua: check returns, use `pcall` and `vim.notify(..., vim.log.levels.ERROR)` for user errors; Shell: fail-fast and handle expected failures explicitly.
- **Types & annotations**: Add `---@param`/`---@return` EmmyLua annotations for public APIs to help LSP.
- **Imports & side-effects**: Require modules at top, avoid heavy top-level side-effects; wrap bootstrapping in guarded blocks.
- **Secrets**: Never commit credentials or private keys; add local overrides to `.gitignore`.
**Cursor/Copilot**
- **Cursor rules**: No rules found in `.cursor/rules/` or `.cursorrules`.
- **Copilot**: No `.github/copilot-instructions.md` found; repository uses `zbirenbaum/copilot.lua` plugin only.
