# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PS1="\[\033[1;38;5;39m\]\\$\>\[\033[0m\] "



# User specific aliases and functions
alias ls='ls -ltrh --color=auto'
alias la='ls -ltrha --color=auto'
alias grep='grep -n --color=auto'
