

> TODO: later implement the option to search bach with fd 
> https://github.com/sharkdp/fd/issues/731

```sh
#!/bin/bash
set -e
path="$PWD"
while [[ $(realpath "$path") != / ]]; do
    fd \
        --search-path="$path" \
        --absolute-path \
        --exact-depth=1 \
        "$@"
    path="$(realpath --relative-to="$PWD" "$path"/..)"
done
```

> TODO: add some sort of bookmarks system, for folders and files 
  
> TODO: add creating files
> TODO: add moving files
> TODO: add renaming files


