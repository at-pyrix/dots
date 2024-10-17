# ==========================
# PATH Configuration
# ==========================
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# ==========================
# Oh My Zsh Configuration
# ==========================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

# ==========================
# Zsh Options
# ==========================
export HYPHEN_INSENSITIVE="true"
export DISABLE_UNTRACKED_FILES_DIRTY="true"
export CASE_SENSITIVE="false"
export DISABLE_MAGIC_FUNCTIONS="false"
export DISABLE_LS_COLORS="false"
export ENABLE_CORRECTION="false"

# ==========================
# Plugins
# ==========================
plugins=(copyfile)
source $ZSH/oh-my-zsh.sh

# ==========================
# Environment Variables
# ==========================
export NVM_LAZY_LOAD=true
export LANG=en_US.UTF-8
export EDITOR="nano"
export GREP_COLORS='ms=01;36:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export HISTCONTROL=ignorespace

# ==========================
# Aliases
# ==========================
# ls aliases
alias ls="/usr/bin/logo-ls -G"
alias lll='ls -C'
alias ll='ls -alh'
alias la='ls -A'
alias l='ls -1'

# command aliases
alias nf="neofetch"
alias fetch="fastfetch"
alias clock="tty-clock -c -t -C 3"
alias spice="spicetify"
alias cls="clear"
alias py="python"
alias rm='rm -i'  # Interactive mode for rm

# other aliases
alias bin="trash"
alias ls-bin="trash-list"
alias tobackup="$EDITOR ~/.backup/tobackup.txt"
alias zshrc="$EDITOR ~/.zshrc"
alias update="eos-update --yay"
alias backup="~/.backup/backup.sh"
alias yt-dlp="yt-dlp --config-location ~/.config/yt-dlp/yt-dlp.conf"

# nano workaround
alias sudo='sudo '
alias nano='nano --rcfile ~/.nanorc'

# locale fix
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_IN.UTF-8
export LC_NUMERIC=en_IN.UTF-8
export LC_TIME=en_IN.UTF-8
export LC_MONETARY=en_IN.UTF-8
export LC_ADDRESS=en_IN.UTF-8


# ==========================
# Source Scripts
# ==========================
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
