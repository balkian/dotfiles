#!/bin/bash
rtmpdump --live --quiet -r rtmp://kissfm.es.flash3.glb.ipercast.net/kissfm.es-live --playpath aac.stream | mplayer -vo null -idle -
