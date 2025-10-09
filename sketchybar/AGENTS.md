# AGENTS — Automated agent instructions

Commands:
- Lint shell scripts: `shellcheck -x plugins/*.sh`
- Format scripts: `shfmt -w -i 2 -ci plugins/*.sh`
- Syntax check single file: `bash -n path/to/script.sh` or `zsh -n path/to/script.sh`
- Run a single script/test (manual): `./plugins/clock.sh` or `SKETCHYBAR_CONFIG_DIR=... ./plugins/clock.sh`
- Add tests for shells: use `bats-core`; run all: `bats tests/`; run single test: `bats --filter 'pattern' tests/file.bats`

Style guidelines:
- Shebang: set explicit `#!/usr/bin/env bash` or `#!/bin/sh` per file.
- Safety: in bash use `set -euo pipefail` and `IFS=$'\n\t'` at top.
- Formatting: run `shfmt` and respect 2-space indent and `-ci` case indent.
- Quoting: always quote expansions `"$var"` and use `"$@"` for args.
- Naming: UPPER_SNAKE for constants/env; snake_case for functions and variables; files lower-case with `.sh`.
- Imports: `source "$CONFIG_DIR/plugins/file"`; quote sourced paths; avoid global side-effects.
- Error handling: prefer exit codes, `||` fallback, and `printf ... >&2` for errors.
- Avoid non-portable constructs unless shebang declares bash/zsh; prefer POSIX where possible.

Notes: No `.cursor` rules or `.github/copilot-instructions.md` found in this repo.
