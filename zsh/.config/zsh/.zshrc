: "${SANDBOXRC:="$ZDOTDIR/.sandboxrc"}"
: "${ANTIDOTE_DIR:="$ZDOTDIR/.antidote"}"

# From: https://gist.github.com/ctechols/ca1035271ad134841284
# - '#q' is an explicit glob qualifier that makes globbing work within zsh's
# [[ ]] construct.
# - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather
# than throw a globbing error)
# - '.' matches "regular files"
# - 'mh+24' matches files (or directories or whatever) that are older than 24
# hours.
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit;
else
  compinit -C;
fi;

# History control
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_NO_FUNCTIONS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_VERIFY

DISABLE_AUTO_UPDATE=true
DISABLE_UPDATE_PROMPT=true
plugins=()

# Load plugins
# shellcheck source=.zsh-plugins.sh
if [[ ! "${ZDOTDIR}/.zsh_plugins.sh" -nt "${ZDOTDIR}/.zsh-plugins.txt" ]]; then
  if [[ ! -d "${ANTIDOTE_DIR}" ]]; then
    git clone --depth=1 https://github.com/mattmc3/antidote.git "${ANTIDOTE_DIR}"
  fi
  . "${ANTIDOTE_DIR}/antidote.zsh"
  antidote bundle < "${ZDOTDIR}/.zsh-plugins.txt" > "${ZDOTDIR}/.zsh-plugins.sh"
fi

. "${ZDOTDIR}/.zsh-plugins.sh"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white,underline'
export RIPGREP_CONFIG_PATH="${HOME}/.config/ripgrep/config"

export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
FZF_DEFAULT_OPTS=()
FZF_DEFAULT_OPTS+=(--layout=reverse)
FZF_DEFAULT_OPTS+=(--tabstop=4)
FZF_DEFAULT_OPTS+=(--color='fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f')
FZF_DEFAULT_OPTS+=(--color='info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54')
export FZF_DEFAULT_OPTS
export FZF_COMPLETION_TRIGGER='~~'

export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
FZF_CTRL_T_OPTS=()
FZF_CTRL_T_OPTS+=(--select-1 --exit-0)
FZF_CTRL_T_OPTS+=(--preview "'bat --style=numbers --color=always --line-range :50 {}'")
export FZF_CTRL_T_OPTS

print_skip_columns(){
  local clear_columns="$(for i in $(seq 1 "${1:-1}"); do printf "\$%s=" "$i"; done)"
  echo "awk '{gsub(/^[[:space:]]+/, \\\"\\\", \$0);${clear_columns}\\\"\\\"};1'"
}

render_with_bat(){
  echo 'bat --style=plain --color=always --line-range :10 --language=bash' "$@"
}

FZF_CTRL_R_OPTS=()
FZF_CTRL_R_OPTS+=(--history-size=10000)
FZF_CTRL_R_OPTS+=(--preview-window='up:2:wrap')
FZF_CTRL_R_OPTS+=(--bind='?:toggle-preview')
FZF_CTRL_R_OPTS+=(--preview="\"echo {} | $(print_skip_columns 1) | $(render_with_bat '')\"")
export FZF_CTRL_R_OPTS

unfunction print_skip_columns
unfunction render_with_bat

export FZF_ALT_C_OPTIONS='--select-1 --exit-0'
export KEYTIMEOUT=1

# VI Mode
bindkey -v
bindkey '^P' up-history             # ctrl+p
bindkey '^N' down-history           # ctrl+n
bindkey '^?' backward-delete-char   # backspace
bindkey '^h' backward-delete-char   # ctrl+h
bindkey '^w' backward-kill-word     # ctrl+w
# bindkey '^r' history-incremental-search-backward

insert-last-word-forward(){
  zle insert-last-word 1
}
zle -N insert-last-word-forward
bindkey '\e,' insert-last-word-forward
bindkey -s '\e.' insert-last-word

# FZF keys using lazy loading (sandboxd command)
# these keys are remapped once sandbox loads the
# appropriate settings
# bindkey -s '^t' 'sandbox fzf\n^T'
# bindkey -s '^r' 'sandbox fzf\n^R'

# aliases
alias vim='mvim -v'
alias brewtree='brew deps --tree --installed'
alias brewleaves='brew leaves | xargs brew deps --installed --for-each | sed "s/^.*:/$(tput setaf 4)&$(tput sgr0)/"'

# functions
go-version() {
  sandbox go >/dev/null 2>&1
  local version="${1}"
  local gobin="$HOME/sdk/${version}/bin"
  if [ -d "${gobin}" ]; then
    PATH="${gobin}:$(printf %s $PATH | \
      awk -v RS=: -v ORS=: \
        'BEGIN { t="^'$HOME'/sdk/go[0-9]\.[0-9]{1,2}(\.[0-9]{1,2}){1,2}/bin$" } $1!~t { print }')"
  else
    echo "${version} not found, install with \"go get golang.org/dl/${version}; ${version} download\""
  fi
}

profzsh(){
  shell=${1-$SHELL}
  ZPROF=true $shell -i -c exit
}
