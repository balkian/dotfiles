#!/bin/bash
# Extracted from: http://ubuntuforums.org/showthread.php?t=1797848
# User: azzid
# Modified by Balkian
# Collect DBUS_SESSION_BUS_ADDRESS from running process
function set_dbus_adress
{
	USER=$1
	PROCESS=$2
	PID=`pgrep -o -u $USER $PROCESS`
	ENVIRON=/proc/$PID/environ

	if [ -e $ENVIRON ]
	 then
	export `grep -z DBUS_SESSION_BUS_ADDRESS $ENVIRON`
	 else
	echo "Unable to set DBUS_SESSION_BUS_ADDRESS."
	exit 1
	fi
}

function spotify_cmd
{
	dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.$1 1> /dev/null
}

function spotify_query
{
	qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get org.mpris.MediaPlayer2.Player PlaybackStatus
}

function spotify_metadata
{
	qdbus com.spotify.qt / org.freedesktop.MediaPlayer2.GetMetadata
}

function spotify_notify
{
    metadata=`spotify_metadata`
    echo "Metadata: $metadata"
    title=`echo "$metadata" | grep title | cut -d' ' -f2-`
    artist=`echo "$metadata" | grep artist | cut -d' ' -f2-`
    image=`echo "$metadata" | grep artUrl | cut -d' ' -f3`
    wget $image -O /tmp/image
    echo "notifying $title"
    notify-send "$artist" "$title" --icon=/tmp/image
}

function quit_message
{
	echo "Usage: `basename $0` {play|pause|playpause|next|previous|stop|playstatus|<spotify URI>}"
	exit 1
}

# Count arguments, must be 1
if [ "$#" -ne "1" ]
then
        echo -e "You must supply exactly one argument!\n"
	quit_message
fi

# Check if DBUS_SESSION is set
if [ -z $DBUS_SESSION_BUS_ADDRESS ] 
	 then
	#echo "DBUS_SESSION_BUS_ADDRESS not set. Guessing."
	set_dbus_adress `whoami` spotify
fi

case "$1" in
        play)
		spotify_cmd Play
        spotify_notify
                ;;
        pause)
		spotify_cmd Pause
        spotify_notify
                ;;
        playpause)
		spotify_cmd PlayPause
        spotify_notify
                ;;
        next)
		spotify_cmd Next
        spotify_notify
                ;;
        previous)
		spotify_cmd Previous
        spotify_notify
                ;;
        stop)
		spotify_cmd Stop
        spotify_notify
                ;;
        spotify:user:*)
		spotify_cmd "OpenUri string:$1"
		spotify_cmd Play
        spotify_notify
                ;;
        spotify:*:*)
		spotify_cmd "OpenUri string:$1"
                ;;
	playstatus)
		spotify_query
		;;
    metadata)
        spotify_metadata;
        ;;
        *)
                echo -e "Bad argument.\n"
                quit_message
                ;;
esac

exit 0
