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
      stretch = 'Expanded',
      weight = 'Regular',
      harfbuzz_features = { 'calt=0', 'clig=1', 'liga=1' },
    },
    'PingFang SC',
  }),
  font_size = 19.0,
  line_height = 1.0,

  -- Key Binding
  keys = {
    { key = 'l',     mods = 'SUPER', action = 'ShowLauncher' },
    { key = 'Enter', mods = 'SUPER', action = 'ToggleFullScreen' },
    { key = 'w',     mods = 'SUPER', action = wezterm.action({ CloseCurrentPane = { confirm = false } }) },
    { key = '\\',    mods = 'SUPER', action = wezterm.action({ SplitHorizontal = { domain = 'CurrentPaneDomain' } }) },
    { key = '-',     mods = 'SUPER', action = wezterm.action({ SplitVertical = { domain = 'CurrentPaneDomain' } }) },
    { key = '[',     mods = 'SUPER', action = wezterm.action({ ActivatePaneDirection = 'Prev' }) },
    { key = ']',     mods = 'SUPER', action = wezterm.action({ ActivatePaneDirection = 'Next' }) },
  },

  -- Mouse Binding
  -- mouse_bindings = {},

  -- Colors & Appearance
  use_fancy_tab_bar = false,
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = false,
  window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
  },

  window_background_opacity = 0.9,
  window_decorations = 'RESIZE',
  -- window_close_confirmation = 'NeverPrompt',
  -- window_background_image = wezterm.config_dir .. '/wallpaper.jpeg',
  -- window_background_image_hsb = {
  --   hue = 1.0,
  --   saturation = 1.0,
  --   brightness = 0.1,
  -- },

  text_background_opacity = 0.9,
  foreground_text_hsb = {
    hue = 1.0,
    saturation = 1.0,
    brightness = 1.4,
  },

  default_cursor_style = 'BlinkingBar',
  cursor_blink_rate = 800,
  cursor_blink_ease_in = 'EaseIn',
  cursor_blink_ease_out = 'EaseOut',

  native_macos_fullscreen_mode = false,
  force_reverse_video_cursor = true,
  initial_cols = 120,
  initial_rows = 40,

  -- Color Schemes
  color_scheme = 'Gruvbox Dark',

  -- Additional Options
  scrollback_lines = 100000,
  clean_exit_codes = { 0, 1, 130 },
  exit_behavior = 'Close',

  -- quick select mode
  quick_select_patterns = {
    -- match things that look like sha1 hashes
    '[0-9a-f]{7,40}',
  },

  -- Hyperlinks
  hyperlink_rules = {
    -- Linkify things that look like URLs
    {
      regex = '\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b',
      format = '$0',
    },

    -- linkify email addresses
    {
      regex = '\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b',
      format = 'mailto:$0',
    },

    -- file:// URI
    {
      regex = '\\bfile://\\S*\\b',
      format = '$0',
    },
  },

  -- Update
  check_for_updates = false,
}
