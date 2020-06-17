eval "$(starship init zsh)"

DOCKER_HOME="/Applications/Docker.app/Contents/Resources"
VSCODE_REMOTE_CONTAINERS="$HOME/Library/Application Support/Code/User/globalStorage/ms-vscode-remote.remote-containers/cli-bin"
ANDROID_SDK="$HOME/Library/Android/sdk"

PATH="${DOCKER_HOME}/bin:${PATH}"
PATH="${VSCODE_REMOTE_CONTAINERS}:${PATH}"
PATH="${ANDROID_SDK}/emulator:${PATH}"
PATH="${ANDROID_SDK}/platform-tools:${PATH}"
PATH="${ANDROID_SDK}/tools/bin:${PATH}"
PATH="$HOME/.local/bin:$PATH"
export PATH
export GPG_TTY="$(tty)"

# if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
#     source ~/.gnupg/.gpg-agent-info
#     export GPG_AGENT_INFO
# else
#     eval $(gpg-agent --daemon)
# fi

if [[ "$ZPROF" = true ]]; then
  zprof
fi
