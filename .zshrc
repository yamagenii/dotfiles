if [[ ! -n $TMUX ]]; then
    tmux attach;
    # detachしてない場合
    if [ $? ]; then
        tmux;
    fi
fi

export ZSH=/Users/y-ryosuke/.oh-my-zsh
ZSH_THEME="robbyrussell"

export PATH="/usr/local/bin:/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

source ~/.cargo/env


source ~/.zplug/init.zsh
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
plugins=(git)
fpath=(~/.zplug/repos/zsh-users/zsh-completions/src ~/.zsh/completion $fpath)
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug load
export ZSH_HIGHLIGHT_STYLES[path]='fg=081'
autoload -Uz compinit
compinit -i

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

setopt inc_append_history
setopt share_history

#bindkey '^r' history-incremental-pattern-search-backward
#bindkey '^s' history-incremental-pattern-search-forward

if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

eval `dircolors -b`
eval `dircolors ${HOME}/dotfiles/.dircolors`

unsetopt list_types

autoload colors
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

export LESS='-R'


export MANPAGER='less -R'
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;33m") \
	LESS_TERMCAP_md=$(printf "\e[1;36m") \
	LESS_TERMCAP_me=$(printf "\e[0m") \
	LESS_TERMCAP_se=$(printf "\e[0m") \
	LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
	LESS_TERMCAP_ue=$(printf "\e[0m") \
	LESS_TERMCAP_us=$(printf "\e[1;32m") \
	man "$@"
}

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

alias ls='ls -h --color=always'
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias du='du -shc * | sort -h'

alias grep='grep --color=always'
alias jgrep='grep --include="*.java"'
alias jsgrep='grep --include="*.js"'
alias fgrep='find ./ | grep'
alias ngrep='grep --exclude-dir={node_modules,.nuxt}'

source $ZSH/oh-my-zsh.sh

eval "$(rbenv init -)"


colors

PROMPT="%{${FG[144]}%}[%n]%{${reset_color}%} %{${FG[144]}%}%~%{${reset_color}%} 
%{${FG[133]}%}%#%{${reset_color}%} "

RPROMPT="%{${FG[133]}%}[%m]%{${reset_color}%}"
RPROMPT='${vcs_info_msg_0_} '$RPROMPT

function peco-history-selection() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}

zle -N peco-history-selection
bindkey '^r' peco-history-selection
