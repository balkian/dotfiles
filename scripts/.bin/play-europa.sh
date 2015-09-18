#!/bin/bash
rtmpdump --live --quiet --buffer 3000 -r rtmp://antena3fms35geobloqueolivefs.fplive.net/antena3fms35geobloqueolive-live/ --playpath stream-europafm | mplayer -vo null -idle -
