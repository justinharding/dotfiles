#!/usr/bin/env bash
#
# Usage: ./update.sh [pattern]
#
# Specify [pattern] to update only repos that match the pattern.

repos=(
  # git
  airblade/vim-gitgutter
  tpope/vim-fugitive

  # lots of languages including c++,, go haskell, javascript etc
  sheerun/vim-polyglot
  tpope/vim-commentary
  w0rp/ale

  # run unit tests
  tpope/vim-dispatch
  janko/vim-test

  # c++ swap between header and source
  ericcurtin/CurtineIncSw.vim

  # add endif etc depending on language
  tpope/vim-endwise

  # javascript/json
  # alampros/vim-styled-jsx
  # ap/vim-css-color
  # jparise/vim-graphql
  # pangloss/vim-javascript
  # elzr/vim-json

  # go
  fatih/vim-go.git

  # html/xml
  docunext/closetag.vim

  # markdown
  # plasticboy/vim-markdown

  #ledger
  # ledger/vim-ledger

  # vim
  ervandew/supertab
  haya14busa/incsearch.vim
  scrooloose/nerdtree
  # manage runtime path for plugins
  tpope/vim-pathogen
  # improve "." repeat
  tpope/vim-repeat
  # heuristically set buffer options - shiftwidth etc
  tpope/vim-sleuth
  # show vim registers
  junegunn/vim-peekaboo
  tpope/vim-surround
  # [q ]q etc
  tpope/vim-unimpaired
  # extra text target types in vim
  wellle/targets.vim
  rhysd/accelerated-jk
  easymotion/vim-easymotion

  # search
  junegunn/fzf.vim
  mileszs/ack.vim
  # search for next 2 char match (e.g. sab)
  justinmk/vim-sneak

  # status line
  itchyny/lightline.vim
  jlanzarotta/bufexplorer

  # colours
  altercation/vim-colors-solarized
  arcticicestudio/nord-vim
  nanotech/jellybeans.vim
  rakr/vim-one
  sonph/onehalf
  tomasr/molokai
  vim-scripts/wombat256.vim

  # text alignment
  godlygeek/tabular

  # interact with database like postgres
  # tpope/vim-dadbod
)

set -e
dir=~/.config/nvim/bundle

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
