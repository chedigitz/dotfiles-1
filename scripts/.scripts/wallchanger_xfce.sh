#!/bin/bash
/usr/bin/xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s "$(find ~/Pictures/Wallpapers -type f -iregex '.*\.\(bmp\|gif\|jpg\|png\)$' | sort -R | head -1)"
