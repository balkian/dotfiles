local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'Iosevka Nerd Font'
config.show_tab_index_in_tab_bar = true

-- wezterm.on('update-right-status', function(window, pane)
--   window:set_left_status 'left'
--   window:set_right_status 'right'
-- end)

config.use_fancy_tab_bar = true
config.show_tabs_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

return config
