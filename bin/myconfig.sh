#!/usr/bin/env bash

NOW=$(date +%y%m%d%H%M) 
MYCONFIG=myconfig
GITHUB_REPO="git@github.com:randie/$MYCONFIG.git"
BARE_REPO="$HOME/${MYCONFIG}-bare"


#
# install packages and apps with homebrew
#
brew_install_packages() {
    if [[ ! -x /usr/local/Homebrew/bin/brew ]]
    then
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
        if [[ $? -ne 0 ]]
        then
            echo 'ERROR! Unable to install homebrew ¯\_(ツ)_/¯'
            exit 1
        fi
    fi

    b=$MYCONFIG/.Brewfile
    if [[ ! -e $b ]]
    then
        echo "ERROR! $(pwd)/$b is missing"
        exit 2
    fi
    
    brew bundle install --file=$b
    if [[ $? -ne 0 ]]
    then
        echo 'ERROR! brew bundle install did not complete successfully'
        exit 3
    fi
}


#
# create a bare github repo to track config files
#
create_bare_repo() {
    git clone --bare $GITHUB_REPO $BARE_REPO
}


#
# back up existing config files that will be replaced
#
backup_existing_config() {(
    # NOTE: The parens surrounding this function is to confine its cd's locally

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
    for f in $(< $TMPDIR/$MYCONFIG-files.txt)
    do
        [[ -e $f ]] && rm -f $f
    done
)}


#=======================#
#                       #
#    M A I N L I N E    #
#                       #
#=======================#

#brew_install_packages
create_bare_repo
backup_existing_config

# apply your configuration
cd $HOME
git --git-dir=$BARE_REPO --work-tree=$HOME config --local status.showUntrackedFiles no
git --git-dir=$BARE_REPO --work-tree=$HOME checkout


# wrap up
ALIAS_C="alias c=\"git --no-pager --git-dir=$BARE_REPO --work-tree=$HOME\""
echo
echo "We're done!"
echo
echo Just make sure the following alias is in your .zshrc file:
echo $ALIAS_C
echo
echo Now start up a new shell, and you should be good to go.
echo
