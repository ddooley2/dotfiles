#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d]; then
	for f in /etc/X11/xinit/xinitrc.d/*; do
		[ -x "$f" ] && . "$f"
done
unset f
fi
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
urxvt -q -o -f &
autocutsel -fork &
autocutsel -selection PRIMARY -fork &
/usr/bin/start-pulseaudio-x11 &
#eval `cat ~/.fehbg`
eval `feh --randomize --bg-scale /home/ddooley/Documents/Wallpapers`
#eval `sudo rmmod pcspkr`


exec i3


