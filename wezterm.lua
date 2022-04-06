local wezterm = require 'wezterm';
local dracula = require 'dracula/dracula';

dracula.background = "black"
dracula.tab_bar = nil

return {
  audible_bell = "Disabled",
  colors = dracula,
  exit_behavior = "Close",
  font = wezterm.font_with_fallback({ { family = "Fira Code", weight = 450 }, "Zapf Dingbats" }),
  font_size = 14,
  freetype_load_target = "Light",
  hide_tab_bar_if_only_one_tab = true,
  line_height = 1.2,
  native_macos_fullscreen_mode = true,
  scrollback_lines = 10000,
  window_background_opacity = 0.85,
  window_close_confirmation = "NeverPrompt",
  keys = {
    { key = "w", mods = "CMD", action = wezterm.action { CloseCurrentTab = { confirm = false } } },
    { key = "k", mods = "CMD", action = wezterm.action { ClearScrollback = "ScrollbackAndViewport" } },
  },
}
