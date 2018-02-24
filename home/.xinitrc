# keyboard setup
setxkbmap -layout no -variant nodeadkeys

# X setup
xrdb "${XDG_CONFIG_HOME:-$HOME/.config}"/X11/Xresources
xmodmap "${XDG_CONFIG_HOME:-$HOME/.config}"/X11/Xmodmap

# gpg-agent with ssh
gpg-connect-agent /bye
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# desktop background
feh --bg-fill --no-fehbg "$HOME/.local/share/linus.png"

# start daemons
xstatus >/dev/null 2>&1 &
dunst &

# start window manager
# https://wiki.archlinux.org/index.php/Dwm#Fixing_misbehaving_Java_applications
export _JAVA_AWT_WM_NONREPARENTING=1
exec dwm

# vi: ft=sh
