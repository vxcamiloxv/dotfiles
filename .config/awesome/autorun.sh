#!/usr/bin/env bash
AWESOME_DIR=`dirname $0`
source "$AWESOME_DIR/scripts/run.sh"

# General config
# ---------------
# Keyboard layout
setxkbmap latam

# Touchpad config
#xinput --set-prop 14 "libinput Natural Scrolling Enabled" 1
#xinput --set-prop 14 "libinput Click Method Enabled" {1 1}
#xinput --set-prop 14 "libinput Tapping Enabled" 1

# Composition
run xcompmgr

# Autorun apps
# --------------
run clipmenud
run urxvtd -q -o
run udiskie --smart-tray --notify
run emacs --daemon --no-splash
run kupfer --no-splash
run nextcloud
run redshift-gtk
xset s 600 500
run xss-lock -- "$AWESOME_DIR/scripts/lock.sh" &
#pgrep xautolock || xautolock -detectsleep -notify 300 -notifier 'xset dpms force off' -time 10 -locker 'light-locker-command -l' -killtime 30 -killer 'systemctl suspend$

# Enable layoutscreen
#[ -f ~/.scripts/screenlayout ] && ~/.scripts/screenlayout &

