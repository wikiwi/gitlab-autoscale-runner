#!/bin/bash
set -eu

CONFIG_FILE=${CONFIG_FILE:-/etc/gitlab-runner/config.toml}
if [[ $EUID -ne 0 ]]; then
  CONFIG_FILE="$HOME/.gitlab-runner/config.toml"
fi

if [[ ! -e "$CONFIG_FILE" ]]; then
register.sh
sed -i "s/concurrent = 1/concurrent = $CONCURRENT/g" "$CONFIG_FILE"
fi

gitlab-ci-multi-runner run

