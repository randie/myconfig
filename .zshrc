# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(autojump git zsh-autosuggestions zsh-syntax-highlighting)
plugins=(autojump git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh


#==========================#
#                          #
#    User configuration    #
#                          #
#==========================#

set -o allexport

# local hostname
[[ $(uname -s) == Darwin ]] && HOSTNAME=$(scutil --get LocalHostName) || HOSTNAME=$(uname -n)

# preferred editor for local and remote sessions
[[ -n $SSH_CONNECTION ]] && EDITOR=vim || EDITOR=mvim
VISUAL=$EDITOR
FCEDIT=$EDITOR
PAGER=less 

# compilation flags
# ARCHFLAGS="-arch x86_64"

# MANPATH="/usr/local/man:$MANPATH"
# LANG=en_US.UTF-8
PATH=$PATH:$HOME/bin

set +o allexport

#
# aliases
#
alias a=alias
alias cp='cp -i'
alias d='dirs -v'
alias dirs='dirs -v'
alias h=history
alias ss='save -s'
alias killdock='killall -KILL Dock'
alias lsa='ls -a'
alias mv='mv -i'
alias rm='rm -i'
#alias shred='srm -rv'
alias sshjj='ssh -i ~/.ssh/hostgator_rsa jj@108.179.232.68 -p2222'
#
# git aliases
#
alias g='git --no-pager'
alias gs='git status -s'
alias gm='git merge --no-commit --no-ff'
alias gci='git commit --verbose'
alias gita='alias | grep git | grep'
alias glol='git --no-pager log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'
savepy='gs | grep py | grep " M" | cut -d " "  -f3 | xargs save -s'
#
# myconfig aliases
#
alias c='git --no-pager --git-dir=/Users/randie/myconfig-bare --work-tree=/Users/randie'
alias ca='c add'
alias ci='c commit --verbose'
alias co='c checkout'
alias cs='c status -s'
alias cpu='c push'
alias clo='c log --oneline --decorate'
alias clog='c log --oneline --decorate --graph'
alias clol='c log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'
alias cls='c ls-tree --full-tree -r --name-only HEAD'

#
# shell options
#
#set -o vi
setopt vi
setopt NOCLOBBER
setopt RM_STAR_WAIT
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY 

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Activate autojump (an iterm2 plugin)
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Shell integration with vscode
#[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(/usr/local/bin/code --locate-shell-integration-path zsh)"

#===========================#
#                           #
#   Convenience Functions   #
#                           #
#===========================#

s() {
    echo "$HOME/save/$(date +%y%m%d)"
}

shred() {
  if [[ -z "$1" ]]; then
    echo "Usage: shred <filename>"
    return 1
  fi

  local file="$1"

  if [[ ! -f "$file" ]]; then
    echo "ERROR! '$file' is not a valid file."
    return 1
  fi

  local file_size=$(stat -f%z "$file")
  local block_count=$((($file_size + 1048575) / 1048576))

  dd if=/dev/urandom of="$file" bs=1m count="$block_count" status=progress 2>/dev/null
  \rm -f "$file"

  echo "Poof! $file is gone."
}

dc() {
  local cmd="$1"
  shift
  echo "╰─❯ docker-compose --env-file docker-compose.env ${cmd} --remove-orphans --build $@"
  docker-compose --env-file docker-compose.env "$cmd" --remove-orphans --build "$@"
}

#====================#
#                    #
#   Anaconda Stuff   #
#                    #
#====================#

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

