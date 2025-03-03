paleofetch

# History in cache directory:
HISTSIZE=2000
HISTFILESIZE=5000
HISTFILE=~/.cache/zsh/zsh_history

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliases/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliases/aliasrc"

# # Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Set up fast movement with fuzzy finding
show_file_or_dir_preview="if [ -d {} ]; then lsd --tree {} --color=always --icon=always | head -200; else bat -n --color=always --line-range :500 {}; fi"

# Set Up Autojump Functions 
f() {
    cd "$(autojump -s | awk -F'\t' '{if (system("[ -d \"" $2 "\" ]") == 0) print $2}' | fzf --height 40% --reverse --border --ansi --preview $show_file_or_dir_preview)"
}

bindkey -s "^f" 'f\n'
bindkey -s "^g" 'lazygit\n'

# VIM
#########################

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Enable searching through history
bindkey '^R' history-incremental-pattern-search-backward

# Edit line in vim buffer ctrl-v
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line
# Enter vim buffer from normal mode
autoload -U edit-command-line && zle -N edit-command-line && bindkey -M vicmd "^v" edit-command-line

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char
# Fix backspace bug when switching modes
bindkey "^?" backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
   if [[ ${KEYMAP} == vicmd ]] ||
      [[ $1 = 'block' ]]; then
     echo -ne '\e[1 q'
   elif [[ ${KEYMAP} == main ]] ||
        [[ ${KEYMAP} == viins ]] ||
        [[ ${KEYMAP} = '' ]] ||
        [[ $1 = 'beam' ]]; then
     echo -ne '\e[5 q'
   fi
 }
zle -N zle-keymap-select

# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, ci<, di{, etc
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
precmd() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Control bindings for programs
#
# bindkey -s "^g" "lc\n"
bindkey -s "^h" "history 1\n"
bindkey -s "^l" "clear\n"
bindkey -s "^d" "dlfile\n"

# Disable annoying sounds 
unsetopt BEEP

# Load fzf configurations
[ -f ~/.config/fzf/fzf.zsh ] && source ~/.config/fzf/fzf.zsh

# zsh auto-suggestion
source $HOME/.config/shell/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load powerlevel10k 
source $HOME/.config/shell/powerlevel10k/powerlevel10k.zsh-theme

# zsh syntax highlighting
source $HOME/.config/shell/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# # To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
#   eval "$(oh-my-posh init zsh --config $HOME/.config/oh_my_posh/base.toml)"
# fi

# To add autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# Border for yabai
borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=8.0  