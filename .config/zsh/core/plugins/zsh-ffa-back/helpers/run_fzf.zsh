#!/bin/zsh

# Run fzf to select files and directories with ".." to go up one level
run_fzf() {
  while true; do
    local prompt_dir="$dir"
    if [[ "$dir" == "$HOME" ]]; then
      prompt_dir="~/"
    elif [[ "$dir" == "$HOME/"* ]]; then
      prompt_dir="~/${dir#$HOME/}"
    fi
    local selected_items=$( (echo ".." && cd "$dir" && fd --full-path "${fd_exclude_args[@]}" "${fd_type_args[@]}") | fzf --preview "${fzf_preview_cmd}" --preview-window=right:60%:wrap --bind "${fzf_bindings}" -m --reverse --info=inline --prompt="$prompt_dir  ")

    if [[ -z $selected_items ]]; then
      if [[ $verbose == true ]]; then
        echo "No item selected."
      fi
      return
    elif [[ $selected_items == ".." ]]; then
      dir=$(dirname "$dir")
      cd "$dir"
    elif [[ -d "$dir/$selected_items" ]]; then
      cd "$dir/$selected_items"
      ffa
      return
    else
      # Handle multi-selection
      local files=()
      for selected_item in ${(f)selected_items}; do
        if [[ -d $selected_item ]]; then
          dir="${selected_item%/}"
        else
          files+=("$dir/$selected_item")
        fi
      done
      if [[ ${#files[@]} -gt 0 ]]; then
        $editor $split_flag "${(@)files}"
        break
      fi
    fi
  done
}
