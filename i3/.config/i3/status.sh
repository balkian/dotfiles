#1/bin/sh
SCRIPT_DIR=/usr/lib/i3blocks
if [ ! -d "$SCRIPT_DIR" ]; then
  SCRIPT_DIR=/usr/share/i3blocks
fi
CONTRIB_PATH=$HOME/.config/i3/i3blocks-contrib SCRIPT_DIR=$SCRIPT_DIR i3blocks -c $HOME/.config/i3/i3blocks.conf
