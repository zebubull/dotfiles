local wezterm = require 'wezterm'
local config = {}
local act = wezterm.action

---@param file file*
local function set_colors(file)
  local lines = {}
  for l in file:lines() do
    lines[#lines+1] = l
  end
  file:close()
  if #lines ~= 16 then
    print('invalid color file')
    return
  end
  local bg = lines[1]
  local fg = lines[16]
  config.colors = {
    ansi = {
      lines[1], lines[2], lines[3], lines[4], lines[5], lines[6], lines[7], lines[8],
    },
    brights = {
      lines[9], lines[10], lines[11], lines[12], lines[13], lines[14], lines[15], lines[16],
    },

    foreground = fg,
    background = bg,

    cursor_border = fg,
    cursor_bg = fg,
    cursor_fg = bg,
    selection_bg = fg,
    selection_fg = bg,

    tab_bar = {
      background = bg,
      active_tab = {
        bg_color = fg,
        fg_color = bg,
      },
      inactive_tab = {
        bg_color = bg,
        fg_color = fg,
      },
      new_tab = {
        bg_color = bg,
        fg_color = bg,
      },
      new_tab_hover = {
        bg_color = bg,
        fg_color = bg,
      },
    }
  }
end

local color_file = io.open("/home/zebu/.cache/wal/colors", "r")
if color_file == nil then print("failed to locate wal colors") else set_colors(color_file) end

config.font = wezterm.font 'DejaVuSansM Nerd Font Mono'
config.font_size = 20.0

config.window_background_opacity = 0.92
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.disable_default_key_bindings = true
config.default_cursor_style = 'SteadyBlock'

config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

config.keys = {
  { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard'},
  { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard'},

  { key = 'T', mods = 'SHIFT|CTRL', action = act.SpawnTab 'CurrentPaneDomain'},
  { key = 'W', mods = 'SHIFT|CTRL', action = act.CloseCurrentTab{confirm=true}},
  { key = 'H', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1)},
  { key = 'L', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(1)},

  { key = 'V', mods = 'SHIFT|CTRL', action = act.SplitVertical{domain='CurrentPaneDomain'}},
  { key = 'S', mods = 'SHIFT|CTRL', action = act.SplitHorizontal{domain='CurrentPaneDomain'}},
  { key = 'UpArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Up'},
  { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Down'},
  { key = 'LeftArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Left'},
  { key = 'RightArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Right'},
  { key = 'UpArrow', mods = 'CTRL', action = act.AdjustPaneSize {'Up', 1}},
  { key = 'DownArrow', mods = 'CTRL', action = act.AdjustPaneSize {'Down', 1}},
  { key = 'LeftArrow', mods = 'CTRL', action = act.AdjustPaneSize {'Left', 1}},
  { key = 'RightArrow', mods = 'CTRL', action = act.AdjustPaneSize {'Right', 1}},
  { key = 'r', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration},
}

return config
