dir="${0:A:h}"
source "$dir/git-prompt.sh"

function git_prompt_info() {
  dirty="$(parse_git_dirty)"
  a=$(git_commits_ahead 2>/dev/null)
  b=$(git_commits_behind 2>/dev/null)
  ab="${a:=-}|${b:=-}"
  [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == true ]] && wip=$(git log -1 | fgrep -- '--wip-- [skip ci]' | xargs -i echo " € ")
  __git_ps1 "$(date +%T) ${ZSH_THEME_GIT_PROMPT_PREFIX//\%/%%}%s${dirty//\%/%%}${ZSH_THEME_GIT_PROMPT_SUFFIX//\%/%%}%%{$fg_bold[green]%%}($a%%{$reset_color%%}|%%{$fg_bold[red]%%}$b)%%{$fg_bold[yellow]%%}[$(jobs|wc -l)]{$(git stash list 2>/dev/null|wc -l)}%%{$fg_bold[red]%%}$wip%%{$fg_bold[yellow]%%}$%%{$reset_color%%} "
}

unset dir
