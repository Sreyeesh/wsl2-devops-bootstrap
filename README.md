# WSL2 DevOps Bootstrap

A minimal Ansible-based bootstrap for WSL2 that installs baseline Linux tooling,
configures Git defaults, and sets up a simple shell path. Includes a lightweight
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

## Project Layout

- `ansible/playbooks/wsl.yml` : entrypoint playbook
- `ansible/roles/common` : baseline packages
- `ansible/roles/git` : Git defaults
- `ansible/roles/shell` : shell path setup
- `scripts/wsl_healthcheck.py` : tool availability checks

## Notes

- The `ansible/roles/devtools` role is scaffolded for future optional tools.
- Inventory is local-only: `ansible/inventory/localhost.ini`.

## Backlog

See `BACKLOG.md` for planned work.
