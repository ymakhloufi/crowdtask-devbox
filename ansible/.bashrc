# localedef -v -c -i de_DE -f UTF-8 de_DE.UTF-8 
[ -z "$PS1" ] && return

export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTCONTROL=ignoreboth
shopt -s histappend
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
    usercolor="01;33m";
    if [[ $USER == "root" ]]; then
        usercolor="01;31m";
    fi
    if [[ $USER == "vagrant" ]]; then
        usercolor="00;36m";
    fi
    if [[ $(hostname -s) = localhost* ]]; then
        if [[ $USER == "root" ]]; then
            usercolor="00;34m";
        fi
    fi
    PS1="[\$?] ${debian_chroot:+($debian_chroot)}\[\033[$usercolor\]\u \[\033[00m\]@ \[\033[0;32m\]\h\[\033[00m\]: \[\033[1;35m\]\w\[\033[0;37m\] \[\033[0;30;46m\$(git branch 2>/dev/null | grep '^*' | colrm 1         2)\\033[0;37m\]\n$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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
    eval "`dircolors -b`"
    alias ls='ls --color=auto --group-directories-first'
fi

# list
alias l='ls'
alias ll='LC_COLLATE="C.UTF-8" ls -lh --group-directories-first --time-style=+"%b %d %Y %H:%M:%S"'
alias la='ll -A'
alias a='la'
alias al='la'
alias öa='la'
alias ala='la'

# files and directories
alias cp='cp -r'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ssh
alias ssh='ssh -A'

# system
alias ns='netstat -tanp'
alias nsg='ns | grep' 
alias ps='ps aux'
alias psg='ps | grep'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias grr='grep -r'

# dev
alias cdc='cd ~/code'
alias sql='cd ~/code/sql'
alias api='cd ~/code/api'
alias flux='cd ~/code/flux'
alias car='cd ~/code/carrot'
alias ng='cd ~/code/angular'
alias pa='php artisan'
alias cu='composer update'
alias cda='composer dump-autoload'
alias ci='composer install'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# include composer and node (npm, bower, grunt) in $PATH
export PATH=$PATH:"~/.composer/vendor/bin/:/opt/node/bin/:~/code/api/vendor/bin/"

# allow invocation of bash commands via ssh
shopt -s expand_aliases

# Load SSH keys for agent handover (see ssh alias above, -A option)
printf "bootstrapping SSH agent ...\n"
eval "$(ssh-agent -s)" &>/dev/null

export CARROT_MYSQL_USER='carrot'
export CARROT_MYSQL_PASSWORD='studidev'
export CARROT_MYSQL_MIGRATE_USER='carrot_migrate'
export CARROT_MYSQL_MIGRATE_PASSWORD='studidev'
export CARROT_MYSQL_HOST='localhost'
export CARROT_MYSQL_DRUPAL_DB='studi_drupal'
export CARROT_MYSQL_API_DB='studi_api'
