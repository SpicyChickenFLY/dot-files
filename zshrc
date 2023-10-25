source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
# zstyle :compinstall filename '/home/chow/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


autoload -U promptinit
promptinit

autoload -U colors && colors
# PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%(5~|%-1~/# .../%3~|%4~) %{$reset_color%}%% "

# VCS
YS_VCS_PROMPT_PREFIX1=" %{$reset_color%}on%{$fg[blue]%} "
S_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}x"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}o"

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}git${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

# Virtualenv
local venv_info='$(virtenv_prompt)'
YS_THEME_VIRTUALENV_PROMPT_PREFIX=" %{$fg[green]%}"
YS_THEME_VIRTUALENV_PROMPT_SUFFIX=" %{$reset_color%}%"
virtenv_prompt() {
	[[ -n "${VIRTUAL_ENV:-}" ]] || return
	echo "${YS_THEME_VIRTUALENV_PROMPT_PREFIX}${VIRTUAL_ENV:t}${YS_THEME_VIRTUALENV_PROMPT_SUFFIX}"
}

local exit_code="%(?,,C:%{$fg[red]%}%?%{$reset_color%})"

# Prompt format:
#
# PRIVILEGES USER @ MACHINE in DIRECTORY on git:BRANCH STATE [TIME] C:LAST_EXIT_CODE
# $ COMMAND
#
# For example:
#
# % ys @ ys-mbp in ~/.oh-my-zsh on git:master x [21:47:42] C:0
# $
PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[cyan]%}%n) \
%{$reset_color%}@ \
%{$fg[green]%}%m \
%{$reset_color%}in \
%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
 \
[%*] $exit_code
%{$terminfo[bold]$fg[red]%}%# %{$reset_color%}"


# alias
alias ssh="TERM=xterm-256color ssh"
alias ls='ls --color=auto'
alias ff="firefox"
alias ll="ls -l"
alias ..="cd .."
alias ...="cd ../.."
alias docker="sudo docker"
alias lzg="lazygit"
alias lzd="lazydocker"

alias vi="nvim"
alias vim="nvim"

# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx

export LANG=en_US.UTF-8
export LANGUAGE=en_US:zh_CN

# proxy
export http_proxy=http://127.0.0.1:7890
export https_proxy=http://127.0.0.1:7890

# path
export GOROOT=/usr/local/go
export GOPATH=/home/chow/Code/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export NODE_HOME=/usr/local/node
export PATH=$PATH:$NODE_HOME/bin

export JAVA_HOME=/usr/local/jdk8
export PATH=$PATH:$JAVA_HOME/bin

export MAVEN_HOME=/usr/local/maven
export PATH=$PATH:$MAVEN_HOME/bin

export PATH=$PATH:$HOME/.local/bin

# xbindkey
# sudo /etc/rc.local

if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
     exec sway
     # startx
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

