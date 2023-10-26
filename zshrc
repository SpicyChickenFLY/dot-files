source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Command completion
autoload -Uz compinit
compinit

# Prompt themes
autoload -Uz compinit
autoload -U promptinit
promptinit

autoload -U colors && colors

local user_name="%F{cyan}%n@%m%f"
local user_cwd="%F{yellow}%B%~%b%f"
local exit_code="%(?,%F{green}OK%f,%F{red}%BE:%?%b%f)"
local now_time="%F{magenta}%*%f"
local prompt_indicator="%F{red}%B%#%b%f"
PROMPT="$user_name in $user_cwd [$now_time] $exit_code
$prompt_indicator "

# alias
alias ls='ls --color=auto'
alias ll="ls -lh"
alias ..="cd .."
alias ...="cd ../.."
alias docker="sudo docker"
alias lzg="lazygit"
alias lzd="lazydocker"

alias nv="nvim"

# proxy
export http_proxy=http://127.0.0.1:7890
export https_proxy=http://127.0.0.1:7890

# path
export MAVEN_HOME=/usr/local/maven
export PATH=$PATH:$MAVEN_HOME/bin

export GOROOT=/usr/local/go
export GOPATH=$HOME/Code/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export NODE_HOME=/usr/local/node
export PATH=$PATH:$NODE_HOME/bin

export JDK8=/usr/local/jdk8
export JDK17=/usr/local/jdk17
export JAVA_HOME=$JDK8
export PATH=$PATH:$JAVA_HOME/bin

export GOBANG_HOME=/usr/local/gobang
export PATH=$PATH:$GOBANG_HOME

export CLASSPATH=$CLASSPATH:.

# export MYSQL_HOME=/usr/local/mysql
# export PATH=$PATH:$MYSQL_HOME/bin
#
export PATH=$PATH:$HOME/.local/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"


if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
     # exec i3
     # exec sway
fi
