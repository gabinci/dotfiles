<!-- vim:set ft=markdown -->

![banner](/images/banner.png)

### **Disclaimer:**

These dotfiles weren't tested on any other OS or Linux Distros. I use Fedora Linux 36 (KDE plasma)

---

### TABLE OF CONTENTS:

- [NVIM](https://github.com/gabinci/dotfiles#nvim)
- [ZSH] ()

# NVIM

![nvim Image 1](/images/nvim01.png)

![nvim image 2](/images/nvim02.png)

theme: [gruvbox (community edition)](https://github.com/gruvbox-community/gruvbox)

---

### **IMPORTANT!** <br>

Please, before opening Neovim, complete the insltalation process, otherwise you will be missing some dependencies.

- Make sure you have [Git](https://git-scm.com/), [nodejs](https://nodejs.org/) and [npm](https://www.npmjs.com/) installled
- I will be using [Brew](https://docs.brew.sh/Installation) for installing a bunch of stuff.

---

## installation:

1. Install [packer](https://github.com/wbthomason/packer.nvim):

The installation for packer is pretty simple. Paste this in your terminal and you're good to go.

```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

2. Brew install dependencies:

- [sumneko -- Lua Language Server](https://github.com/sumneko/lua-language-server#lua-language-server)

```
brew install lua-language-server
```

- [Tree-Sitter](https://github.com/tree-sitter/tree-sitter)

```
brew install tree-sitter
```

- gcc

```
sudo dnf install gcc gcc-c++
```

- [RipGrep](https://github.com/BurntSushi/ripgrep)

```
brew install rg
```

You may also need to install g++

```
sudo dnf install gcc-c++
```

3. npm install dependencies:

- prettierd

```
npm install -g @fsouza/prettierd
```

# ZSH

For my zsh configuration:

1. [zap plugin manager](https://github.com/zap-zsh/zap)

2. catppuchin theme

3. [powerlevel 10k prompt](https://github.com/romkatv/powerlevel10k)

### **Credits:**

- I took a lot of inspiration from [CraftzDog](https://github.com/craftzdog) (specially from one of his [YouTube video](https://www.youtube.com/watch?v=ajmK0ZNcM4Q&t)).

- [ThePrimegen](https://github.com/ThePrimeagen) was of great help while researching for my dotfiles.

- The YouTube series [Neovim from Scratch](https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ) also was a great font of inspiration for me.

```
sudo dnf install dbus-devel gcc git libconfig-devel libdrm-devel libev-devel libX11-devel libX11-xcb libXext-devel libxcb-devel mesa-libGL-devel meson pcre-devel pixman-devel uthash-devel xcb-util-image-devel xcb-util-renderutil-devel xorg-x11-proto-devel
```

xbacklight
kmix
spectacle

https://stackoverflow.com/questions/25588367/how-to-control-backlight-by-terminal-command

zoxide

```bash
eval "$(zoxide init zsh)"
```

# FONTS

source: [ terminal roots ](https://github.com/terroo)

```bash
git clone https://github.com/terroo/fonts -b fonts --single-branch
cd fonts/fonts && mv $HOME/.local/share/
fc-cache -fv
```

# lf

lynx
ba
ffmpegthumbnailer

# fzf

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
