# Set global variables:
export PATH=$PATH:/usr/local/bin
export EDITOR=vim
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set AWS Tags variables:
export PROJECT={{ lookup('env','PROJECT') }}
export ENVIRONMENT={{ lookup('env','ENVIRONMENT') }}
export TIER={{ lookup('env','TIER') }}
export ROLE={{ lookup('env','ROLE') }}

# Set history variables:
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTTIMEFORMAT=' | %Y-%m-%d %H:%M:%S |'

# Set colors alias and variables:
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Set prompt:
if [ $(id -u) -eq 0 ];
then # you are root, set red colour prompt
  PS1='\[\e[0;35m\]\h \[\e[0;32m\]\w#\[\e[0m\] '
else # normal
  PS1='\[\e[0;32m\]\h \[\e[0;36m\]\w$\[\e[0m\] '
fi
