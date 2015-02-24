# ------------------------------------------------------------------------
# Juan G. Hurtado oh-my-zsh theme
# Pawel 'kTT' Salata oh-my-zsh theme
# (Based on juanghurtado.zsh-theme)
# (Needs Git plugin for current_branch method)
# ------------------------------------------------------------------------

# Color shortcuts
RED=$fg[red]
YELLOW=$fg[yellow]
GREEN=$fg[green]
WHITE=$fg[white]
BLUE=$fg[blue]
RED_BOLD=$fg_bold[red]
YELLOW_BOLD=$fg_bold[yellow]
GREEN_BOLD=$fg_bold[green]
WHITE_BOLD=$fg_bold[white]
BLUE_BOLD=$fg_bold[blue]
RESET_COLOR=$reset_color

# Format for git_prompt_info()
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""

# Format for parse_git_dirty()
ZSH_THEME_GIT_PROMPT_DIRTY="%{$RED%}*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Format for git_prompt_status()
#ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$RED%}●"
#ZSH_THEME_GIT_PROMPT_DELETED=" %{$RED%}●"
#ZSH_THEME_GIT_PROMPT_RENAMED=" %{$YELLOW%}●"
#ZSH_THEME_GIT_PROMPT_MODIFIED=" %{$YELLOW%}●"
#ZSH_THEME_GIT_PROMPT_ADDED=" %{$GREEN%}●"
#ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$WHITE%}●"

ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$RED%}unm"
ZSH_THEME_GIT_PROMPT_DELETED=" %{$RED%}del"
ZSH_THEME_GIT_PROMPT_RENAMED=" %{$YELLOW%}ren"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %{$YELLOW%}mod"
ZSH_THEME_GIT_PROMPT_ADDED=" %{$GREEN%}add"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$WHITE%}unt"

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD="%{$RED%}!"

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$WHITE%}[%{$YELLOW%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$WHITE%}]"

# Prompt format
NORMAL_MODE="%{$fg[green]%}>%{${reset_color}%}"
INSERT_MODE="%{$fg[red]%}>%{${reset_color}%}"
if [ $(id -u) -eq 0 ];
then # root
   SECOND_COLOR=$fg[red]
else # normal
   SECOND_COLOR=$fg[green]
fi
PROMPT='%{$fg[gray]%}>%{$SECOND_COLOR%}>$(vi_mode_prompt_info)%{${reset_color}%} '
RPROMPT='%~%u %{$GREEN_BOLD%}$(current_branch)$(parse_git_dirty)$(git_prompt_ahead)$(git_prompt_short_sha)$(git_prompt_status)%{$RESET_COLOR%}'
