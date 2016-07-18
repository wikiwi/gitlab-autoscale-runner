#!/bin/bash

# Copyright (C) 2016 wikiwi.io
#
# This software may be modified and distributed under the terms
# of the MIT license. See the LICENSE file for details.

set -eu

CONFIG_FILE=${CONFIG_FILE:-/etc/gitlab-runner/config.toml}
if [[ $EUID -ne 0 ]]; then
  CONFIG_FILE="$HOME/.gitlab-runner/config.toml"
fi

gitlab-ci-multi-runner register
cat <<MULTILINE >> "$CONFIG_FILE"
  [runners.machine]
    IdleCount = $MACHINE_IDLE_COUNT
    IdleTime = $MACHINE_IDLE_TIME
    MaxBuilds = $MACHINE_MAX_BUILDS
    MachineName = "$MACHINE_NAME"
    MachineDriver = "$MACHINE_DRIVER"
MULTILINE


