#!/bin/bash
set -eu

CONFIG_FILE=${CONFIG_FILE:-/etc/gitlab-runner/config.toml}
if [[ $EUID -ne 0 ]]; then
  CONFIG_FILE="$HOME/.gitlab-runner/config.toml"
fi

if [[ ! -e "$CONFIG_FILE" ]]; then
gitlab-ci-multi-runner register
cat <<MULTILINE >> "$CONFIG_FILE"
  [runners.machine]
    IdleCount = $MACHINE_IDLE_COUNT
    IdleTime = $MACHINE_IDLE_TIME
    MaxBuilds = $MACHINE_MAX_BUILDS
    MachineName = "$MACHINE_NAME"
    MachineDriver = "$MACHINE_DRIVER"
MULTILINE
sed -i "s/concurrent = 1/concurrent = $CONCURRENT/g" "$CONFIG_FILE"
fi

gitlab-ci-multi-runner run
