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

if [[ ! -e "$CONFIG_FILE" ]]; then
register.sh
fi

sed -E -i "s/concurrent = [0-9]+/concurrent = $CONCURRENT/g" "$CONFIG_FILE"

gitlab-ci-multi-runner run

