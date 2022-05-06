local M = {}

local api = vim.api
local fn  = vim.fn

-- ostype
M.ostype = {
  mac   = fn.has('mac') == 1 or fn.has('macunix') == 1,
  linux = fn.has('linux') == 1
}

-- depedencies
M.dep = {
  rg   = fn.executable('rg') == 1,
  curl = fn.executable('curl') == 1,
  node = fn.executable('node') == 1
}

-- keymap
M.set_keymap = api.nvim_set_keymap
M.set_buf_keymap = api.nvim_buf_set_keymap

local function _map(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  M.set_keymap(mode, lhs, rhs, opts)
end

function M.map(lhs, rhs, opts)
  _map('' , lhs, rhs, opts)
end

function M.nmap(lhs, rhs, opts)
  _map('n', lhs, rhs, opts)
end

function M.imap(lhs, rhs, opts)
  _map('i', lhs, rhs, opts)
end

function M.vmap(lhs, rhs, opts)
  _map('v', lhs, rhs, opts)
end

function M.cmap(lhs, rhs, opts)
  _map('c', lhs, rhs, opts)
end

function M.tmap(lhs, rhs, opts)
  _map('t', lhs, rhs, opts)
end

function M.xmap(lhs, rhs, opts)
  _map('x', lhs, rhs, opts)
end

function M.omap(lhs, rhs, opts)
  _map('o', lhs, rhs, opts)
end

function M.buf_map(bufnr, mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  M.set_buf_keymap(bufnr, mode, lhs, rhs, opts)
end

-- hightlight
M.set_hl = api.nvim_set_hl
function M.hightlight(name, opts)
  opts = opts or {}
  M.set_hl(0, name, opts)
end

-- package
function M.has_package(name)
  return package.loaded[name] ~= nil
end

-- executable
function M.executable(name)
  if vim.fn.executable(name) > 0 then
    return true
  end
  return false
end

return M
