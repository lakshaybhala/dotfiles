source $BYOBU_PREFIX/share/byobu/profiles/tmux

set-option -g status-interval 5
set-option -g automatic-rename on
set-option -g automatic-rename-format '#{b:pane_current_path}'
