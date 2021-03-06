# vim:ft=zsh:ts=2:sw=2:sts:et:

# OH-MY-ZSH {{{1
# added following line to stop error 
# [oh-my-zsh] Insecure completion-dependent directories detected:
# /usr/local/share
# For safety, we will not load completions from these directories until
# you fix their permissions and ownership and restart zsh.
# See the above list for directories with group or other writability.
ZSH_DISABLE_COMPFIX=true

# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/justin/.oh-my-zsh"

DEFAULT_USER="justin"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# ZSH_THEME="pygmalion"
# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
# ZSH_THEME="mine"
# ZSH_THEME="powerlevel9k/powerlevel9k"
# POWERLEVEL9K_MODE='awesome-fontconfig'
# POWERLEVEL9K_MODE='awesome-patched'

# autoload -U promptinit; promptinit
# prompt pure

eval "$(starship init zsh)"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(osx git brew history vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# INTERNAL UTILITY FUNCTIONS {{{1

# Returns whether the given command is executable or aliased.
_has() {
  return $( whence $1 >/dev/null )
}

# Returns whether the given statement executed cleanly. Try to avoid this
# because this slows down shell loading.
_try() {
  return $( eval $* >/dev/null 2>&1 )
}

# Returns whether the current host type is what we think it is. (HOSTTYPE is
# set later.)
_is() {
  return $( [ "$HOSTTYPE" = "$1" ] )
}

# Returns whether out terminal supports color.
_color() {
  return $( [ -z "$INSIDE_EMACS" ] )
}

# ENVIRONMENT VARIABLES {{{1

# Yes, this defeats the point of the TERM variable, but everything pretty much
# uses modern ANSI escape sequences. I've found that forcing everything to be
# "rxvt" just about works everywhere. (If you want to know if you're in screen,
# use SHLVL or TERMCAP.)
if _color; then
  if [ -n "$ITERM_SESSION_ID" ]; then
    if [ "$TERM" = "screen" ]; then
      export TERM=screen-256color
    else
      export TERM=xterm-256color
    fi
  elif [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
      export TERM=xterm-256color
  else
    export TERM=rxvt
  fi
else
  export TERM=xterm
fi

# Utility variables.
if which hostname >/dev/null 2>&1; then
  HOSTNAME=`hostname`
elif which uname >/dev/null 2>&1; then
  HOSTNAME=`uname -n`
else
  HOSTNAME=unknown
fi
export HOSTNAME

# HOSTTYPE = { Linux | OpenBSD | SunOS | etc. }
if which uname >/dev/null 2>&1; then
  HOSTTYPE=`uname -s`
else
  HOSTTYPE=unknown
fi
export HOSTTYPE

# PAGER
if [ -n "$INSIDE_EMACS" ]; then
  export PAGER=cat
else
  if _has less; then
    export PAGER=less
    if _color; then
      export LESS='-R'
    fi
  fi
fi

# EDITOR
if _has nvr; then
  export EDITOR=nvr VISUAL=nvr
elif _has vim; then
  export EDITOR=vim VISUAL=vim
elif _has vi; then
  export EDITOR=vi VISUAL=vi
elif _has emacs; then
  export EDITOR=emacs VISUAL=emacs
fi

# Overridable locale support.
if [ -z $$LC_ALL ]; then
  export LC_ALL=C
fi
if [ -z $LANG ]; then
  export LANG=en_US
fi

# History control. Don't bother with history if we can't write to the file,
# like if we're using sudo.
if [ -w ~/.zsh_history -o -w ~ ]; then
  SAVEHIST=100000
  HISTSIZE=100000
  HISTFILE=~/.zsh_history
fi

# APPLICATION CUSTOMIZATIONS {{{1

# GNU grep
if _color; then
  export GREP_COLOR='1;32'
fi

# GNU and BSD ls colorization.
if _color; then
  export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=33:so=01;35:bd=33;01:cd=33;01:or=01;05;37;41:mi=01;37;41:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:'
  export LSCOLORS='ExGxFxdxCxDxDxcxcxxCxc'
  export CLICOLOR=1
fi

# rg or repgrep
# use config file in current directory
export RIPGREP_CONFIG_PATH=./.ripgreprc

# PATH MODIFICATIONS {{{1

# Functions which modify the path given a directory, but only if the directory
# exists and is not already in the path. (Super useful in ~/.zshlocal)

_prepend_to_path() {
  if [ -d $1 -a -z ${path[(r)$1]} ]; then
    path=($1 $path);
  fi
}

_append_to_path() {
  if [ -d $1 -a -z ${path[(r)$1]} ]; then
    path=($path $1);
  fi
}

_force_prepend_to_path() {
  path=($1 ${(@)path:#$1})
}

# Note that there is NO dot directory appended!

_force_prepend_to_path /usr/local/sbin
_force_prepend_to_path /usr/local/bin
_force_prepend_to_path ~/bin
# _force_prepend_to_path /usr/local/heroku/bin

# the next line causes us to use gnu utils instead of the apple bsd versions
_prepend_to_path /usr/local/opt/coreutils/libexec/gnubin

_append_to_path /usr/sbin

# Add our docs, too
export INFOPATH=$HOME/.dotfiles/info:$INFOPATH

# ALIASES {{{1

alias Ac='sudo apt autoclean'
alias Ag='sudo apt install'
alias Ai='apt show'
alias Ar='sudo apt remove'
alias Arm='sudo apt autoremove'
alias Arp='sudo apt remove --purge'
alias As='apt search'
alias VU='~/.vim/update.sh'
alias ZL='vi ~/.zshlocal ~/.zshrc ; ZR'
alias ZR='echo "Restarting zsh..." ; exec zsh -l'
alias ZU='~/.dotfiles/install.sh && ZR'
alias ZshInstall='~/.dotfiles/install.sh && ZR'
alias ZshRehash='. ~/.zshrc'
alias aag='agg'
alias agg='_agg () { rg --group $@ | less }; _agg'
alias bc='bc -l'
alias cr2lf="perl -pi -e 's/\x0d/\x0a/gs'"
alias curltime='curl -w "@$HOME/.curl-format" -o /dev/null -s'
alias d='docker'
alias dc='docker-compose'
alias df='df -H'
alias dls='dpkg -L'
alias dotgit='/usr/local/bin/git --git-dir=$HOME/.dotgit/ --work-tree=$HOME'
alias dotenv="eval \$(egrep -v '^#' .env | xargs)"
alias dsl='dpkg -l | grep -i'
alias e='emacs'
alias ec='emacsclient --no-wait'
alias f1="awk '{print \$1}'"
alias f2="awk '{print \$2}'"
alias f2k9='f2k -9'
alias f2k='f2 | xargs -t kill'
alias f='fg'
alias fixssh='eval $(tmux showenv -s SSH_AUTH_SOCK)'
alias gpgdecrypt='gpg --decrypt-files'
alias gpgencrypt='gpg --default-recipient-self --armor --encrypt-files'
alias i4='sed "s/^/    /"'
alias icat='lsbom -f -l -s -pf'
alias iinstall='sudo installer -target / -pkg'
alias ils='ls /var/db/receipts/'
alias ishow='pkgutil --files'
alias k='tree -h'
alias l="ls -lh"
alias ll="l -a"
alias lt='ls -lt'
alias ltr='ls -ltr'
alias ndu='node --debug-brk =nodeunit'
alias nerdcrap='cat /dev/urandom | xxd | grep --color=never --line-buffered "be ef"'
alias netwhat='lsof -i +c 40'
alias nmu='nodemon =nodeunit'
alias notifydone='terminal-notifier -message Done.'
alias pt='pstree -pul'
alias px='pilot-xfer -i'
alias rake='noglob rake'
alias rgg='_rgg () { rg --color always --heading $@ | less }; _rgg'
alias ri='ri -f ansi'
alias rls='screen -ls'
alias rrg='rgg'
alias rsync-usual='rsync -azv -e ssh --delete --progress'
alias rxvt-invert="echo -n '[?5t'"
alias rxvt-scrollbar="echo -n '[?30t'"
alias scp='scp -C -p'
alias screen='screen -U'
alias slurp='wget -t 5 -c -nH -r -k -p -N --no-parent'
alias sshx='ssh -C -c blowfish -X'
# alias t='tmux attach'
alias tree="tree -F -A -I CVS"
alias tt='tail -n 9999'
alias wgetdir='wget -r -l1 -P035 -nd --no-parent'
alias whois='whois -h geektools.com'
alias y='yarn'
alias ye='yarn exec'
alias ya='_ya () { yarn add $@ ; yarn add -D @types/$@ }; _ya'
alias yr='_yr () { yarn remove $@ ; yarn remove -D @types/$@ }; _yr'
alias x='screen -A -x'
alias xxx='histring "XXX.*" -c green -s bold'
# Interactive/verbose commands.
alias mv='mv -i'
for c in cp rm chmod chown rename; do
  alias $c="$c -v"
done

# Make sure vim/vi always gets us an editor.
if _has vim; then
  alias vi=nvim
  vs() { nvim +"NERDTree $1" }
  gvs() { gvim +"NERDTree $1" }
else
  alias vim=vi
fi
if ! _has gvim && _is Darwin; then
  alias gvim='open -a "MacVim"'
fi

if _has rg; then
  alias rg='rg --colors path:fg:green --colors match:fg:red'
  alias ag=rg
  alias ack=rg
elif _has ag; then
  alias ack=ag
  alias ag='ag --color-path 1\;31 --color-match 1\;32 --color'
elif _has ack; then
  if ! _color; then
    alias ack='ack --nocolor'
  fi
fi

# Nico is amazing for showing me this.
alias v='nvim -R -'
for i in /usr/share/vim/vim*/macros/less.sh(N) ; do
  alias v="$i"
done

if _is Darwin; then
  alias strace='sudo dtruss -f sudo -u $USER'
fi

alias typora="open -a typora"

# some maths conversion utils
alias dec2hex="printf '%x\n'"
alias hex2dec="printf '%d\n'"
# FUNCTIONS {{{1

# ack is really useful. I usually look for code and then edit all of the files
# containing that code. Changing `ack' to `vack' does this for me.
if _has rg; then
  vack() {
    nvim `rg --color=never -l $@`
  }
elif _has ag; then
  vack() {
    nvim `ag --nocolor -l $@`
  }
else
  vack() {
    nvim `ack -l $@`
  }
fi
alias vag=vack
alias vrg=vack

# ..same thing with gg.
vgg() {
  nvim `gg -l $@`
}

# Quick commands to sync CWD between terminals.
pin() {
  rm -f ~/.pindir
  echo $PWD >~/.pindir
  chmod 0600 ~/.pindir >/dev/null 2>&1
}
pout() {
  cd `cat ~/.pindir`
}

# A quick grep-for-processes.
psl() {
  if _is SunOS; then
    ps -Af | grep -i $1 | grep -v grep
  else
    ps auxww | grep -i $1 | grep -v grep
  fi
}

# Make a new command.
vix() {
  if [ -z "$1" ]; then
    echo "usage: $0 <newfilename>"
    return 1
  fi
  touch $1
  chmod -v 0755 $1
  $EDITOR $1
}

# Make a new command in ~/bin
makecommand() {
  if [ -z "$1" ]; then
    echo "Gotta specify a command name, champ" >&2
    return 1
  fi

  mkdir -p ~/bin
  local cmd=~/bin/$1
  if [ -e $cmd ]; then
    echo "Command $1 already exists" >&2
  else
    echo "#!${2:-/bin/sh}" >$cmd
  fi

  vix $cmd
}

# View a Python module in Vim.
vipy() {
  p=`python -c "import $1; print $1.__file__.replace('.pyc','.py')"`
  if [ $? = 0 ]; then
    vi -R "$p"
  fi
  # errors will be printed by python
}

rxvt-title() {
  echo -n "]2;$*"
}

screen-title() {
  echo -n "k$*\\"
}

# need to execute bw login <username> first, then follow instructions
bwget() {
  bw list items --search "$1"| jq '.[] | .name, .login.uris, .login.username, .login.password'
}
bwgetcard() {
bw list items --search "$1"| jq '.[] | .name,.card.cardholderName,.card.number,.card.expMonth,.card.expYear,.card.code'
}

# alias tf="~/TEE-CLC-14.114.0/tf"

# export PATH="/Users/justin/.bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"

# added the following line to support gnucash python
export PYTHONPATH=$PYTHONPATH:/opt/local/lib/python2.7/site-packages

# these two are to make sed work in a find command - not a perfect solution - see url
# http://stackoverflow.com/questions/19242275/re-error-illegal-byte-sequence-on-mac-os-x
# export LC_CTYPE=C 
# export LANG=C


# used by nvr to talk to nvim
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket


ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

ZSH_AUTOSUGGEST_USE_ASYNC=true
test -e "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" && source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# android sdk
if [ -d "${HOME}/Library/Android/sdk" ]
then
    export ANDROID_HOME=${HOME}/Library/Android/sdk
    export PATH=${PATH}:${ANDROID_HOME}/tools
    export PATH=${PATH}:${ANDROID_HOME}/platform-tools
fi

# java - switch between versions
# alias j12="export JAVA_HOME=`/usr/libexec/java_home -v 12`; java -version"
# alias j11="export JAVA_HOME=`/usr/libexec/java_home -v 11`; java -version"
# alias j10="export JAVA_HOME=`/usr/libexec/java_home -v 10`; java -version"
# alias j9="export JAVA_HOME=`/usr/libexec/java_home -v 9`; java -version"
# alias j8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version"
# alias j7="export JAVA_HOME=`/usr/libexec/java_home -v 1.7`; java -version"


fpath=(/usr/local/share/zsh-completions $fpath)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# tfs
#alias tf="~/TEE-CLC-14.114.0/tf"
# beyond compare
#export TF_DIFF_COMMAND="bcomp %1 %2 -title1=%6 -title2=%7"

# # fzf
# export FZF_DEFAULT_COMMAND='ag --ignore *.pyc -g ""'
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# fzf via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# fzf + ag configuration
if _has fzf && _has ag; then
  export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS='
  --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
  --color info:108,prompt:109,spinner:108,pointer:168,marker:168
  '
fi

if _has rg; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
fi

# bitwarden completions via Homebrew
if [ -e /usr/local/bin/bw ]; then
  eval "$(bw completion --shell zsh); compdef _bw bw;"
fi

# z utility for jumping around directories
. /usr/local/etc/profile.d/z.sh

#nvm and node
export NODE_PATH='/usr/local/lib/node_modules'
export NVM_LAZY_LOAD=true
plugins+=(zsh-nvm)

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion export PATH="/usr/local/sbin:$PATH"

##### nvm (node version manager) #####
# placeholder nvm shell function
# On first use, it will set nvm up properly which will replace the `nvm`
# shell function with the real one
nvm() {
  if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
    # shellcheck disable=SC1090
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion


    # source "${NVM_DIR}/nvm.sh"
    # if [[ -e ~/.nvm/alias/default ]]; then
    #   PATH="${PATH}:${HOME}.nvm/versions/node/$(cat ~/.nvm/alias/default)/bin"
    # fi
    # # invoke the real nvm function now
    nvm "$@"
  else
    echo "nvm is not installed" >&2
    return 1
  fi
}



# function load-nvm () {
#   if [[ $OSTYPE == "darwin"* ]]; then
#     # export NVM_DIR=~/.nvm
#     # [[ -s $(brew --prefix nvm)/nvm.sh ]] && source $(brew --prefix nvm)/nvm.sh
#     export NVM_DIR="$HOME/.nvm"
#     echo "about to $NVM_DIR/nvm.sh"
#     [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#     echo "about to $NVM_DIR/bash_completion"
#     [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion export PATH="/usr/local/sbin:$PATH"
#     echo "done"
#   fi
# }

# load-nvmrc() {
# if [[ -f .nvmrc && -r .nvmrc ]]; then
#   if ! type nvm >/dev/null; then
#     load-nvm
#   fi
#   nvm use
# elif [[ -f ./node_modules/is-symbol/.nvmrc && -r ./node_modules/is-symbol/.nvmrc ]]; then
#   pushd ./node_modules/is-symbol
#   if ! type nvm >/dev/null; then
#     load-nvm
#   fi
#   nvm use
#   popd
# fi
# }
# add-zsh-hook chpwd load-nvmrc

# initialise pyenv for switching between python versions
eval "$(pyenv init -)"

# to run local python packages
export PATH=$PATH:/Users/justin/Library/Python/2.7/bin

# if we wanted python3 packages we would enable this line instead/aw well
# export PATH=$PATH:/Users/justin/Library/Python/3.6/bin

# support pipenv - local python environments
export PATH=$PATH:/Users/justin/.local/bin

# google search from terminal
function google() { open /Applications/Safari.app/ "http://www.google.com/search?q= $1"; }


export PATH="/usr/local/sbin:$PATH"

# ledger time tracking
export TIMELOG=~/docs/work/admin/work.timeclock
export TIMELOG_STARTOFWEEK=mon

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/justin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/justin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/justin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/justin/google-cloud-sdk/completion.zsh.inc'; fi

# export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
