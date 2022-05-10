local env = vim.env
local fn  = vim.fn
local opt = vim.opt

opt.number = true
opt.ruler = false
opt.wrap = false
opt.foldenable = false
opt.modeline = true
opt.showcmd = true
opt.showmode = false
if fn.getfsize(fn.expand('%')) < 10 * 1024 * 1024 then
    opt.cursorline = true
    opt.cursorlineopt = 'number'
end
opt.signcolumn = 'number'
if env.TERM_PROGRAM ~= 'Apple_Terminal' then
    opt.termguicolors = true
end

opt.shiftround = true
opt.shiftwidth = 4
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4

opt.linebreak = true
opt.breakindent = true
opt.showbreak = '↪ '

opt.ignorecase = true
opt.smartcase = true

opt.fileencodings = { 'ucs-bom', 'utf-8', 'gbk', 'gb18030', 'big5', 'latin1' }
opt.fileformats = { 'unix', 'dos', 'mac' }

opt.autowrite = true
opt.lazyredraw = false
opt.splitbelow = true
opt.splitright = true
opt.clipboard = { 'unnamed', 'unnamedplus' }
opt.mouse = { a = true }
opt.scrolloff = 1
opt.sidescroll = 5
opt.sidescrolloff = 1

opt.timeoutlen = 3000
opt.ttimeoutlen = 6
opt.updatetime = 250

opt.comments = ''
opt.commentstring = ''
opt.include = ''
opt.complete:append('k')
opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' }
opt.diffopt:append('context:3')
opt.diffopt:append('vertical')
opt.diffopt:append('foldcolumn:1')
opt.diffopt:append('hiddenoff')
opt.diffopt:append('indent-heuristic')
opt.diffopt:append('algorithm:patience')
opt.formatoptions:append({
  m = true,
  B = true,
  j = true
})
opt.shortmess = {
  a = true,
  o = true,
  O = true,
  c = true,
  F = true
}
opt.spelloptions = 'camel'
opt.fillchars = { vert = '┃' }
opt.listchars = {
  eol      = '¬',
  tab      = '| ',
  extends  = '❯',
  precedes = '❮',
  nbsp     = '∅'
}
opt.breakat:append({
  [')'] = true,
  [']'] = true,
  ['}'] = true,
})
opt.virtualedit = 'block'
opt.whichwrap = {
  b = true,
  h = true,
  l = true,
  s = true,
  ['<'] = true,
  ['>'] = true,
  ['['] = true,
  [']'] = true
}
opt.matchpairs:append({ '<:>', '《:》', '「:」', '（:）', '【:】' })

opt.dictionary:append('/usr/share/dict/words')
opt.path = { '.', '**5' }
opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.wildignorecase = true
opt.wildignore = {
  '*.app', '*.dll', '*.dylib', '*.elf', '*.exe', '*.lib', '*.map', '*.o', '*.out', '*.so',
  '*.class', '*.egg', '*.gem', '*.jar', '*.pdb', '*.py[cdo]', '*.swp', '*.war', '*~',
  '*.7z', '*.bz2', '*.bzip', '*.bzip2', '*.cab', '*.deb', '*.dmg', '*.gz', '*.gzip',
  '*.iso', '*.lzma', '*.msi', '*.rar', '*.rpm', '*.tar', '*.tgz', '*.xz', '*.zip',
  '*.bmp', '*.gif', '*.ico', '*.jpeg', '*.jpg', '*.png', '*.tiff', '*.webp', '*.pdf',
  '*.aac', '*.ape', '*.avi', '*.flac', '*.flv', '*.mkv', '*.mp3', '*.mp4', '*.webm',
  '._*', '.DS_Store', '.fseventsd', '.Spotlight-V100', '.Trashes',
  '[Dd]esktop.ini', '*.lnk', '$RECYCLE.BIN/*', '*.stackdump', 'Thumbs.db',
  '.git/*', '.github/*', '.hg/*', '.idea/*', '.svn/*', '.vscode/*',
}

opt.wildoptions = 'pum'
opt.winblend = 0
opt.pumblend = 5
