# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Returns whether the given command is executable or aliased.
_has() {
  return $( whence $1 >/dev/null )
}

# Path to your oh-my-zsh installation.
export ZSH=/Users/justin/.oh-my-zsh

DEFAULT_USER="justin"

# Set name of the theme to load. Optionally, if you set this to "random"
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# ZSH_THEME="pygmalion"
# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
# ZSH_THEME="mine"
ZSH_THEME="powerlevel9k/powerlevel9k"
# POWERLEVEL9K_MODE='awesome-fontconfig'
# POWERLEVEL9K_MODE='awesome-patched'

# autoload -U promptinit; promptinit
# prompt pure

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(osx git brew history vi-mode)
# User configuration

export PATH="/Users/justin/.bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"
# export MANPATH="/usr/local/man:/opt/local/share/man:$MANPATH"

# added the following line to support gnucash python
export PYTHONPATH=$PYTHONPATH:/opt/local/lib/python2.7/site-packages
source $ZSH/oh-my-zsh.sh

# these two are to make sed work in a find command - not a perfect solution - see url
# http://stackoverflow.com/questions/19242275/re-error-illegal-byte-sequence-on-mac-os-x
# export LC_CTYPE=C 
# export LANG=C

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# used by nvr to talk to nvim
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

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
# alias tf="~/TEE-CLC-14.114.0/tf"

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

test -e "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" && source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# android sdk
if [ -d "~/Library/Android/sdk" ]
then
    export ANDROID_HOME=~/Library/Android/sdk
    export PATH=${PATH}:${ANDROID_HOME}/tools
    export PATH=${PATH}:${ANDROID_HOME}/platform-tools
fi

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
    source "${NVM_DIR}/nvm.sh"
    if [[ -e ~/.nvm/alias/default ]]; then
      PATH="${PATH}:${HOME}.nvm/versions/node/$(cat ~/.nvm/alias/default)/bin"
    fi
    # invoke the real nvm function now
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



# to run local python packages
export PATH=$PATH:/Users/justin/Library/Python/2.7/bin

# if we wanted python3 packages we would enable this line instead/aw well
# export PATH=$PATH:/Users/justin/Library/Python/3.6/bin

# google search from terminal
function google() { open /Applications/Safari.app/ "http://www.google.com/search?q= $1"; }


export PATH="/usr/local/sbin:$PATH"

# ledger time tracking
export TIMELOG=/Users/justin/Dropbox/work/admin/work.timeclock
function ti() { echo i `date '+%Y-%m-%d %H:%M:%S'` "$1  ${@:2}" >>$TIMELOG }
function to() { echo o `date '+%Y-%m-%d %H:%M:%S'` >>$TIMELOG }

# alias ti="echo i `date '+%Y-%m-%d %H:%M:%S'` \$* >>$TIMELOG"
# alias to="echo o `date '+%Y-%m-%d %H:%M:%S'` >>$TIMELOG"

