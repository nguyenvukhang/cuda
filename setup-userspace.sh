#!/bin/zsh
# vim:syntax=bash

DEFAULT_NONBASE_ENV='ml'
ZSHRC=~/.zshrc

# create .zshrc if it doesn't exist.
[ ! -f ~/.zshrc ] && touch $ZSHRC

# create the standard portable user binary directory, and add it to path.
mkdir -p ~/.local/bin
echo 'export PATH=$HOME/.local/bin:$PATH' >>$ZSHRC

# link `fd` searcher
ln -s $(which fdfind) ~/.local/bin/fd

# install exa (ls with colors)
curl -fsSLO https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip
unzip -p exa-linux-x86_64-v0.10.1.zip bin/exa >~/.local/bin/exa
rm -rf exa-linux-x86_64-v0.10.1.zip

# install gitnu
curl -fsSLO https://github.com/nguyenvukhang/gitnu/releases/download/v0.7.6/git-nu-v0.7.6-x86_64-unknown-linux-musl.tar.gz
tar -xzvf git-nu-v0.7.6-x86_64-unknown-linux-musl.tar.gz
mv git-nu-v0.7.6-x86_64-unknown-linux-musl/git-nu ~/.local/bin
rm -rf git-nu*

# setup micromamba
micromamba shell init --shell zsh --root-prefix=~/.local/micromamba
source $ZSHRC
micromamba create --name $DEFAULT_NONBASE_ENV --channel conda-forge python=3.10 --yes
micromamba activate $DEFAULT_NONBASE_ENV
micromamba config append channels conda-forge

# make sure micromamba starts by default
echo "micromamba activate $DEFAULT_NONBASE_ENV" >>$ZSHRC
