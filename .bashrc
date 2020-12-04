# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User configuration
if [ -f "$HOME/.config/init.sh" ]; then
    . $HOME/.config/init.sh
fi
