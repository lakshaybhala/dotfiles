# Load homeshick for dotfile synchronisation
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
# Load fish completions for homeshick
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"

if status --is-interactive
    # Check for updates to dotfiles
    homeshick --quiet refresh
end

# Platform-specific config
if [ (uname) = "Darwin" ]
    # macOS-specific config

    # Java
    set -xg JAVA_HOME "/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home"

    # Byobu
    set -xg BYOBU_PREFIX "/usr/local"

    # Swift (for language server)
    set -xg SOURCEKIT_TOOLCHAIN_PATH ""

    # Homebrew
    set -xg PATH /usr/local/sbin $PATH
end

# Rust
# Path to Rust source
set -xg RUST_SRC_PATH (eval $HOME/.cargo/bin/rustc --print sysroot)"/lib/rustlib/src/rust/src"

# $PATH
set -xg PATH \
# Rust/Cargo
$HOME/.cargo/bin \
# Existing $PATH
$PATH

# Abbreviations
if status --is-interactive
    # Use exa instead of ls
    abbr -a -g ls exa
    abbr -a -g lsl exa -al
    abbr -a -g lst exa -alT -I .git --git-ignore
    # Use bat instead of cat
    abbr -a -g cat bat
    # Use sd instead of sed
    abbr -a -g sed sd
    # Use dust instead of du
    abbr -a -g du dust
    # Use fd instead of find
    abbr -a -g find fd
    # Use ripgrep instead of grep
    abbr -a -g grep rg
    # `cargo build` takes too long to type
    abbr -a -g cb cargo build
    # Start byobu and attach to the main session
    abbr -a -g byobme "~/.byobu/startup; and byobu attach -t main"
end

# Misc config
# Make `less` clear its output on closing
set -xg LESS R
# Set the default editor to `nvim`
set -xg EDITOR "nvim"
# Set language
set -xg LC_ALL en_GB.UTF-8
set -xg LANG en_GB.UTF-8

# Load secret info
if [ -e ~/.config/fish/secret.fish ]
    source ~/.config/fish/secret.fish
end

# Interactive things
if status --is-interactive
    # Load starfish prompt
    starship init fish | source
    # Load `fuck`
    thefuck --alias | source
end
