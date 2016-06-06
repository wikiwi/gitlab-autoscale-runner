#!/bin/bash
set -eu

if [[ ! -e /etc/gitlab-runner/config.toml ]]; then
gitlab-ci-multi-runner register
cat <<MULTILINE >> /etc/gitlab-runner/config.toml
  [runners.machine]
    IdleCount = $MACHINE_IDLE_COUNT
    IdleTime = $MACHINE_IDLE_TIME
    MaxBuilds = $MACHINE_MAX_BUILDS
    MachineName = "$MACHINE_NAME"
    MachineDriver = "$MACHINE_DRIVER"
MULTILINE
fi

gitlab-ci-multi-runner run
