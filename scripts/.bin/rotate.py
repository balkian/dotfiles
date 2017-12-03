#!/usr/bin/env python3
import subprocess
import sys


def rotate(screen="", rotate="inverted"):
    matchline = [
                l.split() for l in subprocess.check_output(["xrandr"]).decode("utf-8").splitlines()\
                            if screen in l and ' connected' in l
                                ]
    for line in matchline:
        s = line[
                    line.index([s for s in line if s.count("+") == 2][0])+1
                        ]

        r = "normal" if s == rotate else rotate
        screen = line[0]
        subprocess.call(["xrandr", "--output", screen, "--rotate", r])


if __name__ == '__main__':
    screen = ''
    rotation = 'inverted'
    if len(sys.argv) > 1:
        screen = sys.argv[1]
    if len(sys.argv) > 2:
        rotation = sys.argv[2]
    rotate(screen, rotation)
