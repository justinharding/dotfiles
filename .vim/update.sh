#!/usr/bin/env bash
#
# Usage: ./update.sh [pattern]
#
# Specify [pattern] to update only repos that match the pattern.

repos=(

  airblade/vim-gitgutter
  alampros/vim-styled-jsx
  ap/vim-css-color
  docunext/closetag.vim
  ervandew/supertab
  haya14busa/incsearch.vim
  itchyny/lightline.vim
  jparise/vim-graphql
  junegunn/fzf.vim
  mileszs/ack.vim
  qpkorr/vim-bufkill
  scrooloose/nerdtree
  sheerun/vim-polyglot
  statico/vim-inform7
  tpope/vim-commentary
  tpope/vim-dadbod
  tpope/vim-endwise
  tpope/vim-eunuch
  tpope/vim-fugitive
  tpope/vim-pathogen
  tpope/vim-repeat
  tpope/vim-rhubarb
  tpope/vim-sleuth
  tpope/vim-surround
  tpope/vim-unimpaired
  w0rp/ale
  wellle/targets.vim

  altercation/vim-colors-solarized
  arcticicestudio/nord-vim
  nanotech/jellybeans.vim
  rakr/vim-one
  sonph/onehalf
  tomasr/molokai
  vim-scripts/wombat256.vim

  rhysd/accelerated-jk
  ledger/vim-ledger

  pangloss/vim-javascript
  fatih/vim-go.git

  junegunn/goyo.vim
  junegunn/limelight.vim

  godlygeek/tabular
  elzr/vim-json
  plasticboy/vim-markdown
)

set -e
dir=~/.dotfiles/.vim/bundle

if [ -d "$dir" -a -z "$1" ]; then
  temp="$(mktemp -d -t bundleXXXXX)"
  echo "▲ Moving old bundle dir to $temp"
  mv "$dir" "$temp"
fi

mkdir -p "$dir"

for repo in ${repos[@]}; do
  if [ -n "$1" ]; then
    if ! (echo "$repo" | grep -i "$1" &>/dev/null) ; then
      continue
    fi
  fi
  plugin="$(basename $repo | sed -e 's/\.git$//')"
  [ "$plugin" = "vim-styled-jsx" ] && plugin="000-vim-styled-jsx" # https://goo.gl/tJVPja
  dest="$dir/$plugin"
  rm -rf "$dest"
  (
    git clone --depth=1 -q "https://github.com/$repo" "$dest"
    rm -rf "$dest/.git"
    echo "· Cloned $repo"
    [ "$plugin" = "onehalf" ] && (mv "$dest" "$dest.TEMP" && mv "$dest.TEMP/vim" "$dest" && rm -rf "$dest.TEMP")
  ) &
done
wait
