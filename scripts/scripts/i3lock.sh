#!/bin/bash

IMAGE="/tmp/screenshot.png"
scrot -o -q 80 -F $IMAGE
magick $IMAGE -blur 20x10 $IMAGE
i3lock -i $IMAGE
