#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLAYBOOK="${ROOT_DIR}/ansible/playbooks/wsl.yml"

usage() {
  cat <<'EOF'
Usage: ./bootstrap.sh

Installs Ansible (if missing) and runs the WSL playbook.
Optional env flags:
  DEVTOOLS_INSTALL_TERRAFORM=true
  DEVTOOLS_INSTALL_KUBECTL=true
  DEVTOOLS_INSTALL_AWSCLI=true
  DEVTOOLS_INSTALL_AZURE_CLI=true
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 is required but not found." >&2
  exit 1
fi

if ! command -v ansible-playbook >/dev/null 2>&1; then
  if ! command -v pip3 >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y python3-pip
  fi
  python3 -m pip install --user --upgrade ansible
  export PATH="${HOME}/.local/bin:${PATH}"
fi

if ! command -v ansible-playbook >/dev/null 2>&1; then
  echo "ansible-playbook not found after install." >&2
  exit 1
fi

extra_vars=()
if [[ "${DEVTOOLS_INSTALL_TERRAFORM:-false}" == "true" ]]; then
  extra_vars+=("-e" "devtools_install_terraform=true")
fi
if [[ "${DEVTOOLS_INSTALL_KUBECTL:-false}" == "true" ]]; then
  extra_vars+=("-e" "devtools_install_kubectl=true")
fi
if [[ "${DEVTOOLS_INSTALL_AWSCLI:-false}" == "true" ]]; then
  extra_vars+=("-e" "devtools_install_awscli=true")
fi
if [[ "${DEVTOOLS_INSTALL_AZURE_CLI:-false}" == "true" ]]; then
  extra_vars+=("-e" "devtools_install_azure_cli=true")
fi

become_flags=()
if ! sudo -n true 2>/dev/null; then
  become_flags+=("-K")
fi

ansible-playbook "${PLAYBOOK}" "${become_flags[@]}" "${extra_vars[@]}"
