set -g fish_greeting ''

set -gx ATUIN_NOBIND "true"
atuin init fish | source
bind \ch _atuin_search
bind -M insert \ch _atuin_search

set -gx FZF_DEFAULT_OPTS "--preview 'echo {}' --preview-window=right:50%:wrap"
fzf --fish | source
bind \e\ch fzf-history-widget
bind -M insert \e\ch fzf-history-widget

# fzf.fish plugin
bind \cp _fzf_search_processes
bind -M insert \cp _fzf_search_processes

zoxide init fish --cmd cd | source

if status --is-interactive
end

if status --is-login
end
