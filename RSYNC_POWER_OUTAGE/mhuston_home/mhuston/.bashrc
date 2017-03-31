# vim: ft=sh:
# .bashrc
# John R. Ray <john@johnray.io>
# set -x
#

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# shopt -s globstar

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# Vim Prompt
[ -f ~/.promptline.sh ] && source ~/.promptline.sh

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Some more ls aliases
#alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Set custom PATH
# PATH=$PATH:~/bin:~/.rvm/bin

# Automatically add our private key. See ssh-add
ssh-add ~/.ssh/Keys/*.priv > /dev/null 2>&1

# Set no proxy
export no_proxy='localhost,127.0.0.1,.ray.com,10.0.0.0/8,192.168.0.0/16,chef-server,gitlab-server,jenkins-server,jenkins,gar-ifnxyum'

# ChefDk
eval "$(chef shell-init bash)"

# Dot Aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

## Functions
extract() { 
  if [ -f $1 ] ; then 
    case $1 in 
      *.tar.bz2) tar xjf $1 ;; 
      *.tar.gz) tar xzf $1 ;; 
      *.bz2) bunzip2 $1 ;; 
      *.rar) unrar e $1 ;; 
      *.gz) gunzip $1 ;; 
      *.tar) tar xf $1 ;; 
      *.tbz2) tar xjf $1 ;; 
      *.tgz) tar xzf $1 ;; 
      *.zip) unzip $1 ;; 
      *.Z) uncompress $1 ;; 
      *.7z) 7z x $1 ;; 
      *) echo "'$1' cannot be extracted via extract()" ;; 
    esac 
  else 
    echo "'$1' is not a valid file" 
  fi 
}
alias dc=cd
alias reload="source ~/.bashrc && source ~/.bash_profile"
alias SSL="/opt/sslvpn-plus/naclient/login status"
alias setjdk="sudo update-alternatives --config javac"
alias setjre="sudo update-alternatives --config java"
alias backup="rsync -avzh /DATA/mhuston_home /home/mhuston_home/RSYNC_POWER_OUTAGE/"
alias bang='/home/mhuston/bang.sh'
alias cls=clear
alias blam='/bin/matrix'
alias wallpaper='/home/mhuston/get_rdt_wlpr.sh'
