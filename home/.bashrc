# Load secrets
[[ -r ~/.bash_secret ]] && . ~/.bash_secret

# Aliases
# For use instead of `emacs` to open in existing emacs GUI session
alias emc="emacsclient -n"
# Remind myself to use the Rust versions of things!
alias ls="exa"
# Alias to make typing exa arguments easier
alias lsl="exa -al"

# Add Cargo executables to PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Load fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Load starship
eval "$(starship init bash)"
