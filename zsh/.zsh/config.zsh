HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000

setopt auto_cd extended_glob nomatch notify chaselinks cdablevars
setopt prompt_subst no_beep no_flowcontrol interactive_comments
setopt complete_in_word completealiases always_to_end list_types
setopt appendhistory hist_ignore_space  hist_ignore_dups
setopt inc_append_history share_history hist_reduce_blanks
setopt hash_list_all extended_history


# Kill the lag
export KEYTIMEOUT=1

autoload -Uz colors && colors

bindkey -r "^[/"
bindkey -M vicmd -r "/"
bindkey -r "^H" backward-delete-char


WORDCHARS='*?_~&!#$%^)}]>'




export PS1="%{$fg_bold[red]%}%n%{$reset_color%}@%{$fg_bold[red]%}%m%{$reset_color%}% :%{$fg_no_bold[yellow]%}%d %{$reset_color%}
→ %"

#ugly fix for right line alignment
# _lineup=$'\e[1A'
# _linedown=$'\e[1B'

export RPS1='$(_git_prompt)' #_git_prompt declared in zle.zsh



bindkey '^A' beginning-of-line
bindkey '^E' end-of-line


bindkey '^F' forward-char
bindkey '^B' backward-char




bindkey "^P" up-history
bindkey '^r' history-incremental-search-backward
bindkey '^N' down-history
#bindkey '^?' backward-delete-char
#bindkey '^h' backward-delete-char
bindkey '^w' backward-delete-word
bindkey '^u' backward-kill-line
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

bindkey -a G end-of-buffer-or-history
bindkey -M visual 'U' up-case-word
bindkey -M visual 'u' down-case-word

[[ -n $DISPLAY ]] && (( $+commands[xclip] )) && {

  function cutbuffer() {
    zle .$WIDGET
    echo $CUTBUFFER | xclip -selection primary
  }

  zle_cut_widgets=(
    vi-backward-delete-char
    vi-change
    vi-change-eol
    vi-change-whole-line
    vi-delete
    vi-delete-char
    vi-kill-eol
    vi-substitute
    vi-yank
    vi-yank-eol
  )
  for widget in $zle_cut_widgets
  do
    zle -N $widget cutbuffer
  done

  function putbuffer() {
    zle copy-region-as-kill "$(xclip -o)"
    zle .$WIDGET
  }

  zle_put_widgets=(
    vi-put-after
    vi-put-before
  )
  for widget in $zle_put_widgets
  do
    zle -N $widget putbuffer
  done
}


