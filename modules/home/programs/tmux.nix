{
  pkgs,
  lib,
  config,
  ...
}:
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

  home.file."${config.xdg.binHome}/tmuxx" = lib.mkIf config.programs.tmux.enable {
    source =
      let
        fzfBin = "${config.programs.fzf.package}/bin/fzf";
        tmuxBin = "${config.programs.tmux.package}/bin/tmux";
      in
      pkgs.writeShellScript "tmuxx" ''
        set -eu

        PROJECTS_DIR="${config.xdg.userDirs.projects}"

        dirsel() {
            find "$PROJECTS_DIR" -mindepth 2 -maxdepth 2 -type d -printf "%T@ %P\n" |
                sort -nr |
                cut -d " " -f 2- |
                ${fzfBin}
        }

        case "''${1:--}" in
        .)
            dir="$(pwd)"
            shift
            ;;
        -)
            dir="$PROJECTS_DIR/$(dirsel)" || exit $?
            [ $# -gt 0 ] && shift
            ;;
        *)
            dir="$(readlink -f "$1")"
            shift
            ;;
        esac

        [ -d "$dir" ] || {
            echo "$(basename "$0"): '$dir' is not a directory" >&2
            exit 1
        }
        name="$(basename "$dir")"

        [ $# -gt 1 ] && {
            ${tmuxBin} new -d -c "$dir" -s "$name" -n "$1"
            shift
        }

        for win; do
            ${tmuxBin} new-window -d -t "$name" -c "$dir" -n "$win"
        done

        exec ${tmuxBin} new -A -c "$dir" -s "$name"
      '';
  };
}
