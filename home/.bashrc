# Load secrets
[[ -r ~/.bash_secret ]] && . ~/.bash_secret

# Add Cargo executables to PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Load fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
