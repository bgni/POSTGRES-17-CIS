#!/usr/bin/env bash
set -euo pipefail

cd /workspace

for _ in $(seq 1 30); do
    state=$(systemctl is-system-running 2>/dev/null || true)
    if [[ "${state}" == "running" || "${state}" == "degraded" ]]; then
        break
    fi
    sleep 1
done

ansible-playbook --syntax-check -i localhost, tests/container/playbook.yml
ansible-playbook -i localhost, tests/container/playbook.yml
