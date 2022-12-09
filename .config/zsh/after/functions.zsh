#!/bin/zsh

# Find files with fzf
function ff() {
  dir=${1:-$PWD}
  (
  cd $dir 
  fd -Htf --full-path --exclude .git/ $dir | fzf -m --reverse --info=inline --prompt="Chose files ﰲ "| sed "s|~|$HOME|" |xargs -r $EDITOR;
  ) 
}

# function book() {
#   mark="$(sed -e 's/\s*#.*//' -e '/^$/d' -e 's/^\S*\s*//' $HOME/.local/bin/bookmarks/dirs | fzf   --prompt='Bookmark ﰲ '  | sed 's|~|$HOME|')" && eval cd $mark
# }


# transfer
transfer(){ if [ $# -eq 0 ];then echo "No arguments specified.\nUsage:\n transfer <file|directory>\n ... | transfer <file_name>">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip" ,;(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null,;else cat "$file"|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;}

    
