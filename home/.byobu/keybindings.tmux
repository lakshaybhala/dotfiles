unbind-key -n C-a
unbind-key -n C-Space
set -g prefix ^Space
set -g prefix2 F12
bind Space send-prefix

bind-key C-S-j select-pane -D
bind-key C-n select-pane -D

bind-key C-S-k select-pane -U
bind-key C-p select-pane -U

bind-key C-S-l select-pane -R
bind-key C-f select-pane -R

bind-key C-S-h select-pane -L
bind-key C-b select-pane -L

unbind -
unbind |
bind - display-panes \; split-window -vc "#{pane_current_path}"
bind | display-panes \; split-window -hc "#{pane_current_path}"

bind C-c run "tmux save-buffer - | pbcopy"
bind C-v run "pbpaste | tmux load-buffer - && tmux paste-buffer"
