# Load homeshick for dotfile synchronisation
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
# Load fish completions for homeshick
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"
# Check for updates to dotfiles
homeshick --quiet refresh

# Rust
# Path to Rust source
set -xg RUST_SRC_PATH (eval $HOME/.cargo/bin/rustc --print sysroot)"/lib/rustlib/src/rust/src"

# $PATH
set -xg PATH \
# Rust/Cargo
$HOME/.cargo/bin \
# Existing $PATH
$PATH

# Aliases
# For use instead of `emacs` to open in existing Emacs GUI session
alias emc "emacsclient -n"
# Easier way of running `emacs -nw`
alias enw "emacs -nw"
# Remind myself to use the Rust versions of things!
alias ls "echo 'use exa'"
alias cat "echo 'use bat'"
# Alias to make typing exa arguments easier
alias exl "exa -al --color=always"
# Quick view of all projects in ~/Projects/github.com/
alias projects "tree -C -L 2 ~/Projects/github.com/ | less"

# Misc config
# Make `less` clear its output on closing
set -xg LESS R
# Set the default editor to `emacs`
set -xg EDITOR "emacsclient"
# Set language
set -xg LC_ALL en_GB.UTF-8
set -xg LANG en_GB.UTF-8

# Load secret info
source ~/.config/omf/secret.fish
