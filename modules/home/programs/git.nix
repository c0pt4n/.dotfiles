{
  pkgs,
  lib,
  config,
  ...
}:
let
  name = "Omar Mohamed";
  primaryEmail = "omarcoptan9@gmail.com";
  gpgKey = "FA9069B050A08336";
in
{
  programs.git = {
    enable = true;

    ignores = [
      "/node_modules/"
      "/__pycache__/"
      "/zig-out/"
      "/.zig-cache/"
      "/target/"
      "/wheels/"
      "/.venv/"
      "*.py[oc]"
      "*.egg-info"
    ];

    settings = {
      init = {
        defaultBranch = "main";
      };
      core = {
        editor = "${config.programs.neovim.package or pkgs.neovim}/bin/nvim";
        pager = "${config.programs.delta.package or pkgs.delta}/bin/delta";
      };
      user = {
        inherit name;
        email = primaryEmail;
        signingKey = gpgKey;
      };
      gpg = {
        format = "openpgp";
        ssh.program = lib.toString (
          pkgs.writeShellScript "ssh-signkey" ''
            #!/bin/sh
            set -eu

            while getopts "Y:n:f:" opt; do
              case "$opt" in
                f)
                  key="''${OPTARG%.pub}"
                  ssh-add -T "$key.pub" 2>&- || ssh-add "$key"
                  ;;
                *) ;;
              esac
            done

            exec ssh-keygen "$@"
          ''
        );
      };
      commit = {
        gpgSign = true;
      };
      push = {
        default = "simple";
        autoSetupRemote = true;
        gpgSign = "if-asked";
      };
      tag = {
        gpgSign = true;
      };
      pull = {
        rebase = true;
      };
      rebase = {
        autoStash = true;
      };
      rerere = {
        enabled = true;
      };
      receive = {
        advertisePushOptions = true;
      };
      alias = {
        co = "checkout";
        cm = "commit -m";
        st = "status -sb";
        br = "branch";
        cl = "clone";
        dt = "difftool";
        wt = "worktree";
        ls = "ls-files";
        tree = "ls-tree --full-tree -r HEAD";
        logg = "log --oneline --graph --decorate";
        undo = "reset --soft HEAD^";
        root = "rev-parse --show-toplevel";
      };
    };

    lfs = {
      enable = true;
      skipSmudge = false;
    };
  };

  home.shellAliases = lib.mkIf config.programs.git.enable {
    g = "git";
    gst = "git status -sb";
    gph = "git push";
    gpl = "git pull";
    gdf = "git diff";
  };

  home.file."${config.xdg.binHome}/gac" = lib.mkIf config.programs.git.enable {
    source =
      let
        gitBin = "${config.programs.git.package}/bin/git";
      in
      pkgs.writeShellScript "gac" ''
        set -eu

        if [ $# -lt 2 ]; then
          printf "usage:\n  %s files... message\n" "$(basename "$0")"
          exit 1
        fi

        for msg; do :; done

        for f; do
          [ "$f" = "$msg" ] && break
          [ -n "''${files:-}" ] && files="$files $f" || files="$f"
        done

        # shellcheck disable=SC2086
        ${gitBin} add $files &&
        ${gitBin} commit -m "$msg"
      '';
  };
}
