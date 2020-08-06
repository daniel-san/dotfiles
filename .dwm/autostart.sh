#!/bin/bash
#/usr/bin/trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 15 --transparent true --alpha 0 --tint 0x292d3e --height 19 &

dte(){
  dte="$(date +"%a, %D |  %l:%M%p")"
  echo -e "$dte"
}

mem(){
  mem=`free | awk '/Mem/ {printf "%d MiB/%d MiB\n", $3 / 1024.0, $2 / 1024.0 }'`
  echo -e " $mem"
}

cpu(){
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -e " $cpu% cpu"
}

#killing processes that will spawn more than once
#pkill redshift-gtk
pkill volumeicon
pkill nm-applet
pkill megasync
killall sxhkd

#spawning the real autostart processes
xsetroot -cursor_name left_ptr &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xrandr --output DVI-D-0 --primary --auto --right-of HDMI-1
#redshift-gtk -t 3800:3800 &
volumeicon &
nm-applet &
nitrogen --restore &
compton &
megasync &
sxhkd &
xrdb .Xresources

while true; do
     xsetroot -name "$(cpu) | $(mem) | $(dte)"
     sleep 10s    # Update time every ten seconds
done &
