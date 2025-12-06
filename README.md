# .dotfiles

> A backup for all the configs I use on my linux

## Setup

> [!NOTE]
> By default the `setup` script will symlink the dotfiles to your home directory
and copy files from `etc` directory to your root `/etc` directory, this will
override your files. Backup your files and read the code before running it.

Clone the repo and run the `setup` script:

```sh
git clone https://github.com/c0pt4n/.dotfiles.git
cd .dotfiles
./setup dotfiles
```

However, if you want to install the packages and setup everything for a fresh
[Artix Linux](https://artixlinux.org/), run the `setup` script with `install`
subcommand instead:

```sh
./setup install
```

## Post Install

### pam_ssh

add the following to /etc/pam.d/login
```pamconf
...
-auth        optional    pam_ssh.so    try_first_pass
...
-session     optional    pam_ssh.so
```
[Homepage](https://pam-ssh.sourceforge.net/)
[ArchWiki](https://wiki.archlinux.org/title/SSH_keys#pam_ssh)

### Fix Suspend/Hibernate for Nvidia GPU

1. edit the following switch case in /usr/lib/elogind/system-sleep/nvidia

```bash
case "$1" in
    post)
        /usr/bin/nvidia-sleep.sh "resume"
        ;;
esac
```

to

```bash
case "$1" in
	pre)
		/usr/bin/nvidia-sleep.sh "suspend"
		;;
    post)
        /usr/bin/nvidia-sleep.sh "resume"
        ;;
esac
```

2. add resume=/dev/nvmeXXXXX to /etc/default/grub

3. edit the /etc/tmpfiles.d/hibernation_resume.conf offset depending on output of `lsblk`

4. add resume module in /etc/mkinitcpio.conf

5. add nvme module to MODULES in /etc/mkinitcpio.conf
