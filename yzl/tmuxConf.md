# base
set -g default-terminal "screen"
set -g display-time 3000
set -g history-limit 65535

# the default panel split with " and %,  hard to remember,use - and | instead
unbind '"'
bind - splitw -v 
unbind %
bind | splitw -h 

# select splited panel
bind k selectp -U 
bind j selectp -D 
bind h selectp -L 
bind l selectp -R 

# adjust window size
bind ^k resizep -U 10
bind ^j resizep -D 10
bind ^h resizep -L 10
bind ^l resizep -R 10

# swap windows
bind ^u swapp -U
bind ^d swapp -D

bind ^a last
bind q killp

bind '~' splitw htop
bind ! splitw ncmpcpp
bind m command-prompt "splitw -h 'exec man %%'"
unbind s


# staus customization

set -g status-left "#[fg=white,bg=blue] > #I < #[default] |" # 0:bash 
#set -g status-left "#[fg=white,bg=blue] > #I < #[default] |" # session-name 
set -g status-right "#[fg=yellow,bright][ #[fg=cyan]#W #[fg=yellow]]#[default] #[fg=yellow,bright]- %Y.%m.%d #[fg=green]%H:%M #[default]" 
set -g status-right-attr bright 
set -g status-bg black 
set -g status-fg white 
set -g set-clipboard on 

setw -g window-status-current-attr bright 
#setw -g window-status-current-bg red 
setw -g window-status-current-bg green 
setw -g window-status-current-fg white 
#set -g status-utf8 on 
set -g status-interval 1 
#set -g visual-activity on 
#setw -g monitor-activity on 
set -g status-keys vi 
#---------------------------------------------- 
setw -g mode-keys vi 
#setw -g mode-mouse on 
#setw -g mouse-resize-pane on 
#setw -g mouse-select-pane on 
#setw -g mouse-select-window on 
# move x clipboard into tmux paste buffer 
bind C-p run "tmux set-buffer \"$(xclip -o -sel clipbaord)\"; tmux paste-buffer" 
# move tmux copy buffer into x clipboard 
bind C-y run "tmux show-buffer | xclip -i -sel clipbaord" 
