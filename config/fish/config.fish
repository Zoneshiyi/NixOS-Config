if not status --is-interactive
  return
end

set -g fish_greeting ''
starship init fish | source

set -gx FZF_DEFAULT_OPTS "--preview 'echo {}' --preview-window=right:50%:wrap"
fzf --fish | source
bind \ch fzf-history-widget
bind -M insert \ch fzf-history-widget

# fzf.fish plugin
bind \cp _fzf_search_processes
bind -M insert \cp _fzf_search_processes

zoxide init fish --cmd cd | source
