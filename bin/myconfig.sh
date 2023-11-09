#!/usr/bin/env bash

NOW=$(date +%y%m%d%H%M) 
MYCONFIG=myconfig
BARE_REPO="$HOME/${MYCONFIG}-bare"
GITHUB_REPO="git@github.com:randie/$MYCONFIG.git"


#
# install homebrew if not already installed
#
install_homebrew() {
    if [[ ! -x /usr/local/Homebrew/bin/brew ]]
    then
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
        if [[ $? -ne 0 ]]
        then
            echo 'ERROR! Unable to install homebrew ¯\_(ツ)_/¯'
            exit 1
        fi
    fi
}


#
# install packages and apps with homebrew
#
brew_install_packages() {
    install_homebrew

    brewfile=$MYCONFIG/.Brewfile
    if [[ ! -e $brewfile ]]
    then
        echo "ERROR! $(pwd)/$brewfile is missing"
        exit 2
    fi
    
    brew bundle install --file=$brewfile
    if [[ $? -ne 0 ]]
    then
        echo 'ERROR! brew bundle install did not complete successfully'
        exit 3
    fi
}


#
# install oh_my_zsh if not already installed
#
install_oh_my_zsh() {
    echo "WARNING! install_oh_my_zsh() is not implemented yet"
}


#
# back up existing config files that will be replaced
#
backup_existing_config() {(
    # NOTE: The parens enclosing this function creates a subshell
    # and runs this function in the subshell, so cd's are confined
    # to the subshell.

    if [[ -d ./$MYCONFIG/.git ]]
    then
        TMPDIR=$(pwd)
    else
        TMPDIR=$HOME/__tmp$NOW
        mkdir -p $TMPDIR && cd $TMPDIR
        git clone $GITHUB_REPO
    fi

    cd $MYCONFIG
    git ls-tree --full-tree -r --name-only HEAD | grep -v README > ../$MYCONFIG-files.txt
    
    cd $HOME
    tar cf $TMPDIR/$MYCONFIG-backup-$NOW.tar -T $TMPDIR/$MYCONFIG-files.txt
#   for f in $(< $TMPDIR/$MYCONFIG-files.txt)
    for f in $(tar tf $TMPDIR/$MYCONFIG-backup-$NOW.tar)
    do
        [[ -e $f ]] && rm -f $f
    done
)}


apply_my_config() {(
    # NOTE: The parens enclosing this function creates a subshell
    # and runs this function in the subshell, so cd's are confined
    # to the subshell.

    backup_existing_config

    # create a bare repo to track $HOME
    git clone --bare $GITHUB_REPO $BARE_REPO

    # apply my config
    cd $HOME
    git --git-dir=$BARE_REPO --work-tree=$HOME config --local status.showUntrackedFiles no
    git --git-dir=$BARE_REPO --work-tree=$HOME checkout
)}


wrap_up() {
cat << EOF

    Done!

    Make sure the following alias is in your .zshrc file:
        alias c='git --no-pager --git-dir=$BARE_REPO --work-tree=$HOME'
        Usage example: c status -s

    Now start up a new shell, and you should be good to go.
EOF
}  

#=======================#
#                       #
#    M A I N L I N E    #
#                       #
#=======================#

apply_my_config
brew_install_packages
install_oh_my_zsh
wrap_up
