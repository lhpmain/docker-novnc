#!/bin/bash
# Set them to empty is NOT SECURE but avoid them display in random logs.
export VNC_PASSWD=''
export USER_PASSWD=''
export HTTP_AUTH_USER=''
export HTTP_AUTH_PASSWD=''

# tray
stalonetray --dockapp-mode simple &

echo 'This is a dummy foreground process'
tail -n0 -f $0
