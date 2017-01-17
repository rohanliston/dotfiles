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
alias zshprofile="vim ~/.profile"
alias srcall="source ~/.zshrc && source ~/.profile && source ~/.zprofile"
alias sagi="sudo apt install"
alias sagu="sudo apt update"
alias pk="xclip -sel clip < ~/.ssh/id_rsa.pub -f && echo '\nPublic key copied to clipboard.'"

# Path aliases
alias dev="cd ~/Development"
alias dstil="dev && cd dstil"
alias proj="dstil && cd serenity"
alias personal="dev && cd personal"
alias dotfiles="cd ~/.dotfiles"

# Vagrant aliases
alias vup="vagrant up"
alias vdown="vagrant suspend"
alias vp="vagrant provision"
alias vr="vagrant reload"
alias vssh="vagrant ssh"

# App aliases
alias treemap=ncdu

 
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
greph() { history | grep -i $1 }


# ==[ Ruby ]=================================================================================

export PATH=$PATH:$HOME/.rbenv/bin
eval "$(rbenv init - zsh)"


# ==[ Git ]==================================================================================

# Git command tweaks/shortcuts
git() {
    # Make "git clone" recurse submodules and CD into directory afterwards
    if [ "$1" = "clone" ] ; then
        url=$2
        reponame=$(echo $url | awk -F/ '{print $NF}' | sed -e 's/.git$//')

        /usr/bin/git clone --recurse-submodules $url $reponame

        printf "\nChanging to directory %s\n" "$reponame"
        cd $reponame
    # Add "git clonefork" command for automatically setting upstream
    # @TODO: Pass along target directory if present
    elif [ "$1" = "clonefork" ] ; then
        fork_url=$2
        base_username=${3:-dstil}
        subst="s/rohanliston/$base_username/"
        upstream_url=$(echo $fork_url | sed -e $subst)

        git clone $fork_url
        git remote add upstream $upstream_url

	printf "  origin:   %s\n" "$fork_url"
        printf "  upstream: %s\n" "$upstream_url"
    else
        /usr/bin/git "$@"
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

awsprofile() {
    profile_name=$1

    python << END
import ConfigParser, os

# Ensure desired profile name isn't "default"
if "$profile_name" == "default":
    print("Active profile is already 'default'")
    exit(1)

# Read credentials file
credentials = ConfigParser.ConfigParser()
credentials.readfp(open("$HOME/.aws/credentials"))

# Read config file
config = ConfigParser.ConfigParser()
config.readfp(open("$HOME/.aws/config"))
config_sections = [section.replace("profile ", "") for section in config.sections()]

# Ensure profile exists
if "$profile_name" not in credentials.sections() or "$profile_name" not in config_sections:
    print("Profile '$profile_name' not found.")
    print("Available profiles: " + config_sections.strip("[]"))
    exit(1)

# Extract credentials
aws_access_key_id     = credentials.get("$profile_name", "aws_access_key_id")
aws_secret_access_key = credentials.get("$profile_name", "aws_secret_access_key")

# Extract config
region = config.get("profile $profile_name", "region")
output = config.get("profile $profile_name", "output")


# Overwrite [default] sections with selected profile
credentials.set("default", "aws_access_key_id",     aws_access_key_id)
credentials.set("default", "aws_secret_access_key", aws_secret_access_key)
config.set("default", "region", region)
config.set("default", "output", output)

with open("$HOME/.aws/credentials", "w") as credentials_file:
    credentials.write(credentials_file)

with open("$HOME/.aws/config", "w") as config_file:
    config.write(config_file)

print("Default AWS profile set to '$profile_name'")
END
}


# ==[ Local Settings ]=======================================================================

# use .zshrc.local for settings specific to one system
[[ -f "${HOME}/.zshrc.local" ]] && source "${HOME}/.zshrc.local"
