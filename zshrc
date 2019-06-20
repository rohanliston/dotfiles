# ==[ Oh My ZSH Settings ]===================================================================

ZSH=$HOME/.oh-my-zsh

# Custom command prompt style
ZSH_THEME="rohan-blinks"

# Disable autocorrect prompts
DISABLE_CORRECTION="true"

# Custom plugins to load from ~/.oh-my-zsh/custom/plugins/
plugins=(git github)

# Oh my zsh update frequency (in days)
export UPDATE_ZSH_DAYS=30

# Pull in oh-my-zsh with above settings
source $ZSH/oh-my-zsh.sh

# ==[ ZSH Settings ]=========================================================================

# Appends every command to the history file once it is executed
setopt inc_append_history

# Reloads the history whenever you use it
setopt share_history

# ==[ PATH ]=================================================================================

# Set paths
export PATH=$PATH:$HOME/.local/bin

# ==[ Aliases ]==============================================================================

# Shell aliases
alias zshconfig="vim ~/.zshrc"
alias zshprofile="vim ~/.zprofile"
alias srcall="source ~/.zshrc && source ~/.zprofile"
alias sagi="sudo apt install"
alias sagu="sudo apt update"
alias pk="xclip -sel clip < ~/.ssh/id_rsa.pub -f && echo '\nPublic key copied to clipboard.'"
alias sl="ls"
alias ls="/bin/ls --color=tty -F"

# Path aliases
alias dev="cd ~/Development"
alias personal="dev && cd personal"
alias dotfiles="cd ~/.dotfiles"
alias dl="cd ~/Downloads"

# Git aliases
alias gpum="git pull upstream master"

# ==[ Shell Helpers ]========================================================================

# mkdir, cd into it
mkcd() {
    mkdir -p "$*"
    cd "$*"
}

# wo == 'work on': https://coderwall.com/p/feoi0a/shell-cd-replacement
wo() {
  code_dir=~/Development
  dir=$(find $code_dir -maxdepth 3 -type d | grep -i $* | grep -Ev Pods --max-count=1)
  [[ -d $dir ]] && cd $dir
}

# Grep in history
hgrep() { history | grep -i $1 }

# Grep in pip packages
pipgrep() { pip3 freeze | grep -i $1 }

# ==[ Git ]==================================================================================

# Check if branch exists remotely
bgrep() { git branch -r | grep -i $1 }

# Git command tweaks/shortcuts
function git {
    if [[ -e /usr/local/bin/hub ]]; then git_command="/usr/local/bin/hub"; else git_command="/usr/bin/git"; fi

    # Make "git clone" recurse submodules and CD into directory afterwards
    if [[ $1 = "clone" ]] ; then
        url=$2
	      if [[ -n $url ]] ; then
            reponame=$(echo $url | awk -F/ '{print $NF}' | sed -e 's/.git$//')

            $git_command clone --recurse-submodules $url $reponame

            printf "\nChanging to directory %s\n" "$reponame"
            cd $reponame
        else
            $git_command clone
        fi
    # Add "git clonefork" command for automatically setting upstream
    # @TODO: Pass along target directory if present
    elif [[ $1 = "clonefork" ]] ; then
        fork_url=$2
        base_username=${3:-dstil}
        subst="s/rohanliston/$base_username/"
        upstream_url=$(echo $fork_url | sed -e $subst)

	# git clone using this function as opposed to $git_command
        git clone $fork_url
        git remote add upstream $upstream_url

	printf "  origin:   %s\n" "$fork_url"
        printf "  upstream: %s\n" "$upstream_url"
    else
        $git_command $@
    fi
}

# ==[ Python ]===============================================================================

# Pip command tweaks/shortcuts
pip() {
    # Always install pip packages with --user flag
    if [ "$1" = "install" -o "$1" = "bundle" ]; then
        cmd="$1"
        shift
        pip3 $cmd --user $@
    else
        pip3 $@
    fi
}

# ==[ Colours ]==============================================================================

# Colourised man pages: http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
man() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

# ==[ OS-Specific Settings ]=================================================================

case $(uname) in
  'Linux')   source $HOME/.zshrc.ubuntu ;;
  'Darwin')  source $HOME/.zshrc.osx ;;
esac

# ==[ Local Settings ]=======================================================================

# use .zshrc.local for settings specific to one system
[[ -f "${HOME}/.zshrc.local" ]] && source "${HOME}/.zshrc.local"
