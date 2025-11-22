# Based on af-magic.zsh-theme
# Original author: Andy Fleming
# URL: http://andyfleming.com/

# Colors
blue="%F{032}"
green="%F{green}"
yellow="%F{yellow}"
red="%F{red}"
gray="%F{237}"

function venv_adjusted_terminal_width {
  local python_env_dir="${VIRTUAL_ENV}"
  local python_env="${python_env_dir##*/}"

  # if there is a python virtual environment and it is displayed in
  # the prompt, account for it when returning the number of dashes
  if [[ -n "$python_env" && "$PS1" = *\(${python_env}\)* ]]; then
    echo $(( COLUMNS - ${#python_env} - 3 ))
  elif [[ -n "$VIRTUAL_ENV_PROMPT" && "$PS1" = *${VIRTUAL_ENV_PROMPT}* ]]; then
    echo $(( COLUMNS - ${#VIRTUAL_ENV_PROMPT} - 3 ))
  else
    echo $COLUMNS
  fi
}

git_prompt() {
  # Check if inside git repo
  git rev-parse --is-inside-work-tree &>/dev/null || return

  local toplevel=$(git rev-parse --show-toplevel 2>/dev/null)

  local git_color=$blue

  # Change branch color depending on git state
  # Clean branch
  local branch_color=$green  
  # Check staged change - Staged branch
  if ! git -C "$toplevel" diff --cached --quiet; then
    branch_color=$yellow
  fi
  # Check unstaged or untracked changes - Dirty branch
  if ! git -C "$toplevel" diff --quiet || [[ -n $(git -C "$toplevel" ls-files --others --exclude-standard) ]]; then
    branch_color=$red
  fi

  local branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

  # Return git prompt
  echo " ${git_color}git:(${branch_color}${branch_name}${git_color})%f"
}

# Dashed line with terminal width as length
prompt_separator="${gray}\${(l.\$(venv_adjusted_terminal_width)..-.)}%f"

# Primary prompt
PS1="${prompt_separator}%B${yellow}%~\$(git_prompt)%f%b "

# Secondary prompt
PS2="> "

# Right prompt: error code, virtualenv
RPS1="%(?..${red}%? ↵%f)"
if (( $+functions[virtualenv_prompt_info] )); then
  RPS1+='$(virtualenv_prompt_info)'
fi

# virtualenv settings
ZSH_THEME_VIRTUALENV_PREFIX=" ${gray}["
ZSH_THEME_VIRTUALENV_SUFFIX="]%f"
