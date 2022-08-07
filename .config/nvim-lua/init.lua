-- Tarrex's neovim config.
local ok, impatient = pcall(require, 'impatient')
if ok then impatient.enable_profile() end
require('options')
require('plugins')
require('keymaps')
require('custom')
