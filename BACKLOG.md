# Backlog

## Next
- Add a devtools role to install optional CLIs (terraform, kubectl, awscli, azure-cli) behind feature flags.
- Add a bootstrap script that installs Ansible and runs the playbook with sensible defaults.
- Add ansible-lint and a minimal CI workflow to validate idempotency and style.
- Document variables and profiles (minimal vs full) in README.
- Add SSH hardening role for client-only config and known_hosts pinning.

## Later
- Add a Docker CLI-only role (no daemon) for WSL2 compatibility.
- Add a role for Node.js and Python tooling (nvm/pyenv or apt-based), opt-in only.
- Add a role to manage shell aliases and prompt tweaks (small, no frameworks).
- Add a healthcheck summary mode (machine-readable JSON output).
- Add Molecule tests for roles.
