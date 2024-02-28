function fish_prompt
  set ResetColor (set_color normal)
  set DefaultColor (set_color d8dee8)
  set UserColor (set_color 5c5c5c)
  set Prompt (echo $PWD | sed -e "s|^$HOME/|~)|")
  set Prompt "$UserColor$USER$DefaultColor|$Prompt$ResetColor"
  echo -es "><$Prompt>"
end
