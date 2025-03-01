progress list for my ffa function 
---

# DIR. SEARCH

### Potential Improvements for Searching Files and Directories
[x] - 1. Include Directories in Search: Modify the search command to include both files and directories in the results.
[x] - 2. File and Directory Filtering: Provide options to filter results for only files, only directories, or both.
[x] - 3. Preview Feature: Enable a preview window to show the contents of files or the structure of directories.
--> [x] - 3.1. add feature to preview files with bat and dirs with tree
--> [x] - 3.2. add feature fallback from bat and tree to cat and ls | \\see [[dependencies]]

[?] - 4. Custom Actions for Directories: Allow custom actions for directories, such as opening in a file manager or listing contents.
[?] - 5. Indicator for Directories: Add an indicator in the search results to distinguish between files and directories. (icons)

### Steps to Implement
[x] - 1. Modify Search Command: Update the search command to include both files and directories.
[x] - 2. Add Filtering Options: Implement options to filter the search results based on user preferences.
--> [x] - 2.1. add feature to search for file only | -f
--> [x] - 2.2. add feature to search for dirs only | -d
--> [x] - 2.3. add feature to hide hidden files and paths | -i
--> [x] - 2.4. add feature to search for specific fifle types only ==> --type or -t .zsh / .md
--> [ ] - 2.5. add feature to exclude certain patterns | -e or --exclude ==> --exclude words to exclude | -e removed

[x] - 3. Enhance Preview Feature: Update the preview feature to handle both files and directories.
[ ] - 4. Customize Actions: Implement actions that can be performed on directories.
--> [x] - 4.1. add feature to create new files (or dir) under current dir | ctrl-a (add) ==> prompt for file name (end with / for directory)
--> [ ] - 4.2. add feature to rename file under cursor | ctrl-r (rename) ==> prompt for new file name
--> [ ] - 4.3. add feature to move file under cursor | ctrl-m (move) ==> stage file and wait for ctrl-m to be pressed again | wait for confirmation
--> [ ] - 4.4. add feature to copy current file path | ctrl-y (yank) ==> detect terminal and set clipboard command | compatible with multiple OS

[x] - 5. add the hability to navigate back dirs with .. and forth by selecting dir
--> [ ] - 5.1. add feature to go to specific dir. | ctrl-g (go-to)

### Bug fixes 
[x] keep flag options when navigating back and forth  

---

GLOSSARY: [ ] - not implemented | [x] - implemented | [?] - not sure if I want to implement
