{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    clock24 = true;
    historyLimit = 10000;
    prefix = "C-a";
    terminal = "tmux-256color";
    extraConfig = ''
      set -sa terminal-overrides ",tmux-256color*:Tc"

      bind r source ~/.config/tmux/tmux.conf
      set -gs renumber-windows on
      set -gs copy-command "wl-copy"

      unbind %
      bind | split-window -h

      unbind '"'
      bind - split-window -v

      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi V send -X select-line
      bind -T copy-mode-vi y send -X copy-pipe-and-cancel

      bind -rn M-Tab last-window
      bind -rn M-k next-window
      bind -rn M-j previous-window
      bind -n M-h switch-client -p
      bind -n M-l switch-client -n
      bind -n M-n command-prompt -p "New Session:" "new-session -A -s '%%'"
    '';
  };
}
