local ok, lualine = pcall(require, 'lualine')
if not ok then return end

local get_opt     = vim.api.nvim_get_option
local get_win_opt = vim.api.nvim_win_get_option
local win_width   = vim.api.nvim_win_get_width

local paste = function()
  if get_opt('paste') == true then
    return 'paste'
  end
end

local spell = function()
  if get_win_opt(0, 'spell') == true then
    return get_opt('spelllang') or 'spell'
  end
end

local filename = function()
  local file = ''
  if win_width(0) < 50 then
    file = vim.fn.expand('%:t')
  elseif win_width(0) > 150 then
    file = vim.fn.expand('%')
  else
    file = vim.fn.pathshorten(vim.fn.expand('%'))
  end
  return file
end

local config = {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = '|',
    section_separators = '',
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {
      'mode',
      {
        paste,
        cond = function() return get_opt('paste') == true end
      },
      {
        spell,
        cond = function() return get_win_opt(0, 'spell') == true end
      }
    },
    lualine_b = { '%n' },
    lualine_c = {
      {
        filename,
        symbols = {
          modified = '[+]',
          readonly = '[RO]',
          unmapped = '[No Name]',
        }
      },
    },
    lualine_x = {
      'diagnostics',
      'diff',
      'filesize',
      'fileformat',
      'encoding',
      {
        'filetype',
        colored = true,
        icon_only = false
      },
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = { 'mode' },
    lualine_b = { '%n' },
    lualine_c = { filename },
    lualine_x = {},
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  tabline = {},
  extensions = { 'quickfix', 'fugitive' }
}

lualine.setup(config)
