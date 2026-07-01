# Repository Guidelines

## Project Structure & Module Organization

This repository is a Neovim configuration written primarily in Lua. The entry point is `init.lua`, which loads configuration modules from `lua/config/`. Plugin specifications live in grouped directories under `lua/plugins/`, including `coding/`, `editor/`, `git/`, `ui/`, and `languages/`; disabled or parked plugin configs are kept under `lua/plugins/disabled/` for reference. Custom local functionality belongs in `lua/custom-utilities/`, grouped by feature, for example `lua/custom-utilities/smart-close/`. The plugin lockfile is `lazy-lock.json`. There is currently no dedicated `tests/` directory or asset pipeline.

## Build, Test, and Development Commands

- `stylua .`: format all Lua files.
- `stylua lua/plugins/coding/lsp.lua`: format one Lua file while editing.
- `luacheck .`: lint Lua sources for common issues.
- `luac -p init.lua`: syntax-check a Lua file without executing it.
- `nvim --headless "+Lazy! sync" +qa`: install or update plugins through lazy.nvim in headless mode.

There is no build step for this repository. Validate changes by formatting, linting, and starting Neovim with this config.

## Coding Style & Naming Conventions

Use Lua locals for variables and helper functions. Prefer `snake_case` for variables and functions, and lowercase descriptive filenames such as `render-markdown.lua` or `smart-close`. Import modules with `local mod = require("mod")`; guard optional dependencies with `pcall(require, "mod")`. Keep plugin modules small and focused: one plugin family or feature per file. Export reusable modules with `return {}` and avoid heavy top-level side effects outside bootstrapping files.

## Testing Guidelines

No automated test suite is currently present. For behavior changes, use targeted syntax checks such as `luac -p lua/config/options.lua`, then open Neovim and exercise the affected plugin or keymap. If tests are added later, place them in `tests/` or `spec/` and document the runner command here.

## Commit & Pull Request Guidelines

Recent commits use short, imperative summaries such as `fix small bugs and docs` or `refactoring`. Keep commit subjects concise and focused on one change. Pull requests should include a brief description, the reason for the change, manual validation steps, and screenshots only when UI-facing behavior changes.

## Security & Configuration Tips

Do not commit credentials, private keys, machine-local paths, or API tokens. Keep local overrides outside tracked files or add them to `.gitignore` before use.
