#!/bin/sh

# this file is run when calling startx

# default arch init scripts
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
fi

# user init scripts and settings
[ -r /etc/X11/xinit/.Xmodmap ] && xmodmap /etc/X11/xinit/.Xmodmap
[ -r ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -r ~/.Xresources ] && xrdb -merge ~/.Xresources
[ -r ~/.xprofile ] && . ~/.xprofile

# set wallpaper
feh --bg-fill ~/.config/wallpaper.jpg &

# cmus 
cmus () {
artest=$( cmus-remote -Q | grep "tag artist" | sed s/"tag artist"/""/g | sed '1s/^.//')
title=$( cmus-remote -Q | grep "tag title" | sed s/"tag title"/""/g )
status=$( cmus-remote -Q | grep "status" | sed s/"tag title"/""/g )
track=$( echo -e " ‣ $artest -$title |")
if  [[ "$status" != "status playing" ]]; then
cm=""
cmcolor=$(echo -e "$cm")
else
trackc=$( echo -e "$track")
echo "$trackc"
fi
}

# set time and cmus status
while true; do
xsetroot -name "`cmus` `date +"%a %F %R"`"
done &

# launch Idesk to display icons 
idesk &

# launch the session, commands below this line will be ignored
exec dwm
