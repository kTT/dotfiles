export ZSH=$HOME/workspace/oh-my-zsh
export DISABLE_AUTO_UPDATE="true"
export CASE_SENSITIVE="true"

plugins=(completion vi-mode git git-flow history-substring-search zsh-syntax-highlighting)

zstyle ':completion:*' hosts off

export ZSH_THEME="ktt"

source $ZSH/oh-my-zsh.sh

export EDITOR=vim
#export CCACHE_DIR=/tmp/.ccache
export BROWSER="chromium"
export GDK_USE_XFT=1
export QT_XFT=true
export PATH="/usr/lib/ccache/bin/:$PATH"

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# ignore duplicates
setopt inc_append_history
setopt share_history
setopt hist_ignore_all_dups

setopt nohup

# avoid typing cd while changing directory
setopt autocd

autoload -U edit-command-line #load command editor
zle -N edit-command-line
bindkey '\ee' edit-command-line #bind editor to M-e

cdf () { cd "$(dirname "$(locate "$1" | head -n 1)")" ; } #locate and cd

alias gdb='gdb -q'

alias ls="ls --color=auto --group-directories-first"
alias ll="ls -lh"
alias la="ls -A"
alias lla="ls -Alh"

alias grep="grep --color=auto"

# packer
#alias yi="sudo packer -S" # install
#alias yin="sudo packer -S --noconfirm" # install without confirm
#alias yu="sudo packer -Syu" # update
#alias yr="sudo pacman -Rcns" # remove
#alias ys="packer -Ss" # search network
#alias yq="pacman -Qs" # search local
#alias yo="packer -Qo" # query the package that owns file
#alias yl="packer -Ql" # list content of package

# yaourt
alias yi="yaourt -S" # install
alias yin="yaourt -S --noconfirm" # install without confirm
alias yu="yaourt -Syua" # update
alias yr="sudo pacman -Rcns" # remove
alias ys="yaourt -Ss" # search network
alias yq="pacman -Qs" # search local
alias yo="yaourt -Qo" # query the package that owns file
alias yl="yaourt -Ql" # list content of package

function yn() {
    for arg in "$@";
        do pacman -Qi $arg 2> /dev/null || pacman -Si $arg
    done
}

# iso
alias mountiso="sudo mount -o loop -t iso9660"

# vim aliases
alias sgvim="sudo gvim"
alias svim="sudo vim"
alias vi="vim"
alias v="vim"
alias sv="sudo vim"
alias vp="vim +NERDandTlist"

# gdb aliases
alias gdbtui="gdbtui -silent -r"

# startx
alias x="startx -- vt1 -nolisten tcp -br -deferglyphs 16 -dpi 96 -depth 24 >/dev/null 2>&1"
alias x8="startx -- -nolisten tcp -br -deferglyphs 16 -dpi 75 -depth 8 >/dev/null 2>&1"
alias x16="startx -- -nolisten tcp -br -deferglyphs 16 -dpi 75 -depth 16 >/dev/null 2>&1"

alias xdwm="startx -- -nolisten tcp -br -deferglyphs 16 -dpi 75 -depth 16  :1>/dev/null 2>&1"

# mplayer
alias mp="mplayer -nolirc -ass -ass-color ffffff00 -ass-border-color 00000000"
#alias mp="mplayer -nolirc -ass -ass-color ffffff00 -ass-border-color 00000000 -ass-force-style FontName=Arial,ScaleX=0.7,FontSize=30"

alias playdvd="mp -mouse-movements dvdnav://"

# misc
alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'
alias cp="cp -rpv"
alias mv="mv -v"
alias rm="rm -vI"
alias df="df -hT"
alias du="du -hc"

function  mem() { ps -o rss,comm -p $(pgrep $1) }

alias rotate="xrandr -o left"
alias normal="xrandr -o normal"

alias webshare='python2 -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'
alias password="egrep -ioam1 '[a-z0-9]{8}' /dev/urandom"
alias findbig="find . -type f -exec ls -s {} \; | sort -n -r | head -5"

function makesrt() { qnapi $1 && txt2srt $1 }

function start() { sudo systemctl start $1.service; }
function stop() { sudo systemctl stop $1.service; }
function restart() { sudo systemctl restart $1.service; }
function status() { sudo systemctl status $1.service; }

alias calc="bc -l <<<"

function color_adb_logcat() {
    RED=`echo -e '\033[41m\033[37m'`
    GREEN=`echo -e '\033[42m\033[37m'`
    NORMAL=`echo -e '\033[0m'`
    #LOWERED_TEXT=`echo $1 | tr "[A-Z]" "[a-z]"`
    adb $2 logcat | sed -e "s/^[A-Z]\/$1.*/$RED&$NORMAL/"
    #adb logcat | sed -e "s/^[A-Z]\/$1.*/$RED&$NORMAL/" | sed -e "s/$LOWERED_TEXT/$GREEN&$NORMAL/"
}

function reminder() {
    if [ $# -lt 2 ]; then
        echo "Usage: reminder delay message"
    else
        delay=$1
        shift
        (sleep $delay ; zenity --info --text="$*") > /dev/null &
    fi
}

function take() {
   mkdir -p $1
   cd $1
}

function start_sopcast() {
    sp-sc $1 3908 37832
}

function enter_docker() {
    if [[ -z "$1" ]]; then
        echo Please use following containers:
        fig ps
        return
    fi
    CONTAINER_ID=$(fig ps -q ${1})
    if [[ -n $CONTAINER_ID ]]; then
        docker exec -it $CONTAINER_ID bash
    fi
}

function docker_ip() {
    if [[ -z "$1" ]]; then
        echo Please use following containers:
        fig ps
        return
    fi
    CONTAINER_ID=$(fig ps -q ${1})
    if [[ -n $CONTAINER_ID ]]; then
        docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CONTAINER_ID
    fi
}

function docker_clear_containers() {
    # remove containers that are not running
    docker rm `docker ps -aq --no-trunc --filter "status=exited"`
    # remove dangling images
    docker rmi `docker images --filter 'dangling=true' -q --no-trunc`
}

# auto extension
alias -s pdf=zathura
alias -s png=feh
alias -s jpg=feh
alias -s gif=feh

export PYTHONSTARTUP=~/.pythonrc.py

if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
    x
    logout
fi

bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

bindkey -M viins '^q' push-line
bindkey -M vicmd '^q' push-line

bindkey -M viins 'q' push-line
bindkey -M vicmd 'q' push-line

zstyle ':completion:*:kill:*' command 'ps fau$USER'

alias dul='du -sh * | sort -h'

export GOPATH=~/.go
export PATH="$PATH:$GOPATH/bin"
