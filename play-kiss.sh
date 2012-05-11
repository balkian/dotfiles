#!/bin/bash
rtmpdump -r rtmp://kissfm.es.flash3.glb.ipercast.net/kissfm.es-live --playpath aac.stream | mplayer -vo null -idle -

