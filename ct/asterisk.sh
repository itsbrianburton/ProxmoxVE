#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/misc/build.func)
# Copyright (c) 2024 Brian Burton
# Author: Brian Burton (itsbrianburton)
# License: MIT | https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE
# Source: https://github.com/asterisk/asterisk

# App Default Values
APP="asterisk"
var_tags="pbx;asterisk"
var_cpu="1"
var_ram="2048"
var_disk="4"
var_os="alpine"
var_version="3.21.0"
var_unprivileged="1"

# App Output & Base Settings
header_info "$APP"
base_settings

# Core
variables
color
catch_errors

function update_script() {
    header_info
    check_container_storage
    check_container_resources
	if ! apk info -e asterisk > /dev/null 2>&1; then
		msg_error "No ${APP} Installation Found!"
        exit
	fi
    msg_info "Updating $APP"
    systemctl stop asterisk
	apk update
    apk upgrade --no-cache
    msg_ok "Updated $APP"
    exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${CREATING}${GN}${APP} setup has been successfully initialized!${CL}"
echo -e "${INFO}${YW} Access it using the following URL:${CL}"
echo -e "${TAB}${GATEWAY}${BGN}http://${IP}:1984${CL}"