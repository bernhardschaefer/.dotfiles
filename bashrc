# ----- DEFAULT BASHRC -----
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
# alias ll='ls -alF'
alias ll='ls -lhF --color=auto'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



# ----- CUSTOM STUFF -----

alias cp='cp -v'
alias mv='mv -v'

# mkdir and cd in one command 
# from http://www.thegeekstuff.com/2008/10/6-awesome-linux-cd-command-hacks-productivity-tip3-for-geeks/
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

# up function
function up {
[ "${1/[^0-9]/}" == "$1" ] && {
        local ups=""
        for i in $(seq 1 $1)
        do
                ups=$ups"../"
        done
        cd $ups
        } || echo "usage: up INTEGER"
}


# VIM stuff
export EDITOR=/usr/bin/vim

# 256 colors to enable zenburn
# disabled for now
# export TERM=xterm-256color  # for common 256 color terminals

#set -o vi # enable vim syntax in command line
#set -o vi
#bind -m vi-command ".":insert-last-argument
#bind -m vi-insert "\C-l.":clear-screen
#bind -m vi-insert "\C-a.":beginning-of-line
#bind -m vi-insert "\C-e.":end-of-line
#bind -m vi-insert "\C-w.":backward-kill-word

export JAVA_HOME=/opt/Oracle_Java/jdk1.7.0_latest

# maven
export M2_HOME=/usr/share/maven

ECLIPSE_HOME=/opt/eclipse/eclipse-default
export PATH=$PATH:$ECLIPSE_HOME

# eclipse global menu bug
export UBUNTU_MENUPROXY=0
# eclipse 4.x sometimes crashes with overlay scrollbar
export LIBOVERLAY_SCROLLBAR=0

# switch caps lock and escape
# http://askubuntu.com/questions/363346/how-to-permanently-switch-caps-lock-and-esc
# is dealt with by ubuntu atm
/usr/bin/setxkbmap -option "caps:swapescape"

# --- IntelliJ ---
# INTELLIJ_HOME=/opt/intellij/idea-IC-129.1359
# export PATH=$PATH:$INTELLIJ_HOME/bin

# export RAPIDMINER_HOME=/opt/rapidminer
# export PATH=$PATH:$RAPIDMINER_HOME/scripts

# export PATH=$PATH:/home/bernhard/glassfish3/bin

# export PATH=$PATH:/opt/node-v0.8.15-linux-x64/bin

# aliases
# alias asl='asadmin list-applications'
# alias asd='asadmin deploy'
# alias asu='asadmin undeploy'

# PLAY_HOME=/opt/play-2.2.0
# export PATH=$PATH:$PLAY_HOME

# # HADOOP STUFF
# # Set Hadoop-related environment variables
# export HADOOP_PREFIX=/opt/hadoop/hadoop
# 
# # Some convenient aliases and functions for running Hadoop-related commands
# unalias fs &> /dev/null
# alias fs="hadoop fs"
# unalias hls &> /dev/null
# alias hls="fs -ls"
# 
# # If you have LZO compression enabled in your Hadoop cluster and
# # compress job outputs with LZOP (not covered in this tutorial):
# # Conveniently inspect an LZOP compressed file from the command
# # line; run via:
# #
# # $ lzohead /hdfs/path/to/lzop/compressed/file.lzo
# #
# # Requires installed 'lzop' command.
# #
# lzohead () {
#     hadoop fs -cat $1 | lzop -dc | head -1000 | less
# }
# 
# # Add Hadoop bin/ directory to PATH
# export PATH=$PATH:$HADOOP_PREFIX/bin
# 
# # PIG STUFF
# PIG_HOME=/opt/pig/pig-0.12.0
# export PATH=$PATH:$PIG_HOME/bin
