# WSL2 DevOps Bootstrap

A minimal Ansible-based bootstrap for WSL2 that installs baseline Linux tooling,
configures Git defaults, adds developer tools, sets up Neovim, configures Zsh + Oh My Zsh, and sets up a simple shell path. Includes a lightweight
healthcheck script to verify the essentials.

## Requirements

- WSL2 (Ubuntu or Debian-based distro)
- Python 3
- Ansible (installed locally)

## Quick Start

1) Run the bootstrap script (installs Ansible if needed and runs the playbook):

```bash
./bootstrap.sh
```

2) Or install Ansible manually if you prefer:

```bash
python3 -m pip install --user ansible
```

3) Run the playbook:

```bash
ansible-playbook ansible/playbooks/wsl.yml
```

4) Run the healthcheck:

```bash
python3 scripts/wsl_healthcheck.py
```

## What It Does

- Installs baseline packages (git, curl, build tools, python3, pipx, rg, fd-find, fzf, etc.)
- Sets global Git defaults (user.name, user.email, default branch)
- Ensures `~/bin` exists and is on PATH for bash
- Installs Node.js, npm, and the tree-sitter CLI
- Optional devtools (terraform, kubectl, awscli, azure-cli) via role flags
- Installs Neovim, adds a starter config, and sets `EDITOR`/`VISUAL`
- Installs Zsh, Oh My Zsh, and powerlevel10k
- Hardens SSH client defaults and pins known_hosts entries

## Profiles

- Minimal (baseline packages + git + shell path):

```bash
ansible-playbook ansible/playbooks/wsl.yml --tags minimal
```

- Full (default):

```bash
ansible-playbook ansible/playbooks/wsl.yml
```

## Variables

- Optional devtools:

```bash
ansible-playbook ansible/playbooks/wsl.yml \
  -e devtools_install_terraform=true \
  -e devtools_install_kubectl=true \
  -e devtools_install_awscli=true \
  -e devtools_install_azure_cli=true
```

- SSH hardening:

```bash
ansible-playbook ansible/playbooks/wsl.yml \
  -e ssh_hardening_enable_client_config=true \
  -e 'ssh_hardening_known_hosts=[{"name":"github.com","key":"github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAA..."}]'
```

## Project Layout

- `ansible/playbooks/wsl.yml` : entrypoint playbook
- `ansible/roles/common` : baseline packages
- `ansible/roles/git` : Git defaults
- `ansible/roles/shell` : shell path setup
- `ansible/roles/devtools` : developer tools (nodejs, npm, tree-sitter-cli)
- `ansible/roles/neovim` : Neovim install and config
- `ansible/roles/zsh` : Zsh + Oh My Zsh + powerlevel10k
- `ansible/roles/ssh_hardening` : SSH client hardening and known_hosts pinning
- `scripts/wsl_healthcheck.py` : tool availability checks

## Notes

- Inventory is local-only: `ansible/inventory/localhost.ini`.

## Backlog

See `BACKLOG.md` for planned work.
