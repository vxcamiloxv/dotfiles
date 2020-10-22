# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Start GNU Screen
alias screen="screen -aAxRl"
#[[ -z "$STY" ]] && screen

############
# MOTD
############
echo "$(tput setaf 2)
                               |
     __                        |  GNU en `hostname`
    |__)_  _ _ |_  _ | _       |  `date +"%A, %e %B %Y, %r"`
    |  (_|| (_||_)(_)|(_|      |  Linux-Libre `uname -rm`
  ===========================  |  $(tput setaf 1)
$(tput sgr0)"
fortune ciencia vida libertad hackers liberacion | cowsay -f ~/.cowsay/small.cow

########################
# Init management
########################

# SSH management
SSH_PID="$XDG_RUNTIME_DIR/ssh-agent.pid"
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$SSH_PID"
fi
if [[ ! "$SSH_AUTH_SOCK" ]] && [[ -f "$SSH_PID" ]]; then
    eval "$(<"$SSH_PID")" > /dev/null
fi

# Start GNU screen
#[[ $TERM != "screen" ]] && exec screen -q

########################
# Shell Variables
########################
export EDITOR="$(if [[ -n $DISPLAY ]]; then echo 'em'; else echo 'emc'; fi)"
export GIT_EDITOR="$(if [[ -n $DISPLAY ]]; then echo 'git-editor'; else echo 'emc'; fi)"
export RANGER_LOAD_DEFAULT_RC=FALSE

#Custom PATH
PATH="/opt/android-sdk/emulator/:/opt/android-sdk/platform-tools/:$HOME/.scripts/:$HOME/.local/bin/:${PATH}"

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

#######################
# Set shell behavior
#######################

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Disable completion when the input buffer is empty.  i.e. Hitting tab
# and waiting a long time for bash to expand all of $PATH.
shopt -s no_empty_cmd_completion

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#############################
# Distribution configuration
#############################

# On Debian set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
    chroot_prompt="${debian_chroot:+($debian_chroot)}"
fi

#######################
# Colors support
#######################

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    [aEkx]term*|rxvt*|gnome*|konsole*|screen|cons25|*color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	    color_prompt=yes
    else
	    color_prompt=no
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${chroot_prompt}\[\e[0;0m\]┌─ \u\[\e[33;1m\]@\h \[\033[01;34m\]\W\[\033[00m\] \[\e[0;1m\]\n└──┤|▶ \[\e[0m\]'
else
    PSI='[${chroot_prompt}\u@\h \W]\$ '
fi
unset color_prompt force_color_prompt

# # Change the window title of X terminals
case ${TERM} in
	[aEkx]term*|rxvt*|gnome*|konsole*|interix)
	    PS1="\[\e]0;${chroot_prompt}\u@\h:\w\a\]$PS1"
		;;
	screen*)
		PS1="\[\033k${chroot_prompt}\u@\h:\w\033\\\]$PS1"
		;;
	*)
		;;
esac

#######################
# Alias definitions
#######################

# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

##########################
# Load additional path
# definitions
##########################

# Guix
[[ -f ~/.guix.sh ]] && . ~/.guix.sh

# NPM/Node.js
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

###########################
# Completion configuration
###########################

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#######################
# Proxy configuration
#######################
if pgrep privoxy > /dev/null; then
    http_proxy="http://localhost:8118"
    https_proxy="http://localhost:8118"
    ftp_proxy="ftp://localhost:8118"
    HTTP_PROXY="http://localhost:8118"
    HTTPS_PROXY="http://localhost:8118"
    FTP_PROXY="ftp://localhost:8118"
fi

