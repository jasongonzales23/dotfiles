export PATH=$HOME/local/bin:$PATH
[ -n "$PS1" ] && source ~/.bash_profile
export GOPATH=~/work
export PATH=$PATH:$GOPATH/bin
export NODE_PATH=/Users/jason/.nvm/v0.10.26/lib/node_modules::/Users/jason/local/lib/node_modules
export REACT_EDITOR=vim
export PATH="$HOME/.yarn/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
