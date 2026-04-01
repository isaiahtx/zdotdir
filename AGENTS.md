# Agents

## Portability

This zsh configuration is designed to be usable and reproducible across machines and environments (Arch, Debian/Ubuntu, macOS, WSL and non-WSL).

- **No unconditional hardcodes.** Do not hardcode usernames, UIDs, specific tool versions, or paths that assume a single install layout. Use `$HOME`, `$UID`/`$(id -u)`, version-probing globs, and XDG variables with fallbacks.
- **Gate machine-specific behavior.** If something truly must be hardcoded for a specific machine or environment, gate it behind an explicit check (e.g., `grep -qi 'microsoft' /proc/version` for WSL, OS detection via `/etc/os-release`, `uname -s` for macOS).
- **Respect existing environment.** Never unconditionally overwrite variables like `NVM_DIR` or `BROWSER` that may already be set by the environment or a parent shell. Use `${VAR:-default}` patterns.
- **Probe before sourcing.** When loading optional tools (nvm, pyenv, fzf, etc.), check that the relevant files exist before sourcing. Prefer fallback chains over single-path assumptions.
