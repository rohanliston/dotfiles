# ==[ Oh My ZSH Settings ]===================================================================

ZSH=$HOME/.oh-my-zsh

# Custom command prompt style
ZSH_THEME="rohan-blinks"

# Disable autocorrect prompts
DISABLE_CORRECTION="true"

# Custom plugins to load from ~/.oh-my-zsh/custom/plugins/
plugins=(git rails github)

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
alias zshprofile="vim ~/.profile"
alias srcall="source ~/.zshrc && source ~/.profile && source ~/.zprofile"
alias sagi="sudo apt install"
alias sagu="sudo apt update"
alias pk="xclip -sel clip < ~/.ssh/id_rsa.pub -f && echo '\nPublic key copied to clipboard.'"
alias sl="ls"
alias ls="/bin/ls --color=tty -F"

# Path aliases
alias dev="cd ~/Development"
alias dstil="dev && cd dstil"
alias proj="dstil && cd serenity"
alias wk="dstil && cd wicketkeeper"
alias personal="dev && cd personal"
alias dotfiles="cd ~/.dotfiles"
alias dl="cd ~/Downloads"

# Vagrant aliases
alias vup="vagrant up"
alias vdown="vagrant suspend"
alias vp="vagrant provision"
alias vr="vagrant reload"
alias vssh="vagrant ssh"


# ==[ Shell Helpers ]========================================================================

# mkdir, cd into it: http://onethingwell.org/post/586977440/mkcd-improved
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
pipgrep() { pip freeze | grep -i $1 }


# ==[ Git ]==================================================================================

# Activate 'hub' alias as 'git'
alias git=hub

# Check if branch exists remotely
bgrep() { git branch -r | grep -i $1 }

# Git command tweaks/shortcuts
git() {
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
        /usr/local/bin/pip $cmd --user $@
    else
        /usr/local/bin/pip $@
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


# ==[ AWS ]==================================================================================

# Quick switching between multiple AWS profiles
awsprofile() {
    profile_name=$1

    python << END
import configparser, os

# Ensure desired profile name isn't "default"
if "$profile_name" == "default":
    print("Active profile is already 'default'")
    exit(1)

# Read credentials file
credentials = configparser.ConfigParser()
credentials.readfp(open("$HOME/.aws/credentials"))

# Read config file
config = configparser.ConfigParser()
config.readfp(open("$HOME/.aws/config"))

# Read custom config file
custom_config = configparser.ConfigParser()
custom_config.readfp(open("$HOME/.aws/custom_config"))

# Ensure profile exists
if "$profile_name" not in credentials.sections() or "$profile_name" not in config.sections():
    print("Profile '$profile_name' not found or improperly defined.")
    print("Available profiles: " + config.sections().strip("[]"))
    exit(1)

# Extract credentials
aws_access_key_id     = credentials.get("$profile_name", "aws_access_key_id")
aws_secret_access_key = credentials.get("$profile_name", "aws_secret_access_key")

# Extract config
region = config.get("$profile_name", "region")
output = config.get("$profile_name", "output")

# Extract custom config
console_url = custom_config.get("$profile_name", "console_url")

# Overwrite [default] sections with selected profile
credentials.set("default", "aws_access_key_id",     aws_access_key_id)
credentials.set("default", "aws_secret_access_key", aws_secret_access_key)
config.set("default", "region", region)
config.set("default", "output", output)
custom_config.set("default", "console_url", console_url)

with open("$HOME/.aws/credentials", "w") as credentials_file:
    credentials.write(credentials_file)

with open("$HOME/.aws/config", "w") as config_file:
    config.write(config_file)

with open("$HOME/.aws/custom_config", "w") as custom_config_file:
    custom_config.write(custom_config_file)

print("Default AWS profile set to '$profile_name'")
END
}

# AWS CLI enhancements:
#   "aws console": Open the appropriate management console URL depending on the active profile
aws() {
    if [ "$1" = "console" ]; then
        console_url=`python << END
import configparser, os

custom_config = configparser.ConfigParser()
custom_config.readfp(open("$HOME/.aws/custom_config"))

console_url = custom_config.get("default", "console_url")
print(console_url)
END`
        [[ $? -eq 0 ]] && google-chrome $console_url
    else
        /usr/bin/aws $@
    fi
}

# ==[ OS-Specific Settings ]=================================================================

case $(uname) in
  'Linux')   source $HOME/.zshrc.ubuntu ;;
  'Darwin')  source $HOME/.zshrc.osx ;;
esac


# ==[ Local Settings ]=======================================================================

# use .zshrc.local for settings specific to one system
[[ -f "${HOME}/.zshrc.local" ]] && source "${HOME}/.zshrc.local"
