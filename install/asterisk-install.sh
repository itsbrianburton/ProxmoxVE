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
$STD apt update
$STD apt upgrade
$STD apt install curl
$STD cd /usr/src
$STD wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-20-current.tar.gz
msg_info "Asterisk Downloaded"
$STD tar xvzf asterisk-20-current.tar.gz
$STD rm -f asterisk-20-current.tar.gz
$STD cd asterisk-20.*
$STD contrib/scripts/install_prereq install
msg_info "Building Asterisk"
$STD ./configure
msg_info "Configure Complete"
$STD make
msg_info "Make Complete"
$STD make install
$STD make samples
$STD make config
msg_ok "Installed Asterisk"
$STD systemctl enable asterisk
$STD systemctl start asterisk
msg_ok "Asterisk Started"

motd_ssh
customize