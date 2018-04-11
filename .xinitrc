if test -u "$DBUS_SESSION_BUS_ADDRESS" ; then
	eval `dbus-launch --sh-syntax --exit-with-session`
	echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
fi

source /etc/X11/xinit/xinitrc.d/30-dbus

xbindkeys &
#setxkbmap -option compose:caps
setxkbmap -option caps:escape
xmodmap -e 'keysym F12 = Multi_key'

xrdb -l .Xresources

#gpg-agent --daemon &

xcompmgr &

wmname LG3D
export _JAVA_AWT_WM_NONREPARENTING=1

keepassxc &

nextcloud &

/home/lukasczy/.screenlayout/default.sh
xset -dpms ; xset s off

redshift -c /home/lukasczy/.config/redshift.conf &

sh ~/.fehbg &

exec ck-launch-session dbus-launch --sh-syntax --exit-with-session i3
