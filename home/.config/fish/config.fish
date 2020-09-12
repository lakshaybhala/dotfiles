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
    set -xg JAVA_HOME "/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home"

    # Byobu
    set -xg BYOBU_PREFIX "/usr/local"

    # Swift (for language server)
    set -xg SOURCEKIT_TOOLCHAIN_PATH ""

    # Homebrew
    set -xg PATH /usr/local/sbin $PATH

    # GPG
    set -xg GPG_TTY (tty)
else if [ (uname) = "Linux" ]
    # Linux-specific config

    # Aliases
    # Replicate functionality of `pbcopy`/`pbpaste` (from macOS) using `xclip`
    alias pbcopy "xclip -selection clipboard"
    alias pbpaste "xclip -selection clipboard -o"
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

# Interactive things, with checks that they exist
if status --is-interactive
    # Load starfish prompt
    if command -v starship > /dev/null
        starship init fish | source
    end

    # Load `fuck`
    if command -v thefuck > /dev/null
        thefuck --alias | source
    end
end

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
    # Use e or edit to open the current text editor
    abbr -a -g e $EDITOR
    abbr -a -g edit $EDITOR
    # Train muscle memory not to type nvim
    abbr -a -g nvim "echo 'BAD MUSCLES' #"
    # Start tmux and attach to the main session
    abbr -a -g tmuxme "tmux-startup; and tmux attach -t main"
    # Attach to a tmux session
    abbr -a -g tat "tmux attach-session -t"
end
