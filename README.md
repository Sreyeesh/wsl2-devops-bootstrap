# WSL2 DevOps Bootstrap

A minimal Ansible-based bootstrap for WSL2 that installs baseline Linux tooling,
configures Git defaults, adds developer tools, sets up Neovim, configures Zsh + Oh My Zsh, and sets up a simple shell path. Includes a lightweight
healthcheck script to verify the essentials.

## Requirements

- WSL2 (Ubuntu or Debian-based distro)
- Python 3
- Ansible (installed locally)

## Quick Start

1) Install Ansible if you do not already have it:

```bash
python3 -m pip install --user ansible
```

2) Run the playbook:

```bash
ansible-playbook ansible/playbooks/wsl.yml
```

3) Run the healthcheck:

```bash
python3 scripts/wsl_healthcheck.py
```

## What It Does

- Installs baseline packages (git, curl, build tools, python3, pipx, rg, fd-find, fzf, etc.)
- Sets global Git defaults (user.name, user.email, default branch)
- Ensures `~/bin` exists and is on PATH for bash
- Installs Node.js, npm, and the tree-sitter CLI
- Installs Neovim, adds a starter config, and sets `EDITOR`/`VISUAL`
- Installs Zsh, Oh My Zsh, and powerlevel10k

## Project Layout

- `ansible/playbooks/wsl.yml` : entrypoint playbook
- `ansible/roles/common` : baseline packages
- `ansible/roles/git` : Git defaults
- `ansible/roles/shell` : shell path setup
- `ansible/roles/devtools` : developer tools (nodejs, npm, tree-sitter-cli)
- `ansible/roles/neovim` : Neovim install and config
- `ansible/roles/zsh` : Zsh + Oh My Zsh + powerlevel10k
- `scripts/wsl_healthcheck.py` : tool availability checks

## Notes

- Inventory is local-only: `ansible/inventory/localhost.ini`.

## Backlog

See `BACKLOG.md` for planned work.
