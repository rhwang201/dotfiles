source ~/.private.rc

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Theme selection in ~/.oh-my-zsh/themes/
ZSH_THEME="muse"

COMPLETION_WAITING_DOTS="true"

# # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git safe-paste)

source $ZSH/oh-my-zsh.sh

# Richard's Aliases
alias vim="/usr/local/bin/vim"
alias v="vim"
alias svim="sudo vim"
alias ev="vim ~/.vimrc"
alias vrc="vim ~/.zshrc"
alias vgrc="vim ~/.gitconfig"

alias trn="~/sandbox/training.py"

alias src="source ~/.zshrc"

alias t="tmux"

alias k="kubectl"

alias bb=fg
alias c="cd"
alias l="ls"
alias la="ls -lah"
alias ll="ls -lh"

alias hd="head"
alias tl="tail"

alias df="df -h"
alias sz="du -h -d 0 *"

alias tmux="TERM=screen-256color-bce tmux"

alias ct="curl -w \"@.curl-format.txt\" -o /dev/null -s "

alias glh="git l | head"
alias gbc="git branch --merged master | grep -v '^ *master$' | xargs git branch -d"

cpv() {
    cp $1 $2 && vim $2
}

# Copy and create a training log for today's date
cpt() {
    today_filename="$(date "+%Y-%m-%d")-ss.markdown"
    cp $1 $today_filename && vim $today_filename
}

# Find using regex
f() {
    find -E . -iregex ".*$1.*"
}
fe() {
    find -E . -iregex ".*$1"
}

# Silver Searcher
alias a="ag --pager=\"less -XR\""

apc() {
    a "class $1\("
}

apf() {
    a "def $1\("
}

alias atd="a \"TODO\(rhwang\)\""

# Search git log.
gac() {
    git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative | ag $1 | head -n 20;
}

# Show Nth most recent commit for a file.
gshn()
{
  FILE=$1
  N=${2:-1}
  git show $(git log -$N --oneline $1 | tail -n 1 | cut -d ' ' -f 1) $1
}

# Copy a file to OSX clipboard.
copy() {
  cat $1 | pbcopy
}

# Vim bindings
export EDITOR="/usr/local/bin/vim"
bindkey -v

# Nice prefix searching
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search # Up
bindkey '^[[B' down-line-or-beginning-search # Down
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# Searching
gtyp() {
    grep -inr --include \*.c3typ "type $1 " * | ~/sandbox/showType.py;
}
gsyp() {
    ag -i --type-set=typ=.c3typ --typ "type $1 ";
}
app() {
    ag -i --type-set=app=.c3app --app $1;
}
typ() {
    ag -i --type-set=typ=.c3typ --typ $1;
}
ui() {
    ag -i --type-set=ui=.c3ui --ui $1;
}
html() {
    ag -i --type-set=html=.html --html $1;
}
ml() {
    ag -i --type-set=ml=.c3ml --ml $1;
}
json() {
    ag -i --json $1;
}
js() {
    a --js $1;
}
tst() {
    grep -ir --include \*test_\*.js $1 *;
}
py() {
    a -i --python $1;
}

fortune | cowsay

alias tn="TERM=screen-256color-bce tmux new-session -s"
alias ts="TERM=screen-256color-bce tmux switch -t"
alias ta="TERM=screen-256color-bce tmux attach -t"
alias td="TERM=screen-256color-bce tmux detach"
alias tls="TERM=screen-256color-bce tmux list-sessions"
alias tk="TERM=screen-256color-bce tmux kill-session -t"

alias sve="source venv/bin/activate"

alias st="sbt test"


function kube_connect() {
    pod_name=$(kubectl -n $1 get pods -l service=$2 | sed -n 2p | awk '{ print $1; }')
    kubectl -n $1 exec -it $pod_name -- /bin/bash
}

alias kcon=kube_connect

source <(kubectl completion zsh)

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# CONVOX
convox_connect() {
    if [ -z "$3" ]
    then
        ps_id=$(CONVOX_RACK=$1 convox ps -a $2 | sed '2q;d' | awk '{ print $1; }')
    else
        ps_id=$3
    fi
    CONVOX_RACK=$1 convox exec $ps_id /bin/bash -a $2
}
convox_ps() {
    CONVOX_RACK=$1 convox ps -a $2
}
convox_scale() {
    CONVOX_RACK=$1 convox scale -a $2
}
convox_deploy() {
    CONVOX_RACK=$1 convox deploy . -a $2
}
convox_restart() {
    for p_id in $(CONVOX_RACK=$1 convox ps -a $2 | tail +2 | awk '{ print $1; }'); do
        CONVOX_RACK=$1 convox ps stop $p_id -a $2;
    done
}
alias ccon=convox_connect
alias cps=convox_ps
alias csc=convox_scale
alias cdy=convox_deploy
alias crst=convox_restart
