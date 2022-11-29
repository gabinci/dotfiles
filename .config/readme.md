<h1 align="center">DOTFILES</h1>
<p align="center">🚧 Forever a WIP 🚧</p>

### **DISCLAIMER:**

These dotfiles weren't tested on any other OS or Linux Distros. I use Fedora Linux 36 (KDE plasma)

### TABLE OF CONTENTS:

- [NVIM](https://github.com/gabinci/dotfiles#nvim)
- [Awesome WM]()
- [FireFox]()
- [ZSH]()
- [Kitty]()
- [Picom]()
- [Polybar]()
- [Ranger]()
- [Rofi]()

### SOME DEPENDENCIES

```
sudo dnf install dbus-devel gcc git libconfig-devel libdrm-devel libev-devel libX11-devel libX11-xcb libXext-devel libxcb-devel mesa-libGL-devel meson pcre-devel pixman-devel uthash-devel xcb-util-image-devel xcb-util-renderutil-devel xorg-x11-proto-devel
```

### NVIM

## installation:

1. Install [packer](https://github.com/wbthomason/packer.nvim):

The installation for packer is pretty simple. Paste this in your terminal and you're good to go.

```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
