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

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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


# http://askubuntu.com/questions/184397/how-do-i-pipe-terminal-standard-output-stdout-to-the-clipboard
alias copy='xsel -ib'

# use vim as editor
export EDITOR=/usr/bin/vim

# solarized dircolors
# https://github.com/seebi/dircolors-solarized
DIRCOLORS_DIR=~/ws/git/dircolors-solarized
if [ ! -d "$DIRCOLORS_DIR" ]; then
  mkdir -p "$DIRCOLORS_DIR"
  git clone https://github.com/seebi/dircolors-solarized.git $DIRCOLORS_DIR
fi 
eval $(dircolors $DIRCOLORS_DIR/dircolors.ansi-dark)

export JAVA_HOME=/usr/lib/jvm/default-java
export PATH=$PATH:$JAVA_HOME/bin

# -- Powerline ---
export TERM=xterm-256color

POWERLINE_DIR=/usr/local/lib/python2.7/dist-packages/powerline
if [ ! -d "$POWERLINE_DIR" ]; then
  sudo apt-get install socat python-psutil
  sudo pip install powerline-status
  # install font
  wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
  sudo mv -v PowerlineSymbols.otf /usr/local/share/fonts/
  sudo fc-cache -f -v
  # configure font
  wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
  mkdir -p ~/.config/fontconfig/fonts.conf
  mv -v 10-powerline-symbols.conf ~/.config/fontconfig/fonts.conf/
fi
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source $POWERLINE_DIR/bindings/bash/powerline.sh

# --- Maven ---

# recommended maven opts for building spark (https://spark.apache.org/docs/latest/building-spark.html#setting-up-mavens-memory-usage)
export MAVEN_OPTS="-Xmx2g -XX:MaxPermSize=512M -XX:ReservedCodeCacheSize=512m"
#export M2_HOME=/usr/share/maven

# --- Eclipse --- 
ECLIPSE_HOME=/opt/eclipse/eclipse-default
export PATH=$PATH:$ECLIPSE_HOME

## eclipse global menu bug
#export UBUNTU_MENUPROXY=0
## eclipse 4.x sometimes crashes with overlay scrollbar
#export LIBOVERLAY_SCROLLBAR=0
#
#ANDROID_SDK_HOME=/opt/android/latest/sdk
#export PATH=$PATH:$ANDROID_SDK_HOME/tools
#export PATH=$PATH:$ANDROID_SDK_HOME/platform-tools
#

# --- Hadoop Settings ---
SETTINGS_DIR=~/ws/git/psd-dwh-ops/rex/files/etc

export HADOOP_CONF_DIR=$SETTINGS_DIR/hadoop/conf.stage
export HADOOP_PREFIX=/opt/hadoop/hadoop-active
export PATH=$PATH:$HADOOP_PREFIX/bin

# TODO pig configuration
#export PIG_HOME=/opt/hadoop/pig-active
#export PATH=$PATH:$PIG_HOME/bin

#export HIVE_CONF_DIR=$SETTINGS_DIR/hive/conf.stage
#export HIVE_HOME=/opt/hadoop/hive-active
#export PATH=$PATH:$HIVE_HOME/bin

# --- R Settings ---
# export R_LIBS="/home/$USER/ws/R_libs"
