#####################################################
# paths
#####################################################
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(anyenv init -)"
. `brew --prefix`/etc/profile.d/z.sh

#####################################################
# completion
#####################################################
autoload -U compinit; compinit
# highlight
zstyle ':completion:*:default' menu select=2

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

#####################################################
# commands
#####################################################
# mkdirとcdを同時実行
function mkcd() {
  if [[ -d $1 ]]; then
    echo "$1 already exists!"
    cd $1
  else
    mkdir -p $1 && cd $1
  fi
}

#####################################################
# aliases
#####################################################
alias ll='exa --long --group --header --icons'
alias lla='ll -a'
alias llg='ll --git'
alias llga='ll --git -a'
alias g='git'
alias -g gcb='git branch --contains | cut -d " " -f 2'
alias -g G='| grep'
alias tns='tmux new -s'
alias ta='tmux a -t'
alias -g tl='tree -L'
alias -g C='| pbcopy'
alias tls='tmux ls'
alias ti='tig'
alias vim='nvim'
alias dco='docker-compose'
alias zz='nvim ~/.zshrc'
alias sz='source ~/.zshrc'

#####################################################
# zsh plugins
#####################################################
# zinit(package manager for zsh plugins)
# https://github.com/zdharma-continuum/zinit
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# powerlevel10k
# https://github.com/romkatv/powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k
### Added by Powerlevel10k
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
### End of Powerlevel10k's chunk

# completion
zinit light zsh-users/zsh-autosuggestions

# syntax highlight
zinit light zdharma/fast-syntax-highlighting

# search command history
zinit light zdharma/history-search-multi-word

# github support
zinit light paulirish/git-open
