################################################################################
# General
################################################################################

set-option -sa terminal-overrides ",xterm*:Tc"
# utf-8 on
set -gq utf8 on        # Tmux < 2.2
set -gq status-utf8 on # Tmux < 2.2

# address vim mode switching delay (http://superuser.com/a/252717/65504)
set -s escape-time 0

# tmux messages are displayed for 4 seconds
set -g display-time 4000

# Increase scrollback buffer size
set -g history-limit 10000

# Use Vi mode
setw -g mode-keys vi

# emacs key bindings in tmux command prompt (prefix + :) are better than vi keys, even for vim users
set -g status-keys emacs

# Allow automatic renaming of windows
set -g allow-rename on

# Renumber windows when one is removed.
set -g renumber-windows on

# Set a terminal that apps will know how to handle
#set -g default-terminal "screen-256color"
set -g default-terminal "xterm-256color"

set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'

# Enable the mouse for scrolling
set -gq mode-mouse on # Tmux < 2.1
set -gq mouse on      # Tmux >= 2.1
bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'select-pane -t=; copy-mode -e; send-keys -M'"
bind -n WheelDownPane select-pane -t= \; send-keys -M

# Enable mouse for selecting and resizing
set -gq mouse-select-window on # Tmux < 2.1
set -gq mouse-select-pane on   # Tmux < 2.1
set -gq mouse-resize-pane on   # Tmux < 2.1

# Allow tmux to set the titlebar
set -g set-titles on

# Start window and pane numbering from 1 for easier switching
set -g base-index 1
setw -g pane-base-index 1

# How long to display the pane number on PREFIX-q
set -g display-panes-time 3000 # 3s

# How long to wait for repeated keys bound with bind -r
set -g repeat-time 2000 # 2s

# Monitor window activity to display in the status bar
set-window-option -g monitor-activity on

# A bell in another window should cause a bell in the current window
set -g bell-action any

# Don't show distracting notifications
set -g visual-bell off
set -g visual-activity off

# focus events enabled for terminals that support them
set -g focus-events on

# super useful when using "grouped sessions" and multi-monitor setup
setw -g aggressive-resize on

# don't detach tmux when killing a session
set -g detach-on-destroy off

################################################################################
# Key Binding
################################################################################

# -r means that the bind can repeat without entering prefix again
# -n means that the bind doesn't use the prefix

# Ensure prefix is Ctrl+B
set -g prefix C-B

# Send prefix to a nested tmux session by doubling the prefix
bind C-Space send-prefix

# 'PREFIX r' to reload of the config file
unbind r
bind r source-file ~/.tmux.conf\; display-message '~/.tmux.conf reloaded'

# Allow holding Ctrl when using using prefix+p/n for switching windows
bind C-p previous-window
bind C-n next-window

# Move around panes like in vim
bind -r h select-pane -L
bind -r j select-pane -D
bind -r k select-pane -U
bind -r l select-pane -R
bind -r C-h select-window -t :-
bind -r C-l select-window -t :+

# Smart pane switching with awareness of vim splits
is_vim='echo "#{pane_current_command}" | grep -iqE "(^|\/)g?(view|n?vim?)(diff)?$"'
bind -n C-h if-shell "$is_vim" "send-keys C-h" "select-pane -L"
bind -n C-j if-shell "$is_vim" "send-keys C-j" "select-pane -D"
bind -n C-k if-shell "$is_vim" "send-keys C-k" "select-pane -U"
bind -n C-l if-shell "$is_vim" "send-keys C-l" "select-pane -R"

bind -r y resize-pane -L
bind -r u resize-pane -D
bind -r i resize-pane -U
bind -r o resize-pane -R

# Switch between previous and next windows with repeatable
bind -r n next-window
bind -r p previous-window

# Move the current window to the next window or previous window position
bind -r N run-shell "tmux swap-window -t $(expr $(tmux list-windows | grep \"(active)\" | cut -d \":\" -f 1) + 1)"
bind -r P run-shell "tmux swap-window -t $(expr $(tmux list-windows | grep \"(active)\" | cut -d \":\" -f 1) - 1)"

# Switch between two most recently used windows
bind Space last-window

# use PREFIX+| (or PREFIX+\) to split window horizontally and PREFIX+- or
# (PREFIX+_) to split vertically also use the current pane path to define the
# new pane path
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

# Change the path for newly created windows
bind c new-window -c "#{pane_current_path}"

# Setup 'v' to begin selection as in Vim
if-shell -b '[ "$(echo "$TMUX_VERSION >= 2.4" | bc)" = 1 ]' \
    'bind-key -T copy-mode-vi v send-keys -X begin-selection;'

# bind y run -b "tmux show-buffer | xclip -selection clipboard"\; display-message "Copied tmux buffer to system clipboard"

bind-key -r F new-window t
bind-key -r D run-shell "t ~/.dotfiles"

# Copy pasting
bind C-c run "tmux save-buffer - | xclip -i -sel clipboardxt"

#bind C-v run "tmux set-buffer "$(xclip -o -sel clipboard)"; tmux paste-buffer"
