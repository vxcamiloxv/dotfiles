# Set XDG_DATA_DIRS to the default value before Guix appends to it
#export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}"
#export XDG_DATA_DIRS="$HOME/.guix-profile/share:/usr/local/share/:/usr/share/"

# Arrange so that ~/.config/guix/current paths end up first in
# the particular path list.
for profile in "$HOME/.guix-profile" "$HOME/.config/guix/current"
do
    if [ -f "$profile/etc/profile" ]
    then
        # Load the user profile's settings.
        GUIX_PROFILE="$profile" ; \
            . "$profile/etc/profile"
    else
        # At least define this one so that basic things just work
        # when the user installs their first package.
        export PATH="$profile/bin${PATH:+:$PATH}"
        export INFOPATH="$profile/share/info${INFOPATH:+:$INFOPATH}"
    fi
done

unset profile

export GUIX_LOCPATH=$HOME/.guix-profile/lib/locale
