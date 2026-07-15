# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# I already have this in my ~/.profile: export PATH="$HOME/dotfiles/scripts:$PATH"
# it's in my ~/.profile instead so it's usable outside of zsh lah

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# !! SINCE MY ALIASES ARE BELOW, my alias will override any selfsame ohmyzsh alias etc

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="random"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME="random" will cause zsh to load
# a theme from this variable INSTEAD OF global pool in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "agnoster" "alanpeabody" "fino" "dst" "crunch" "smt")

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 30

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
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

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
plugins=(
	git
	zsh-autosuggestions
  	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# making aliases reminds me of making custom chat commands for Twitch

alias theme='echo "The current theme is: $RANDOM_THEME."'
alias whattheme=theme
alias themereset='ZSH_THEME="robbyrussell" && source $ZSH/oh-my-zsh.sh'

alias resettheme=themereset
alias reload='source ~/.zshrc'
alias help=run-help
alias whence='whence -v'

alias la='ls -lAh'
alias lt='ls -lt'
alias lr='tree -C --dirsfirst'

alias c='clear'
alias bye=exit
alias relight='sudo systemctl restart lightdm'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'

# alias ..='cd ..'
# alias ...='cd ../..'
setopt AUTO_CD
alias h='cd ~'
alias koko=pwd
alias here=pwd
alias docu='cd ~/Documents'
alias pisc='cd ~/Documents/Coding/Piscine'
alias downl='cd ~/Downloads'
alias dotf='cd ~/dotfiles'
alias notes='nano ~/dotfiles/linux_notes.md'
alias coding='cd ~/Documents/Coding'
alias his=history
alias hist=history
# alias grep='grep --color=auto'
export GREP_COLORS='ms=01;38;5;202'

alias vore='rm -rf'
alias extr='tar -xzf'
alias du='du -sh'
alias df='df -h /'
alias dcache='du -sh ~/.cache'

alias qw='setxkbmap us'
alias cm='setxkbmap us -variant colemak_dh'

# xcursor is for x11 stuff or something. ~/.Xresources as extra layer
export XCURSOR_SIZE=36
alias xcursor='xrdb -merge ~/.Xresources'
alias flatpakcursor='flatpak override --user --env=XCURSOR_SIZE=36 --env=XCURSOR_THEME="Bibata-Modern-Classic"'
cursor() {
    local size
    local theme
    size=$(gsettings get org.cinnamon.desktop.interface cursor-size)
    theme=$(gsettings get org.cinnamon.desktop.interface cursor-theme)
    echo "The cursor is size $size, themed $theme (Cinnamon)."
}

# teleporting
to() {
    # 1. Fallback check: If nothing was passed, just go home
    if [ -z "$1" ]; then
        cd ~
        return
    fi

    # 2. Find the absolute, real physical path (resolves symlinks automatically)
    local real_target=$(realpath "$1" 2>/dev/null)

    # 3. If the file/folder doesn't even exist, stop here
    if [ ! -e "$real_target" ]; then
        echo "Error: '$1' does not exist."
        return 1
    fi

    # 4. Teleport based on what the real target actually is
    if [ -d "$real_target" ]; then
        # If it's a folder (or a symlink pointing to a folder), go inside
        cd "$real_target"
    else
        # If it's a file (or a symlink pointing to a file), go to the folder holding it
        cd "$(dirname "$real_target")"
    fi
}

alias cdf=to
alias teleport=to
alias iku=to
alias gogo=to

# NEED TO DEBUG/TEST THIS NEXT ONE
# using tee to copy a file to multiple destinations
multicp() {
    # Check if we have at least an input file and one destination
    if [ "$#" -lt 2 ]; then
        echo "Usage: multicp <source_file> <dest1> [dest2] [dest3] ..."
        return 1
    fi

    # Extract the first argument as the source file
    local src="$1"
    shift # Remove the first argument, leaving only the destinations

    # check if  source file actually exists
    if [ ! -f "$src" ]; then
        echo "Error: Source file '$src' does not exist."
        return 1
    fi

    # suppress stdout
    tee "$@" < "$src" > /dev/null
}
alias multcp=multicp
