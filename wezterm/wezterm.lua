local wezterm = require 'wezterm'
local config = wezterm.config_builder()

wezterm.plugin
  .require('https://github.com/yriveiro/wezterm-tabs')
  .apply_to_config(config,{
     tabs = {
       tab_bar_at_bottom = true
     }
   })

config.colors = {
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = '#0b0022',

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = '#2b2042',
      -- The color of the text for the tab
      fg_color = '#c0c0c0',

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = 'Bold',

      -- Specify whether you want "None", "Single" or "Double" underline for
      -- label shown for this tab.
      -- The default is "None"
      underline = 'Double',

      -- Specify whether you want the text to be italic (true) or not (false)
      -- for this tab.  The default is false.
      italic = true,
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = '#1b1032',
      fg_color = '#808080',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#909090',
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab_hover`.
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = '#1b1032',
      fg_color = '#808080',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#909090',
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab_hover`.
    },
  },
}

-- NOTE : sometimes this is required for windows to work
-- config.prefer_egl = "true"

config.window_decorations = "RESIZE"
config.window_background_opacity = .8

config.font_size = 14
config.font = wezterm.font "Fira Code"

config.color_scheme = 'GitHub Dark'

config.hide_tab_bar_if_only_one_tab = true

local nushell_home = os.getenv("HOME") .. "/magit/dotfiles/nushell/"
config.default_prog = {
  "nu",
  "--no-std-lib",
  "--config",
  nushell_home .. "config.nu",
  "--env-config",
  nushell_home .. "env.nu"
}

config.keys = {
  {
    key = 't',
    mods = 'META',
    action = wezterm.action.SpawnTab('CurrentPaneDomain'),
  },
  {
    key = 't',
    mods = 'META|SHIFT',
    action = wezterm.action.CloseCurrentTab({confirm = true}),
  },
}

for i = 0,8 do
  config.keys[#config.keys+1] = {
    key = tostring(i + 1),
    mods = 'META',
    action = wezterm.action.ActivateTab(i),
  }
end

return config
