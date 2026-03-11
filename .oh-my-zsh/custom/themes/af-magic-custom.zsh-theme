# Based on af-magic.zsh-theme
# Original author: Andy Fleming
# URL: http://andyfleming.com/

# Colors
directory_color="%F{#61afef}"
green="%F{green}"
yellow="%F{yellow}"
red="%F{red}"
comment_color="%F{#565f89}"

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

  local git_color=$comment_color

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
  echo "${git_color}(${branch_color}${branch_name}${git_color})%f"
}

compressed_path() {
  local path="${PWD/#$HOME/~}"
  local parts=(${(s:/:)path})

  local result=()
  local nbr_full_dir_names=2

  if (( ${#parts} == 0 )); then
    echo "${directory_color}/%f"
    return
  fi

  for i in {1..${#parts}}; do
    if (( i <= ${#parts} - nbr_full_dir_names )); then
      if [[ ${parts[i]} == "~" ]]; then
        result+=("~")
      else
        # For hidden directories, we want to keep the dot and the first character of the name
        if [[ ${parts[i]} == .* ]]; then
          result+=("${parts[i][1,2]}")
        else
          result+=("${parts[i][1]}")
        fi
      fi
    else
      result+=("${parts[i]}")
    fi
  done

  joint_result="${(j:/:)result}"

  # The path should start with a slash if it's not a home path
  [[ $path == "~"* ]] || joint_result="/$joint_result"

  echo "${directory_color}${joint_result}%f"
}

# Dashed line with terminal width as length
prompt_separator="${comment_color}\${(l.\$(venv_adjusted_terminal_width)..-.)}%f"

# Primary prompt
PS1="${prompt_separator}%B\$(compressed_path) \$(git_prompt)%f%b "

# Secondary prompt
PS2="> "

# Right prompt: error code, virtualenv
RPS1="%(?..${red}%? ↵%f)"
if (( $+functions[virtualenv_prompt_info] )); then
  RPS1+='$(virtualenv_prompt_info)'
fi

# virtualenv settings
ZSH_THEME_VIRTUALENV_PREFIX=" ${comment_color}["
ZSH_THEME_VIRTUALENV_SUFFIX="]%f"
