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
$STD tar zfxf asterisk-20-current.tar.gz
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
$STD mkdir -p /etc/asterisk/samples
$STD mv /etc/asterisk/*.* /etc/asterisk/samples/
$STD make config

$STD systemctl enable asterisk.service
$STD systemctl start asterisk.service
msg_ok "Installed Asterisk"

motd_ssh
customize