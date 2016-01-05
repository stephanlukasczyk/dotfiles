if test -u "$DBUS_SESSION_BUS_ADDRESS" ; then
	eval `dbus-launch --sh-syntax --exit-with-session`
	echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
fi

source /etc/X11/xinit/xinitrc.d/30-dbus

eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID
/usr/bin/gnome-keyring-daemon --start --components=gpg
/usr/bin/gnome-keyring-daemon --start --components=pkcs11
/usr/bin/gnome-keyring-daemon --start --components=secrets
/usr/bin/gnome-keyring-daemon --start --components=ssh

xbindkeys &
#setxkbmap -option compose:caps
setxkbmap -option caps:escape
xmodmap -e 'keysym F12 = Multi_key'

xrdb -l .Xresources

#gpg-agent --daemon &

xcompmgr &

wmname LG3D
export _JAVA_AWT_WM_NONREPARENTING=1

keepassx &

owncloud &

/home/sl/.screenlayout/default.sh
xset -dpms ; xset s off

redshift-gtk -c /home/sl/.config/redshift.conf &

sh ~/.fehbg &

powerline-daemon &

exec ck-launch-session dbus-launch --sh-syntax --exit-with-session i3
