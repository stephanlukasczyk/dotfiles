alias l='ls -blah'
alias la='ls -ah'
alias ...='cd ../..'

alias m='tmux -u2'
alias "gitgui"="LANG=en_US git gui"
alias vim='vim --servername vim'
alias vless='vim -u /usr/share/vim/vim74/macros/less.vim'
alias rless='less -r'
alias myip='wget http://checkip.dyndns.org -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1'
alias pong="ping -c 3 google.de"

## Root-Aliases
if [ "$(whoami)" = "root" ]; then
	alias vpn_uni_ext="openvpn --cd /home/jb/.openvpn/uni/ --config stud-ext.ovpn --auth-user-pass auth"
	alias vpn_uni_pub="openvpn --cd /home/jb/.openvpn/uni/ --config stud-pub.ovpn --auth-user-pass auth"
  alias ipredator_connect="openvpn --config /etc/openvpn/IPredator-CLI-Password.conf"
  alias ipredator_flush_iptables="ferm --flush /etc/ferm-transmission.conf"
fi

## Functions
## proxy functions
proxy_set_uni() {
	export http_proxy="http://www-cache.rz.uni-passau.de:3128"
	export https_proxy=$http_proxy
	export ftp_proxy=$http_proxy
	export HTTP_PROXY=$http_proxy
	export HTTPS_PROXY=$htts_proxy
	export FTP_PROXY=$http_proxy
}
proxy_unset() {
	export http_proxy=""
	export https_proxy=$http_proxy
	export ftp_proxy=$http_proxy
	export HTTP_PROXY=$http_proxy
	export HTTPS_PROXY=$htts_proxy
	export FTP_PROXY=$http_proxy
}

## funktion to extract files
extract() {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)	tar xvjf $1		;;
			*.tar.gz)	tar xvzf $1		;;
			*.tar.xz)	tar xvJf $1		;;
			*.bz2)		bunzip2 $1		;;
			*.rar)		unrar x $1		;;
			*.gz)		gunzip $1		;;
			*.tar)		tar xvf $1		;;
			*.tbz2)		tar xvjf $1		;;
			*.tgz)		tar xvzf $1		;;
			*.zip)		unzip $1		;;
			*.Z)		uncompress $1	;;
			*.7z)		7z x $1			;;
			*.xz)		unxz $1			;;
			*.exe)		cabextract $1	;;
			*)			echo "\`$1': unrecognized file compression"	;;
		esac
	else
		echo "\`$1' is not a valid file"
	fi
}

cpf() { cp "$@" && goto "$_"; }
mvf() { mv "$@" && goto "$_"; }
goto() { [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; }
mkcd() { mkdir "$@" && cd "$@"; }
