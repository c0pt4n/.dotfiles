{
  pkgs,
  config,
  lib,
  ...
}:
let
  name = "Omar Mohamed";
  gpgKey = "FA9069B050A08336";
  passBin = "${config.programs.password-store.package}/bin/pass";
  gmailFlavor = "gmail.com";
  outlookFlavor = "outlook.office365.com";
  mkEmailAccount =
    {
      address,
      flavor ? "plain",
      primary ? false,
    }:
    {
      inherit primary address flavor;
      realName = name;
      userName = address;
      maildir.path = address;
      passwordCommand = "${passBin} mail/${address} | sed 1q";
      gpg = {
        key = gpgKey;
        signByDefault = true;
      };
      signature = {
        command = ''printf "\n\n- ${name}\n"'';
        showSignature = "append";
      };
      imap = {
        host =
          if flavor == gmailFlavor then
            "imap.gmail.com"
          else if flavor == outlookFlavor then
            "outlook.office365.com"
          else
            lib.last (lib.splitString "@" address);
        port = 993;
        tls = {
          enable = true;
          useStartTls = false; # IMAPS, not STARTTLS
        };
      };
      smtp = {
        host =
          if flavor == gmailFlavor then
            "smtp.gmail.com"
          else if flavor == outlookFlavor then
            "smtp.office365.com"
          else
            "smtp.${lib.last (lib.splitString "@" address)}";
        port = if flavor == outlookFlavor then 587 else 465;
        tls = {
          enable = true;
          useStartTls = (flavor == outlookFlavor);
        };
      };
      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
        patterns = [ "*" ];
        extraConfig = {
          account = lib.optionalAttrs (flavor != outlookFlavor) {
            AuthMechs = "LOGIN";
          };
          channel = {
            CopyArrivalDate = "yes";
            MaxMessages = 0;
            ExpireUnread = "no";
            SyncState = "*";
          };
          local = {
            Subfolders = "Verbatim";
          };
        };
      };
      mu.enable = true;
      msmtp.enable = true;
    };
  mbsyncBin = "${config.programs.mbsync.package}/bin/mbsync";
  mailDirPaths =
    config.accounts.email.accounts
    |> lib.mapAttrsToList (k: v: "'${config.accounts.email.maildirBasePath}/${v.address}'")
    |> lib.concatStringsSep " ";
  mailSyncScript = pkgs.writeShellScriptBin "mailsync" ''
    set -eu

    mkdir -p ${mailDirPaths}

    pidof -sqx mbsync && {
      echo "$(basename "$0"): already running" >&2
      exit 1
    }

    exec ${mbsyncBin} -aV
  '';
in
{
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.mu.enable = true;

  home.packages = [ mailSyncScript ];

  accounts.email = {
    maildirBasePath = "${config.xdg.dataHome}/mail";
    accounts = {
      main = mkEmailAccount {
        primary = true;
        address = "omarcoptan9@gmail.com";
        flavor = gmailFlavor;
      };
      alt = mkEmailAccount {
        address = "theomarmohamedofficial@gmail.com";
        flavor = gmailFlavor;
      };
      # uni = mkEmailAccount {
      #   address = "omar.mohamed.cs@o6u.edu.eg";
      #   flavor = outlookFlavor;
      # };
    };
  };
}
