-- Tarrex's WezTerm config file.

local wezterm = require 'wezterm'

return {
  -- Laughing Programs
  default_cwd = wezterm.home_dir .. '/Workspace',

  -- Fonts
  font = wezterm.font_with_fallback({
    {
      -- family = 'JetBrains Mono',
      family = 'SF Mono',
      weight = 'Regular',
      harfbuzz_features = { 'calt=0', 'clig=1', 'liga=1' },
    },
    'PingFang SC',
  }),
  font_size = 19.0,
  line_height = 1.0,

  -- Key Binding
  use_ime = true,
  keys = {
    { key = 'l',  mods = 'SUPER', action = 'ShowLauncher' },
    { key = 'w',  mods = 'SUPER', action = wezterm.action({ CloseCurrentPane = { confirm = false } }) },
    { key = '\\', mods = 'SUPER', action = wezterm.action{ SplitHorizontal = { domain = 'CurrentPaneDomain' } } },
    { key = '-',  mods = 'SUPER', action = wezterm.action{ SplitVertical = { domain = 'CurrentPaneDomain' } } },
  },

  -- Mouse Binding
  -- mouse_bindings = {},

  -- Colors & Appearance
  use_fancy_tab_bar = false,
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = false,
  window_padding = {
    left = 4,
    right = 4,
    top = 2,
    bottom = 2,
  },
  -- window_decorations = 'RESIZE',
  window_background_opacity = 0.9,
  text_background_opacity = 0.9,

  native_macos_fullscreen_mode = true,
  force_reverse_video_cursor = true,
  initial_cols = 80,
  initial_rows = 40,

  -- Color Schemes
  color_scheme = 'Gruvbox Dark',

  -- Additional Options
  -- scrollback
  scrollback_lines = 100000,

  -- quick select mode
  quick_select_patterns = {
    -- match things that look like sha1 hashes
    '[0-9a-f]{7,40}',
  },

  -- Hyperlinks
  hyperlink_rules = {
    -- Linkify things that look like URLs
    {
      regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b",
      format = "$0",
    },

    -- linkify email addresses
    {
      regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
      format = "mailto:$0",
    },

    -- file:// URI
    {
      regex = "\\bfile://\\S*\\b",
      format = "$0",
    },
  },

  -- Update
  check_for_updates = false,
}
