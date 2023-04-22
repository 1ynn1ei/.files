# requires spectrum

CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''
USER_COLOR=234
USER_ICON_COLOR=211
GIT_DIRTY=214
GIT_UPTODATE=108
GIT_TEXT_COLOR=234
TEXT_COLOR=244
DIR_COLOR=235
# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
    # echo $(pwd | sed -e "s,^$HOME,~," | sed "s@\(.\)[^/]*/@\1/@g")
    # echo $(pwd | sed -e "s,^$HOME,~,")
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR "
  else
    echo -n "%{%k%} "
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment $USER_COLOR 230 "%(!.%{%F{$GIT_DIRTY}%}.)%{%F{$USER_ICON_COLOR}%}%{%f%}"
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  local ref dirty
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    ZSH_THEME_GIT_PROMPT_DIRTY='±'
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment $GIT_DIRTY $GIT_TEXT_COLOR
    else
      prompt_segment $GIT_UPTODATE $GIT_TEXT_COLOR
    fi
    echo -n "${ref/refs\/heads\// }$dirty"
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_segment $DIR_COLOR $TEXT_COLOR '%3~'
  # prompt_segment blue black "…${PWD: -30}"
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path ]]; then
    prompt_segment green black " $(basename $virtualenv_path)"
  fi
}

# Current AWS profile
prompt_aws_profile() {

  if [[ -n $AWS_PROFILE ]]; then
    if [[ "$AWS_PROFILE" == "default" ]]; then
      prompt_segment red default "⚡ $AWS_PROFILE"
    else
      prompt_segment black default "⚡ $AWS_PROFILE"
    fi
  fi
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_context
  prompt_aws_profile
  prompt_dir
  prompt_virtualenv
  prompt_git
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '

# Deactivate the default virtualenv prompt (https://stackoverflow.com/questions/16257950/how-to-create-a-python-virtualenv-environment-without-prompt-prefix)
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Atom colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxeg


