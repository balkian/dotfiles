#!/bin/sh
# Encode a video in DVD quality (-crf 23) and use the video stabilization/deshaking plugin
# https://ffmpeg.org/ffmpeg-filters.html#toc-vidstabdetect-1
for VIDEO in "$@"
do
    DEST=converted/$VIDEO
    if [ -f $DEST ]; then
        echo "File $VIDEO already converted"
        continue
    fi
    mkdir -p converted
    ffmpeg -i $VIDEO -vf vidstabdetect -f null -
    ffmpeg -i $VIDEO -vf vidstabtransform=smoothing=30:input="transforms.trf" -crf 23 $DEST
done
