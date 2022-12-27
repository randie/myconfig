#!/usr/bin/env bash

NOW=$(date +%y%m%d%H%M) 
MYCONFIG=myconfig
ORIGDIR=$(pwd)
HOMEDIR=$(echo ~/tmp/home)
GITHUB_REPO="git@github.com:randie/$MYCONFIG.git"
BARE_REPO="$HOMEDIR/${MYCONFIG}-bare"


#
# install packages and apps with homebrew
#
brew_install_packages() {
    if [[ -x /usr/local/Homebrew/bin/brew ]]
    then
        echo "brew update"
    else
        echo "curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
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
    
    # TODO: install packages one by one, checking first if they exist already
    echo "brew bundle install --file=$b"
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
    echo ">>> 0 $(pwd)"
    if [[ -d ./$MYCONFIG/.git ]]
    then
        TMPDIR=$(pwd)
    else
        TMPDIR=$HOMEDIR/__tmp$NOW
        mkdir -p $TMPDIR && cd $TMPDIR
        git clone $GITHUB_REPO
    fi

    cd $MYCONFIG
    git ls-tree --full-tree -r --name-only HEAD | grep -v README > ../$MYCONFIG-files.txt
    
    cd $HOMEDIR
    tar cf $TMPDIR/$MYCONFIG-backup-$NOW.tar -T $TMPDIR/$MYCONFIG-files.txt
    for f in $(< $TMPDIR/$MYCONFIG-files.txt)
    do
        [[ -e $f ]] && rm -f $f
    done
    echo ">>> 2 $(pwd)"
)}


#=======================#
#                       #
#    M A I N L I N E    #
#                       #
#=======================#

brew_install_packages
create_bare_repo
backup_existing_config
echo ">>> 3 $(pwd)"

# apply your configuration
cd $HOMEDIR
git --git-dir=$BARE_REPO --work-tree=$HOMEDIR config --local status.showUntrackedFiles no
git --git-dir=$BARE_REPO --work-tree=$HOMEDIR checkout


# wrap up
ALIAS_C="alias c=\"git --no-pager --git-dir=$BARE_REPO --work-tree=$HOMEDIR\""
echo
echo "We're done!"
echo
echo Just make sure the following alias is in your .zshrc file:
echo $ALIAS_C
echo
echo Now start up a new shell, and you should be good to go.
echo
