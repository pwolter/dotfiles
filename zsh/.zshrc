# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=/opt/anaconda3/bin:$HOME/bin:/usr/local/bin:$PATH

# Homebrew autocomplete
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# Path to your oh-my-zsh installation.
export ZSH="/Users/pablo.wolter/.oh-my-zsh"

# virtualenv info

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects

# export ANACONDA_HOME=/$HOME/anaconda3
export ANACONDA_HOME=/$HOME/miniforge3

export VIRTUALENVWRAPPER_PYTHON=$ANACONDA_HOME/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV=$ANACONDA_HOME/bin/virtualenv
source $ANACONDA_HOME/bin/virtualenvwrapper.sh

# Trying to fix term look in Emacs
#if [[ -n "$INSIDE_EMACS" ]]; then
#  export LANG=en_US.UTF-8
#  export LC_ALL=en_US.UTF-8
#  export TERM=xterm-256color
#else
#  export TERM=xterm-256color
#fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# antigen bundle zsh-users/zsh-autosuggestions

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

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
plugins=()

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Miscelaneous aliases I use

alias ll="ls -lrt"
alias la="ls -lrta"
alias lh="ls -lrth"

alias gp="git pull"
alias gf="git fetch"
alias ga="git add ."
alias gt="git add ."

alias ..="cd .."
alias dev="cd /Users/pablo.wolter/Development"

alias hi="history | grep "
alias pss="ps -ef | grep -v grep | grep "

alias jn="$ANACONDA_HOME/bin/jupyter notebook --browser='chrome' &"
alias jl="$ANACONDA_HOME/bin/jupyter lab --browser='chrome' &"
alias jq="$ANACONDA_HOME/bin/jupyter qtconsole &"

alias clean_hf="rm -rf /Users/pablo.wolter/.cache/huggingface"

export SPARK_HOME=/Users/pablo.wolter/spark
export PATH=$PATH:$SPARK_HOME/bin

export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook'

# Add Visual Studio Code (code)
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:/opt/local/bin:$PATH"

# Add Emacs DOOM path
export PATH="$HOME/.emacs.d/bin:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# GOPATH
export GOPATH="/Users/pablo.wolter/go/bin"

# imgcat PATH
export PATH="/usr/local/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/pablo.wolter/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/pablo.wolter/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/pablo.wolter/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/pablo.wolter/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/sqlite/lib"
export CPPFLAGS="-I/opt/homebrew/opt/sqlite/include"
export PATH="/opt/homebrew/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/Users/pablo.wolter/miniforge3/bin/mamba';
export MAMBA_ROOT_PREFIX='/Users/pablo.wolter/miniforge3';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export PATH="/opt/homebrew/bin:$PATH"
fpath+=/opt/homebrew/share/zsh/site-functions
autoload -Uz compinit && compinit
export PATH="$HOME/.local/bin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"
