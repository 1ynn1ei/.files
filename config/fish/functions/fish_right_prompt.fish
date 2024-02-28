function fish_right_prompt
  # theme
  set ResetColor (set_color normal)
  set DefaultColor (set_color d8dee8)
  set DirtyBgColor (set_color -b 64403e)
  set CleanBgColor (set_color -b 122932)

  set Prompt
  # git
  if test -e ".git"
    set dirty (git status --porcelain)
    set branch (git rev-parse --abbrev-ref HEAD)
    set branch_start "["
    set branch_end "]"
    if test -z "$dirty"
      set Prompt "$Prompt$CleanBgColor"
    else
      set Prompt "$Prompt$DirtyBgColor"
    end
    set Prompt "$Prompt$branch_start$branch$branch_end@"
  end
  # components
  set time (date +%R)
  set time_start "("
  set time_end ")"

  set Prompt "$Prompt$DefaultColor$time_start$time$time_end$ResetColor"
  echo -es "$Prompt"
end
