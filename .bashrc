# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User configuration
if [ -f "$HOME/init.sh" ]; then
    . $HOME/init.sh
fi
