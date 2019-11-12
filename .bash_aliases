## Modified commands
alias s="screen"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias l='ls -CF'
function cdl { cd $1; ls;}
#alias ssh="~/.scripts/ssh/ssh-ident"

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Utility commands
alias mpc="ncmpcpp"
alias emc="em -nw"
alias mu4e="em -c -n --eval '(mu4e)'"
alias apagar="sudo shutdown -h 14:20"
alias acortar='curl -s "http://is.gd/create.php?format=simple&url=`xsel -po`" | xsel -pi'
alias bajar="plowdown"
alias subir="plowup"
alias search-word="find . -type f -print0 | xargs -0 grep -l $1"
alias jpg-optimized="find . -name *.jpg -exec jpegoptim --max=80 -t '$i' {} \;"
alias prime-enable="export DRI_PRIME=1"
alias prime-disable="export DRI_PRIME=0"

# Custom ~/.scripts commands
alias pass="$HOME/.scripts/passp"
alias pomf="$HOME/.scripts/pomf.py"
alias pomf-w="$HOME/.scripts/scrotpomf.sh"
alias capas2png="$HOME/.scripts/Inkscape/layers2pngs.py"
alias tvgnu="$HOME/.scripts/TVenGNU.sh"
alias hastebin="$HOME/.scripts/haste.sh"
alias haste="HASTE_SERVER=http://vte.distopico.info haste"
alias davpush="$HOME/.scripts/davpush.pl"

# Virtualenv
vePath="$HOME/.virtualenv/bin"
alias lstream="${vePath}/livestreamer-curses"

# Alias directories
alias home="cd $HOME/"
alias musica="cd $HOME/Music"
alias descargas="cd $HOME/Downloads"
alias escritorio="cd $HOME/Desktop"
alias publico="cd $HOME/Public"
alias videos="cd $HOME/Videos"
alias imagenes="cd $HOME/Pictures"

# Update Grub2 Parabola
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# Pkg manager
alias repo="sudo add-apt-repository $1"
alias build-dep="sudo apt-get build-dep $1"
alias update-full="sudo aptitude full-upgrade -y && sudo aptitude clean"
alias search-app="sudo aptitude search"
alias dist-upgrade="sudo apt-get dist-upgrade"
