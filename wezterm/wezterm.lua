local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font_size = 14
config.font = wezterm.font "Fira Code"

config.window_background_opacity = .8
config.window_decorations = "NONE"

config.color_scheme = 'AdventureTime'
config.color_scheme = 'GitHub Dark'

config.hide_tab_bar_if_only_one_tab = true

local nushell_home = os.getenv("HOME") .. "/magit/dotfiles/nushell"
config.default_prog = {
  "nu",
  "--no-std-lib",
  "--config",
  nushell_home .. "/config.nu",
  "--env-config",
  nushell_home .. "/env.nu"
}
--hello /root

return config
