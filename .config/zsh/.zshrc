setopt autocd
setopt interactive_comments
setopt prompt_subst
setopt histignorespace
setopt hist_reduce_blanks
setopt hist_verify
setopt hist_ignore_all_dups
stty stop undef

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
autoload -U vcs_info
zstyle ":vcs_info:*" enable git svn
zstyle ":vcs_info:*" formats "(%b) "
precmd() {
	vcs_info
	echo -ne "\e[1 q"
}
PROMPT='%B%F{cyan}%c %F{blue}${vcs_info_msg_0_}%F{%(?.green.red)}>%f%b '
RPROMPT='%(?..[%F{red}%?%f] )'
[ -n "${SSH_TTY:-}" ] && PROMPT="%F{magenta}[%M] $PROMPT"

# History in cache directory:
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
HISTFILE="${HISTFILE:-${XDG_STATE_HOME:-$HOME/.local/state}/history}"

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

bindkey -v
KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# bindkey -s "^o" '^uxdg-open "$(fzf)" >/dev/null\n'
# bindkey -s "^f" '^ue "$(find ~/ -type f 2>/dev/null | fzf)"\n'
# bindkey -s "^g" '^ucd "$(find ~/ -type d 2>/dev/null | fzf)"\n'
# bindkey -s "^n" '^ucd "$(find $ZK_NOTEBOOK_DIR/ -type d 2>/dev/null | fzf)"\n'
# bindkey -s "^t" '^u[ -f TODO.md ] && $EDITOR TODO.md || notes todo\n'
# bindkey -s "^f" "tmux-sessionizer\n"
autoload -Uz add-zsh-hook
zshcache_time="$(date +%s%N)"
precmd_rehash() {
	[ -f /var/cache/zsh/pacman ] && {
		local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
		[ "$zshcache_time" -lt "$paccache_time" ] && {
			rehash
			zshcache_time="$paccache_time"
		}
	}
}
add-zsh-hook -Uz precmd precmd_rehash

fzf_select_widget() {
	local file="$(fd --type f --hidden --strip-cwd-prefix | fzf | xargs printf "%q")" || return
	BUFFER="$BUFFER $file"
	zle redisplay
	zle accept-line
}
zle -N fzf_select_widget
bindkey "^s" fzf_select_widget

fzf_editor_widget() {
	local file="$(fd --type f --hidden --strip-cwd-prefix | fzf | xargs printf "%q")" || return
	BUFFER="$EDITOR $file"
	zle redisplay
	zle accept-line
}
zle -N fzf_editor_widget
bindkey "^f" fzf_editor_widget

fzf_open_widget() {
	local file="$(fd --type f --hidden --strip-cwd-prefix | fzf | xargs printf "%q")" || return
	opener="open"
	command -v "$opener" >/dev/null 2>&1 || opener="xdg-open"
	BUFFER="$opener $file"
	zle redisplay
	zle accept-line
}
zle -N fzf_open_widget
bindkey "^o" fzf_open_widget

fzf_cd_widget() {
	local dir="$(fd --type d --hidden --strip-cwd-prefix | fzf | xargs printf "%q")" || return
	BUFFER="cd $dir"
	zle redisplay
	zle accept-line
}
zle -N fzf_cd_widget
bindkey "^g" fzf_cd_widget

todo_widget() {
	BUFFER="notes todo"
	[ -f TODO.md ] && BUFFER="$EDITOR TODO.md"
	zle redisplay
	zle accept-line
}
zle -N todo_widget
bindkey "^t" todo_widget

# cd on exit
n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f -- "$NNN_TMPFILE" > /dev/null
    }
}

bindkey -s '^n' 'n^M'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

ZSHPLUGINSDIR="${ZSHPLUGINSDIR:-/usr/share/zsh/plugins}"
if [ -f "$ZSHPLUGINSDIR/zsh-history-substring-search/zsh-history-substring-search.zsh" ]; then
	. "$ZSHPLUGINSDIR/zsh-history-substring-search/zsh-history-substring-search.zsh"
	bindkey -a "k" history-substring-search-up
	bindkey -a "j" history-substring-search-down
	bindkey "^[[A" history-substring-search-up
	bindkey "^[[B" history-substring-search-down
fi
if [ -f "$ZSHPLUGINSDIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" ]; then
	ZSH_AUTOSUGGEST_STRATEGY=(history completion)
	. "$ZSHPLUGINSDIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
fi
[ -f "$ZSHPLUGINSDIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ] &&
	. "$ZSHPLUGINSDIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" &&
	[ -f "$XDG_CONFIG_HOME/fsh/overlay.ini" ] &&
	command -v fast-theme >/dev/null 2>&1 &&
	fast-theme XDG:overlay >/dev/null 2>&1

[ -r /usr/share/z/z.sh ] && . /usr/share/z/z.sh
