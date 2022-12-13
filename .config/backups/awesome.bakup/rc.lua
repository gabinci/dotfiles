local awful = require("awful")

require("awful.autofocus")
require("awful.hotkeys_popup.keys")
require("before.error")
require("before.env")
require("before.theme")
require("before.menu")

awful.spawn.with_shell("~/.config/awesome/core/autostart.sh")
require("core.keymaps")

require("after.rules")
require("after.wibar")
require("after.signals")
