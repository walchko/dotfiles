override_git_prompt_colors() {
  GIT_PROMPT_THEME_NAME="Custom" # needed for reload optimization, should be unique

  GIT_PROMPT_START_USER="${Green}\u@${BoldBlue}\\h ${Cyan}\W"
  GIT_PROMPT_END_USER="${ResetColor} $ "
  GIT_PROMPT_END_ROOT="${BoldRed} # "
}

# load the theme
reload_git_prompt_colors "Custom"
