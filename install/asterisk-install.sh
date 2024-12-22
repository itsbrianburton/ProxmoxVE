#!/usr/bin/env bash

# Copyright (c) 2024 Brian Burton
# Author: Brian Burton (itsbrianburton)
# License: MIT
# https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE

source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Asterisk"
$STD apk add asterisk
$STD rc-update add asterisk default
msg_ok "Installed Asterisk"

motd_ssh
customize