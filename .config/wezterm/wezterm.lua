-- Tarrex's WezTerm config file.

local wezterm = require 'wezterm'

local nerdfonts = wezterm.nerdfonts
local act       = wezterm.action

local config = {}

local icon_sub = {
  '₁',  '₂',  '₃',  '₄',  '₅',  '₆',  '₇',  '₈',  '₉',  '₁₀',
  '₁₁', '₁₂', '₁₃', '₁₄', '₁₅', '₁₆', '₁₇', '₁₈', '₁₉', '₂₀'
}
local icon_sup = {
  '¹',  '²',  '³',  '⁴',  '⁵',  '⁶',  '⁷',  '⁸',  '⁹',  '¹⁰',
  '¹¹', '¹²', '¹³', '¹⁴', '¹⁵', '¹⁶', '¹⁷', '¹⁸', '¹⁹', '²⁰'
}

local tab_title = function(tab)
  local title = tab.tab_title
  if title and #title > 0 then
    return title
  end
  return tab.active_pane.title
end

wezterm.on('format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local edge_background = '#2E3133'

    -- nord theme
    local background = '#3B4252'
    local foreground = '#5E81AC'
    if tab.is_active then
      background = '#4C566A'
      foreground = '#8FBCBB'
    elseif hover then
      background = '#434C5E'
      foreground = '#88C0D0'
    end
    -- local dim_foreground = '#81A1C1'

    local title = tab_title(tab)

    local icon = nerdfonts.dev_terminal

    if title == 'git' then
      icon = nerdfonts.dev_git
    elseif title == 'gh' then
      icon = nerdfonts.dev_github_badge
    elseif title == 'docker' then
      icon = nerdfonts.dev_docker
    elseif title == 'go' then
      title = nerdfonts.dev_go
    elseif title == 'python' then
      title = nerdfonts.dev_python
    elseif title == 'jupyter' then
      title = nerdfonts.cod_notebook
    elseif title == 'rustc' then
      title = nerdfonts.dev_rust
    elseif title == 'postgres' then
      title = nerdfonts.dev_postgresql
    elseif title == 'redis' then
      title = nerdfonts.dev_redis
    elseif title == 'nvim' or title == 'vim' then
      icon = nerdfonts.dev_vim
    elseif title == 'bat' or title == 'less' or title == 'more' then
      icon = nerdfonts.cod_file
    elseif title == 'find' or title == 'fzf' or title == 'rg' then
      icon = nerdfonts.cod_search
    elseif title == 'ssh' or title == 'scp' then
      icon = nerdfonts.cod_server
    elseif title == 'cp' then
      icon = nerdfonts.mdi_content_copy
    elseif title == 'mv' then
      icon = nerdfonts.mdi_content_cut
    elseif title == 'rm' then
      icon = nerdfonts.cod_trash
    end

    title = icon .. ' ' .. title

    local pane = tab.active_pane
    if pane.is_zoomed then
      title = title .. ' ' .. nerdfonts.cod_screen_full
    end

    local tid = icon_sub[tab.tab_index + 1]
    local pid = icon_sup[pane.pane_index + 1]
    title = ' ' .. wezterm.truncate_right(title, max_width - 2) .. ' '

    return {
      { Attribute = { Intensity='Bold' }},
      { Background = { Color = edge_background }},
      { Text=' ' },
      { Background = { Color = background }},
      { Foreground = { Color = foreground }},
      { Text = tid } ,
      { Text = title },
      -- { Foreground = { Color = dim_foreground }},
      { Text = pid },
      { Attribute = { Intensity = 'Normal' }},
    }
  end
)

-- Colors & Appearance
config.color_scheme = 'GruvboxDarkHard'

-- config.colors = {
--   background = '#1E1E1E'
-- }

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 2,
  right = 2,
  top = 0,
  bottom = 0,
}

config.window_background_opacity = 0.8
-- config.macos_window_background_blur = 20
config.window_decorations = 'RESIZE'

config.text_background_opacity = 0.9
config.foreground_text_hsb = {
  hue = 1.0,
  saturation = 1.0,
  brightness = 1.4,
}

config.default_cursor_style = 'SteadyBar'
-- config.default_cursor_style = 'BlinkingBar'
-- config.animation_fps = 1

config.native_macos_fullscreen_mode = false
config.force_reverse_video_cursor = true
config.initial_cols = 120
config.initial_rows = 40
config.command_palette_font_size = 16.0
config.switch_to_last_active_tab_when_closing_tab = true

-- Laughing Programs
config.default_cwd = wezterm.home_dir

-- Fonts
config.font = wezterm.font_with_fallback({
  {
    family = 'JetBrains Mono',
    stretch = 'Expanded',
    weight = 'Regular',
    harfbuzz_features = { 'calt=0', 'clig=1', 'liga=1' },
  },
  'Symbols Nerd Font Mono',
  'PingFang SC',
  'HanaMinB',
  'Apple Color Emoji',
  'Noto Color Emoji'
})
config.font_size = 19.0
config.line_height = 1.0

-- Key Binding
config.keys = {
  { key = 'l',     mods = 'SUPER', action = act.ShowLauncher },
  { key = 'L',     mods = 'SUPER', action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS|DOMAINS' }) },
  { key = 'Enter', mods = 'SUPER', action = act.ToggleFullScreen },
  { key = 'z',     mods = 'SUPER', action = act.TogglePaneZoomState },
  { key = 's',     mods = 'SUPER', action = act.ShowTabNavigator },
  { key = 'w',     mods = 'SUPER', action = act.CloseCurrentPane({ confirm = false }) },
  { key = 'H',     mods = 'SUPER', action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
  { key = 'V',     mods = 'SUPER', action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
  { key = '[',     mods = 'SUPER', action = act.ActivatePaneDirection('Prev') },
  { key = ']',     mods = 'SUPER', action = act.ActivatePaneDirection('Next') },
  { key = 'P',     mods = 'SUPER', action = act.ActivateCommandPalette },
}

-- Additional
config.scrollback_lines = 100000
config.clean_exit_codes = { 0, 1, 130 }
config.exit_behavior = 'Close'
config.quote_dropped_files = 'Posix'

-- Update
config.check_for_updates = false

return config
