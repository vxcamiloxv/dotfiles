# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return
#[[ $- != *i* ]] && return
# Start GNU Screen
alias screen="screen -aAxRl"
#[[ -z "$STY" ]] && screen


# SSH managment
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  ssh-agent > ~/.ssh-agent-pid
fi
if [[ "$SSH_AGENT_PID" == "" ]] && [[ -f "~/.ssh-agent-pid" ]]; then
  eval "$(<~/.ssh-agent-pid)" > /dev/null
fi

# Set Default Editor
export EDITOR="$(if [[ -n $DISPLAY ]]; then echo 'em'; else echo 'emc'; fi)"
export GIT_EDITOR="$(if [[ -n $DISPLAY ]]; then echo 'git-editor'; else echo 'emc'; fi)"
export RANGER_LOAD_DEFAULT_RC=FALSE

# Alias General
alias tunelCps="ssh cquimbayo@104.198.196.141 -L 5433:localhost:5432 -L 6480:localhost:6480 -L 3307:localhost:3306"
alias how="~/Documents/Development/App/node_modules/phonegap/bin/phonegap.js"
alias how-cordova="~/Documents/Development/App/node_modules/cordova/bin/cordova"
alias appmap="~/appMap/node_modules/phonegap/bin/phonegap.js"
alias appmap_cordova="~/appMap/node_modules/cordova/bin/cordova"
alias s="screen"
#alias ssh="~/.scripts/ssh/ssh-ident"

# Alias Work
alias cps="cd ~/Documents/Development/CPS"
alias cpsCity="cps && cd cps-repos/branch/version2city/mobileApp/cpsApp"
alias cpsApp="cps && cd cps-repos/branch/version2cr/mobileApp/cpsApp"
alias cpsPhonegap="../node_modules/phonegap/bin/phonegap.js"
alias cpsCordova="../node_modules/cordova/bin/cordova"

# Alias Utils
alias apagar="sudo shutdown -h 14:20"
alias acortar='curl -s "http://is.gd/create.php?format=simple&url=`xsel -po`" | xsel -pi'
alias search-word="find . -type f -print0 | xargs -0 grep -l $1"
alias jpg-optimized="find . -name *.jpg -exec jpegoptim --max=80 -t '$i' {} \;"
alias mpc="ncmpcpp"
alias emc="em -nw"
alias mu4e="em -c -n --eval '(mu4e)'"
alias prime_enable="export DRI_PRIME=1"
alias prime_disable="export DRI_PRIME=0"

# Alias .scripts home
alias pomf="$HOME/.scripts/pomf.py"
alias pomf-w="$HOME/.scripts/scrotpomf.sh"
alias capas2png="$HOME/.scripts/Inkscape/layers2pngs.py"
alias tvgnu="$HOME/.scripts/TVenGNU.sh"
alias hastebin="$HOME/.scripts/haste.sh"
alias haste="HASTE_SERVER=http://vte.ardervegan.info haste"
alias davpush="$HOME/.scripts/davpush.pl"
alias lessw="node $HOME/.scripts/node/lessw.js"

# Alias Virtualenv
vePath="$HOME/.virtualenv/bin"
alias lstream="${vePath}/livestreamer-curses"

# muestra directorios
function cdl { cd $1; ls;}
alias home="cd $HOME/"
alias musica="cd $HOME/Música"
alias descargas="cd $HOME/Descargas"
alias escritorio="cd $HOME/Escritorio"
alias publico="cd $HOME/Público"
alias videos="cd $HOME/Videos"
alias imagenes="cd $HOME/Imágenes"

# Agregar repositorios
alias repo="sudo add-apt-repository $1"

# Actalizar Grub2 Parabola
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# Construir dependencias
alias dependencias="sudo apt-get build-dep $1"

# Alias Plowshare
alias bajar="plowdown"
alias subir="plowup"

#bajar flash
alias flash="get_flash_videos"
alias video="movgrab"

# Alias para aptitude
alias actualizar="sudo aptitude update"
alias update-full="sudo aptitude full-upgrade -y && sudo aptitude clean"
alias buscar-app="sudo aptitude search"
alias instalar="sudo aptitude install $1"
alias quitar="sudo aptitude remove -purge z"
alias crean="sudo aptitude clean"

# Alias para apt-get
alias install="sudo apt-get install $1"
alias remove="sudo apt-get remove $1"
alias purge="sudo apt-get purge $1"
alias update="sudo apt-get update"
alias dist-upgrade="sudo apt-get dist-upgrade"
alias buscarPaquete="apt-cache search"
alias limpiar="sudo apt-get autoclean"

#Custom PATH
PATH="$HOME/.guix-profile/bin:$HOME/.config/guix/current/bin:${PATH}:/opt/android-sdk/tools/:/opt/android-sdk/platform-tools/:$HOME/.scripts/"

# Start GNU screen
#[[ $TERM != "screen" ]] && exec screen -q

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

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

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='\[\e[0;0m\]┌─ \u\[\e[33;1m\]@\h \[\033[01;34m\]\W\[\033[00m\] \[\e[0;1m\]\n└──┤|▶ \[\e[0m\]'
else
    PSI='[\u@\h \W]\$ '
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# GUIX
GUIX_PROFILE="$HOME/.guix-profile"
if [ -f "$GNIX_PROFILE" ]; then
    . "$GUIX_PROFILE/etc/profile"
fi

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#MOTD


echo "$(tput setaf 2)
                               |
     __                        |  GNU en `hostname`
    |__)_  _ _ |_  _ | _       |  `date +"%A, %e %B %Y, %r"`
    |  (_|| (_||_)(_)|(_|      |  Linux-Libre `uname -rm`
  ===========================  |  $(tput setaf 1)
$(tput sgr0)"
fortune ciencia vida libertad hackers liberacion | cowsay -f ~/.cowsay/small.cow

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# NPM/Node.js

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
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

## Proxy
http_proxy="http://localhost:8118"
https_proxy="http://localhost:8118"
ftp_proxy="ftp://localhost:8118"
HTTP_PROXY="http://localhost:8118"
HTTPS_PROXY="http://localhost:8118"
FTP_PROXY="ftp://localhost:8118"

