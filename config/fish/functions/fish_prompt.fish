function fish_prompt
  # theme
  set ResetColor (set_color normal)
  set DefaultColor (set_color d8dee8)
  set UserColor (set_color 5c5c5c)

  # components
  set p (prompt_pwd)

  # pulling together
  set FPromptBegin "$UserColor$USER$DefaultColor|$p$ResetColor"
  echo -es $FPromptBegin ">"
end

